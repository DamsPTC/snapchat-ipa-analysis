#import "NDCore.h"

static id first, second, third, fourth;
static id readResult;
static double receivedTime;
static NSUInteger calls, callbacks;
static BOOL sawNullStatus, throwFromOriginal;
#define CHECK(c) do { if (!(c)) { NSLog(@"Failed at line %d: %s", __LINE__, #c); exit(1); } } while (0)

@interface UNISCJanusLoginService : NSObject
- (void)loginWithPasswordWithRequest:(id)request callOptionsBuilder:(id)options handler:(void (^)(void))handler;
- (void)appLoginWithRequest:(id)request callOptionsBuilder:(id)options handler:(void (^)(void))handler;
@end
@implementation UNISCJanusLoginService
- (void)loginWithPasswordWithRequest:(id)request callOptionsBuilder:(id)options handler:(void (^)(void))handler {
    ++calls; first = request; second = options; third = handler; if (handler) handler();
}
- (void)appLoginWithRequest:(id)request callOptionsBuilder:(id)options handler:(void (^)(void))handler {
    ++calls; first = request; second = options; third = handler; if (handler) handler();
}
@end

@interface SCLoginJanusService : NSObject
- (void)_loginWithPasswordResponseWithResponse:(id)response error:(NSError *)error usernameOrEmail:(id)username
    tempIdentity:(id)identity submitRequestTime:(double)time success:(void (^)(void))success failure:(void (^)(void))failure;
- (void)_appLoginResondWithResponse:(id)response error:(NSError *)error submitRequestTime:(double)time
    completion:(void (^)(id, NSError *))completion;
@end
@implementation SCLoginJanusService
- (void)_loginWithPasswordResponseWithResponse:(id)response error:(NSError *)error usernameOrEmail:(id)username
    tempIdentity:(id)identity submitRequestTime:(double)time success:(void (^)(void))success failure:(void (^)(void))failure {
    ++calls; first = response; second = error; third = username; fourth = identity; receivedTime = time;
    if (throwFromOriginal) [NSException raise:@"native_exception" format:@"test"];
    if (error) { if (failure) failure(); } else { if (success) success(); }
}
- (void)_appLoginResondWithResponse:(id)response error:(NSError *)error submitRequestTime:(double)time
    completion:(void (^)(id, NSError *))completion {
    ++calls; first = response; second = error; receivedTime = time;
    if (completion) completion(response, error);
}
@end

@interface SCKeychainManager : NSObject
+ (id)dataForKey:(id)key status:(int *)status;
+ (int)setDataWithStatus:(id)data forKey:(id)key;
+ (int)setBackgroundDataWithStatus:(id)data forKey:(id)key;
@end
@implementation SCKeychainManager
+ (id)dataForKey:(id)key status:(int *)status {
    ++calls; first = key; sawNullStatus = status == NULL;
    if (status) *status = -34018;
    return readResult;
}
+ (int)setDataWithStatus:(id)data forKey:(id)key {
    ++calls; first = data; second = key; return -25299;
}
+ (int)setBackgroundDataWithStatus:(id)data forKey:(id)key {
    ++calls; first = data; second = key; return -34018;
}
@end

@interface NDTestResponse : NSObject
@property(nonatomic) int statusCode;
@end
@implementation NDTestResponse
- (NSString *)description { [NSException raise:@"do_not_serialize_response" format:@"test"]; return nil; }
@end
@interface NDThrowingResponse : NDTestResponse
@end
@implementation NDThrowingResponse
- (int)statusCode { [NSException raise:@"diagnostic_getter_failure" format:@"test"]; return 0; }
@end

int main(void) {
    @autoreleasepool {
        NDInstallObservers();
        NDInstallObservers(); // Must not install a second layer or recurse.
        NSDictionary *snapshot = NDSnapshot();
        CHECK([snapshot[@"coverage"] count] == 7);
        for (NSString *state in [snapshot[@"coverage"] allValues]) CHECK([state isEqual:@"installed"]);
        id credential = @"super-secret-credential", identity = @"super-secret-identity";
        id request = @{@"password":credential}, options = [NSObject new];
        void (^handler)(void) = ^{ ++callbacks; };
        UNISCJanusLoginService *sender = [UNISCJanusLoginService new];
        [sender loginWithPasswordWithRequest:request callOptionsBuilder:options handler:handler];
        CHECK(calls == 1 && callbacks == 1 && first == request && second == options && third == handler);
        [sender appLoginWithRequest:request callOptionsBuilder:options handler:handler];
        CHECK(calls == 2 && callbacks == 2 && first == request && second == options && third == handler);
        [sender loginWithPasswordWithRequest:nil callOptionsBuilder:nil handler:nil];
        CHECK(calls == 3 && first == nil && second == nil && third == nil);

        NDTestResponse *response = [NDTestResponse new]; response.statusCode = 9;
        NSError *error = [NSError errorWithDomain:@"super-secret-domain" code:16
            userInfo:@{NSLocalizedDescriptionKey:credential, @"token":identity}];
        SCLoginJanusService *service = [SCLoginJanusService new];
        [service _loginWithPasswordResponseWithResponse:response error:error usernameOrEmail:credential
            tempIdentity:identity submitRequestTime:1234.625 success:^{ CHECK(NO); } failure:handler];
        CHECK(calls == 4 && callbacks == 3 && first == response && second == error &&
            third == credential && fourth == identity && receivedTime == 1234.625);
        NSDictionary *last = [NDSnapshot()[@"events"] lastObject];
        CHECK([last[@"proto_status"] intValue] == 9 && [last[@"transport_error_code"] intValue] == 16);
        CHECK([last[@"transport_error_domain"] isEqual:@"other"]);
        [service _loginWithPasswordResponseWithResponse:response error:nil usernameOrEmail:credential
            tempIdentity:identity submitRequestTime:0.125 success:handler failure:^{ CHECK(NO); }];
        CHECK(calls == 5 && callbacks == 4 && second == nil && receivedTime == 0.125);
        [service _appLoginResondWithResponse:response error:error submitRequestTime:56.75 completion:^(id r, NSError *e) {
            CHECK(r == response && e == error); ++callbacks;
        }];
        CHECK(calls == 6 && callbacks == 5 && receivedTime == 56.75);

        [service _loginWithPasswordResponseWithResponse:[NDThrowingResponse new] error:error usernameOrEmail:credential
            tempIdentity:identity submitRequestTime:1.0 success:nil failure:handler];
        CHECK(calls == 7 && callbacks == 6);
        CHECK([[NDSnapshot()[@"events"] lastObject][@"event"] isEqual:@"observation_unavailable"]);
        throwFromOriginal = YES;
        BOOL propagated = NO;
        @try {
            [service _loginWithPasswordResponseWithResponse:response error:nil usernameOrEmail:nil
                tempIdentity:nil submitRequestTime:0 success:nil failure:nil];
        } @catch (NSException *exception) { propagated = [exception.name isEqual:@"native_exception"]; }
        CHECK(propagated); throwFromOriginal = NO;

        readResult = [@"super-secret-keychain-value" dataUsingEncoding:NSUTF8StringEncoding];
        int status = 99;
        CHECK([SCKeychainManager dataForKey:credential status:&status] == readResult);
        CHECK(status == -34018 && first == credential && !sawNullStatus);
        CHECK([SCKeychainManager dataForKey:credential status:NULL] == readResult && sawNullStatus);
        CHECK([SCKeychainManager setDataWithStatus:readResult forKey:credential] == -25299);
        CHECK(first == readResult && second == credential);
        CHECK([SCKeychainManager setBackgroundDataWithStatus:readResult forKey:credential] == -34018);
        CHECK(first == readResult && second == credential);

        NSData *json = [NSJSONSerialization dataWithJSONObject:NDSnapshot() options:0 error:NULL];
        NSString *text = [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
        CHECK(text && [text rangeOfString:@"super-secret"].location == NSNotFound);
        for (int i = 0; i < 100; ++i) [SCKeychainManager dataForKey:credential status:&status];
        CHECK([NDSnapshot()[@"events"] count] == 80);
        puts("PASS: seven native methods observed; arguments, returns, callbacks, nil, double ABI, exceptions, privacy and event bound verified.");
    }
    return 0;
}
