#import "NDCore.h"
#import <fcntl.h>
#import <unistd.h>
#import <sys/stat.h>
#import <string.h>

static uint32_t word(const uint8_t *bytes, NSUInteger offset, BOOL bigEndian) {
    uint32_t value;
    memcpy(&value, bytes + offset, 4);
    return bigEndian ? CFSwapInt32BigToHost(value) : CFSwapInt32LittleToHost(value);
}
static BOOL identifier(id value) {
    if (![value isKindOfClass:NSString.class] || [value length] == 0 || [value length] > 200) return NO;
    NSCharacterSet *allowed = [NSCharacterSet characterSetWithCharactersInString:
        @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789._-*"];
    return [value rangeOfCharacterFromSet:allowed.invertedSet].location == NSNotFound;
}
static NSDictionary *embeddedEntitlements(int fd) {
    uint8_t header[32];
    if (pread(fd, header, sizeof(header), 0) != (ssize_t)sizeof(header) || word(header, 0, NO) != 0xfeedfacf)
        return @{@"inspection":@"unsupported_binary"};
    uint32_t count = word(header, 16, NO), size = word(header, 20, NO);
    if (count > 512 || size > 65536 || size < 8) return @{@"inspection":@"invalid_header"};
    NSMutableData *commands = [NSMutableData dataWithLength:size];
    if (pread(fd, commands.mutableBytes, size, 32) != (ssize_t)size) return @{@"inspection":@"read_failed"};
    const uint8_t *data = commands.bytes;
    uint32_t offset = 0, signatureOffset = 0, signatureSize = 0;
    for (uint32_t i = 0; i < count; ++i) {
        if (offset > size - 8) return @{@"inspection":@"invalid_commands"};
        uint32_t kind = word(data, offset, NO), length = word(data, offset + 4, NO);
        if (length < 8 || length > size - offset) return @{@"inspection":@"invalid_commands"};
        if (kind == 0x1d && length >= 16) {
            signatureOffset = word(data, offset + 8, NO);
            signatureSize = word(data, offset + 12, NO);
        }
        offset += length;
    }
    if (!signatureSize) return @{@"inspection":@"no_signature_command"};
    struct stat attributes;
    if (signatureSize < 12 || signatureSize > 8 * 1024 * 1024 || fstat(fd, &attributes) ||
        (uint64_t)signatureOffset + signatureSize > (uint64_t)attributes.st_size)
        return @{@"inspection":@"invalid_signature_size"};
    NSMutableData *blob = [NSMutableData dataWithLength:signatureSize];
    if (pread(fd, blob.mutableBytes, signatureSize, signatureOffset) != (ssize_t)signatureSize)
        return @{@"inspection":@"read_failed"};
    data = blob.bytes;
    uint32_t total = word(data, 4, YES), entries = word(data, 8, YES);
    if (word(data, 0, YES) != 0xfade0cc0 || total > signatureSize || total < 12 || entries > (total - 12) / 8)
        return @{@"inspection":@"invalid_signature_blob"};
    for (uint32_t i = 0; i < entries; ++i) {
        if (word(data, 12 + i * 8, YES) != 5) continue;
        uint32_t start = word(data, 16 + i * 8, YES);
        if (start > total - 8 || word(data, start, YES) != 0xfade7171) break;
        uint32_t length = word(data, start + 4, YES);
        if (length < 8 || length > total - start) break;
        NSData *xml = [NSData dataWithBytes:data + start + 8 length:length - 8];
        id values = [NSPropertyListSerialization propertyListWithData:xml options:NSPropertyListImmutable format:NULL error:NULL];
        if (![values isKindOfClass:NSDictionary.class]) break;
        NSMutableDictionary *result = [@{@"inspection":@"embedded_xml_read",
            @"cryptographic_signature_verified":@NO} mutableCopy];
        for (NSString *key in @[@"application-identifier", @"com.apple.developer.team-identifier"])
            if (identifier(values[key])) result[key] = values[key];
        NSMutableArray *groups = [NSMutableArray new];
        id list = values[@"keychain-access-groups"];
        if ([list isKindOfClass:NSArray.class] && [list count] <= 64)
            for (id group in list) if (identifier(group)) [groups addObject:group];
        result[@"keychain-access-groups"] = groups;
        return result;
    }
    return @{@"inspection":@"xml_entitlements_unavailable"}; // DER-only is not guessed.
}

NSDictionary *NDSigningSummary(void) {
    int fd = -1;
    @try {
        NSBundle *bundle = NSBundle.mainBundle;
        NSMutableDictionary *result = [NSMutableDictionary new];
        for (NSString *key in @[@"CFBundleIdentifier", @"ApplicationIdentifier", @"SCKeychainAccessIdentifier"])
            if (identifier(bundle.infoDictionary[key])) result[key] = bundle.infoDictionary[key];
        fd = open(bundle.executablePath.fileSystemRepresentation, O_RDONLY);
        result[@"embedded_signature"] = fd < 0 ? @{@"inspection":@"open_failed"} : embeddedEntitlements(fd);
        if (fd >= 0) { close(fd); fd = -1; }
        return result;
    } @catch (__unused NSException *exception) {
        if (fd >= 0) close(fd);
        return @{@"inspection":@"unavailable"};
    }
}
