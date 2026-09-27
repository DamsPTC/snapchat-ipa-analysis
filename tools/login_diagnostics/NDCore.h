#import <Foundation/Foundation.h>

// Read-only observation: original arguments, callbacks, errors and return values
// are forwarded unchanged. No credential, token or request body is recorded.
FOUNDATION_EXPORT void NDInstallObservers(void);
FOUNDATION_EXPORT NSDictionary *NDSnapshot(void);
FOUNDATION_EXPORT NSDictionary *NDSigningSummary(void);
