#import "LabModel.h"
#include <stdio.h>

int main(void) {
    @autoreleasepool {
        NSCAssert([LabProfile()[@"serial"] isEqual:@"SIM12MINI002"], @"Fixture serial");
        NSCAssert([LabProfile()[@"product_type"] isEqual:@"iPhone13,1"], @"Fixture model");
        NSCAssert([LabAuthenticate(@"demo", @"sandbox", LabScenarioAllowed) isEqual:@"local_success"], @"Local success");
        NSCAssert([LabAuthenticate(@"demo", @"incorrect", LabScenarioAllowed) isEqual:@"invalid_demo_credentials"], @"Invalid credentials");
        NSCAssert([LabAuthenticate(@"", @"sandbox", LabScenarioAllowed) isEqual:@"missing_input"], @"Empty username");
        NSCAssert([LabAuthenticate(@"demo", @"", LabScenarioAllowed) isEqual:@"missing_input"], @"Empty password");
        NSCAssert([LabAuthenticate(@"demo", @"sandbox", LabScenarioBlocked) isEqual:@"locally_blocked"], @"Blocked fixture");
        NSCAssert([LabAuthenticate(@"demo", @"sandbox", LabScenarioUnavailable) isEqual:@"check_unavailable"], @"Unavailable fixture");
        NSCAssert([LabAuthenticate(@"demo", @"sandbox", (LabScenario)99) isEqual:@"invalid_scenario"], @"Unknown scenario fails");
        NSCAssert([LabAuthenticate(@"demo ", @"sandbox", LabScenarioAllowed) isEqual:@"invalid_demo_credentials"], @"No implicit credential rewriting");
        puts("PASS: 10 local fixture/authentication assertions");
    }
    return 0;
}
