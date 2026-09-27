#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, LabScenario) {
    LabScenarioAllowed = 0,
    LabScenarioBlocked = 1,
    LabScenarioUnavailable = 2,
};

// Local fixtures only. No hardware getters, real tokens, persistence or network.
FOUNDATION_EXPORT NSDictionary<NSString *, NSString *> *LabProfile(void);
FOUNDATION_EXPORT NSString *LabAuthenticate(NSString *username, NSString *password, LabScenario scenario);
FOUNDATION_EXPORT NSString *LabOutcomeMessage(NSString *outcome);
