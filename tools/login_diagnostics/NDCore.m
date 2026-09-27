#import "NDCore.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import <mach-o/dyld.h>
#import <dlfcn.h>
#import <stdatomic.h>
#import <string.h>
#import <stdlib.h>

#ifndef ND_BUILD_ID
#define ND_BUILD_ID "development"
#endif

static NSObject *lock;
static NSMutableArray *events;
static NSMutableDictionary *coverage;
static NSUInteger sequence;
static NSDictionary *lastResponse;
static NSNumber *lastKeychainError;
static _Atomic(IMP) passwordSend, appSend, passwordResponse, appResponse;
static _Atomic(IMP) keychainRead, keychainWrite, keychainBackgroundWrite;

static void ensureState(void) {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        lock = [NSObject new];
        events = [NSMutableArray new];
        coverage = [NSMutableDictionary new];
    });
}

static void record(NSString *kind, NSDictionary *fields) {
    @try {
        ensureState();
        @synchronized (lock) {
            NSMutableDictionary *event = [fields mutableCopy];
            event[@"event"] = kind;
            event[@"sequence"] = @(++sequence);
            [events addObject:[event copy]];
            if ([kind isEqual:@"login_dispatch"] || [kind isEqual:@"observation_unavailable"]) lastResponse = nil;
            if ([kind isEqual:@"login_response"]) lastResponse = [event copy];
            if ([kind isEqual:@"keychain_status"] && [fields[@"status"] intValue] != 0 &&
                [fields[@"status"] intValue] != -25300) lastKeychainError = fields[@"status"];
            if (events.count > 80) [events removeObjectAtIndex:0];
        }
    } @catch (__unused NSException *exception) {
        // Diagnostic failures must not consume an application callback.
    }
}

static const char *unqualified(const char *type) {
    while (*type && strchr("rnNoORV", *type)) ++type;
    return type;
}

static NSNumber *integerProperty(id object, SEL selector) {
    if (!object || ![object respondsToSelector:selector]) return nil;
    NSMethodSignature *signature = [object methodSignatureForSelector:selector];
    if (!signature || signature.numberOfArguments != 2) return nil;
    const char *type = unqualified(signature.methodReturnType);
    switch (*type) {
        case 'i': return @(((int (*)(id, SEL))objc_msgSend)(object, selector));
        case 'I': return @(((unsigned int (*)(id, SEL))objc_msgSend)(object, selector));
        case 'q': return @(((long long (*)(id, SEL))objc_msgSend)(object, selector));
        case 'Q': return @(((unsigned long long (*)(id, SEL))objc_msgSend)(object, selector));
        case 'l': return @(((long (*)(id, SEL))objc_msgSend)(object, selector));
        case 'L': return @(((unsigned long (*)(id, SEL))objc_msgSend)(object, selector));
        default: return nil;
    }
}

static void observeResponse(NSString *path, id response, NSError *error) {
    @try {
        NSMutableDictionary *fields = [@{@"path":path,
            @"response_present":@(response != nil), @"error_present":@(error != nil)} mutableCopy];
        NSNumber *status = integerProperty(response, sel_registerName("statusCode"));
        if (status) fields[@"proto_status"] = status;
        if ([error isKindOfClass:[NSError class]]) {
            fields[@"transport_error_code"] = @(error.code);
            // Unknown domains are deliberately not copied: they may be app data.
            NSSet *known = [NSSet setWithArray:@[NSURLErrorDomain, NSCocoaErrorDomain,
                NSPOSIXErrorDomain, NSOSStatusErrorDomain, @"io.grpc", @"gRPC",
                @"GRPCErrorDomain", @"kGRPCErrorDomain"]];
            fields[@"transport_error_domain"] = [known containsObject:error.domain] ? error.domain : @"other";
        }
        record(@"login_response", fields);
    } @catch (__unused NSException *exception) {
        record(@"observation_unavailable", @{@"path":path});
    }
}

typedef void (*Send)(id, SEL, id, id, id);
typedef void (*PasswordResponse)(id, SEL, id, id, id, id, double, id, id);
typedef void (*AppResponse)(id, SEL, id, id, double, id);
typedef id (*Read)(id, SEL, id, int *);
typedef int (*Write)(id, SEL, id, id);

static void observePasswordSend(id self, SEL cmd, id request, id options, id handler) {
    record(@"login_dispatch", @{@"path":@"password"});
    ((Send)atomic_load(&passwordSend))(self, cmd, request, options, handler);
}
static void observeAppSend(id self, SEL cmd, id request, id options, id handler) {
    record(@"login_dispatch", @{@"path":@"app_login"});
    ((Send)atomic_load(&appSend))(self, cmd, request, options, handler);
}
static void observePasswordResponse(id self, SEL cmd, id response, id error, id username,
                                    id identity, double time, id success, id failure) {
    observeResponse(@"password", response, error);
    ((PasswordResponse)atomic_load(&passwordResponse))(self, cmd, response, error,
        username, identity, time, success, failure);
}
static void observeAppResponse(id self, SEL cmd, id response, id error, double time, id completion) {
    observeResponse(@"app_login", response, error);
    ((AppResponse)atomic_load(&appResponse))(self, cmd, response, error, time, completion);
}
static id observeRead(id self, SEL cmd, id key, int *status) {
    id result = ((Read)atomic_load(&keychainRead))(self, cmd, key, status);
    if (status) record(@"keychain_status", @{@"operation":@"read", @"status":@(*status)});
    return result;
}
static int observeWrite(id self, SEL cmd, id data, id key) {
    int result = ((Write)atomic_load(&keychainWrite))(self, cmd, data, key);
    record(@"keychain_status", @{@"operation":@"write", @"status":@(result)});
    return result;
}
static int observeBackgroundWrite(id self, SEL cmd, id data, id key) {
    int result = ((Write)atomic_load(&keychainBackgroundWrite))(self, cmd, data, key);
    record(@"keychain_status", @{@"operation":@"background_write", @"status":@(result)});
    return result;
}

static BOOL sameType(const char *actual, const char *expected) {
    actual = unqualified(actual);
    expected = unqualified(expected);
    // Both block and ordinary object pointers use the same argument ABI.
    if (*expected == '@') return *actual == '@';
    return strcmp(actual, expected) == 0;
}

static void install(NSString *name, const char *className, BOOL isClassMethod,
                    const char *selectorName, const char *encoding, IMP replacement,
                    _Atomic(IMP) *original) {
    NSString *state = @"class_missing";
    @try {
        Class cls = objc_getClass(className);
        Class target = isClassMethod ? object_getClass(cls) : cls;
        Method method = NULL;
        SEL selector = sel_registerName(selectorName);
        if (target) {
            state = @"method_missing";
            unsigned count = 0;
            Method *methods = class_copyMethodList(target, &count);
            for (unsigned i = 0; i < count; ++i) {
                if (method_getName(methods[i]) == selector) { method = methods[i]; break; }
            }
            free(methods);
        }
        if (method) {
            state = @"signature_mismatch";
            NSMethodSignature *actual = [NSMethodSignature signatureWithObjCTypes:method_getTypeEncoding(method)];
            NSMethodSignature *expected = [NSMethodSignature signatureWithObjCTypes:encoding];
            BOOL matches = actual.numberOfArguments == expected.numberOfArguments &&
                sameType(actual.methodReturnType, expected.methodReturnType);
            for (NSUInteger i = 0; matches && i < expected.numberOfArguments; ++i)
                matches = sameType([actual getArgumentTypeAtIndex:i], [expected getArgumentTypeAtIndex:i]);
            if (matches) {
                IMP prior = method_getImplementation(method);
                Dl_info info = {0};
                state = @"implementation_outside_main";
                if (dladdr((const void *)prior, &info) && info.dli_fbase == (const void *)_dyld_get_image_header(0)) {
                    atomic_store(original, prior);
                    IMP replaced = method_setImplementation(method, replacement);
                    atomic_store(original, replaced);
                    state = @"installed";
                }
            }
        }
    } @catch (__unused NSException *exception) { state = @"installation_exception"; }
    @synchronized (lock) { coverage[name] = state; }
}

void NDInstallObservers(void) {
    ensureState();
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        install(@"password_send", "UNISCJanusLoginService", NO,
            "loginWithPasswordWithRequest:callOptionsBuilder:handler:", "v40@0:8@16@24@?32",
            (IMP)observePasswordSend, &passwordSend);
        install(@"app_send", "UNISCJanusLoginService", NO,
            "appLoginWithRequest:callOptionsBuilder:handler:", "v40@0:8@16@24@?32",
            (IMP)observeAppSend, &appSend);
        install(@"password_response", "SCLoginJanusService", NO,
            "_loginWithPasswordResponseWithResponse:error:usernameOrEmail:tempIdentity:submitRequestTime:success:failure:",
            "v72@0:8@16@24@32@40d48@?56@?64", (IMP)observePasswordResponse, &passwordResponse);
        install(@"app_response", "SCLoginJanusService", NO,
            "_appLoginResondWithResponse:error:submitRequestTime:completion:",
            "v48@0:8@16@24d32@?40", (IMP)observeAppResponse, &appResponse);
        install(@"keychain_read", "SCKeychainManager", YES, "dataForKey:status:",
            "@32@0:8@16^i24", (IMP)observeRead, &keychainRead);
        install(@"keychain_write", "SCKeychainManager", YES, "setDataWithStatus:forKey:",
            "i32@0:8@16@24", (IMP)observeWrite, &keychainWrite);
        install(@"keychain_background_write", "SCKeychainManager", YES, "setBackgroundDataWithStatus:forKey:",
            "i32@0:8@16@24", (IMP)observeBackgroundWrite, &keychainBackgroundWrite);
    });
}

NSDictionary *NDSnapshot(void) {
    ensureState();
    @synchronized (lock) {
        NSMutableDictionary *result = [@{@"format":@1, @"build":@ND_BUILD_ID, @"mode":@"local_observation_only",
            @"coverage":[coverage copy], @"events":[events copy]} mutableCopy];
        if (lastResponse) result[@"last_login_response"] = lastResponse;
        if (lastKeychainError) result[@"last_keychain_error"] = lastKeychainError;
        return [result copy];
    }
}
