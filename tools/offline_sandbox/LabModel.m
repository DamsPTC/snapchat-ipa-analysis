#import "LabModel.h"

NSDictionary<NSString *, NSString *> *LabProfile(void) {
    return @{@"model": @"iPhone 12 mini", @"product_type": @"iPhone13,1",
             @"serial": @"SIM12MINI002", @"environment": @"offline_fixture"};
}

NSString *LabAuthenticate(NSString *username, NSString *password, LabScenario scenario) {
    if (!username.length || !password.length) return @"missing_input";
    if (scenario == LabScenarioUnavailable) return @"check_unavailable";
    if (scenario == LabScenarioBlocked) return @"locally_blocked";
    if (scenario != LabScenarioAllowed) return @"invalid_scenario";
    if ([username isEqualToString:@"demo"] && [password isEqualToString:@"sandbox"])
        return @"local_success";
    return @"invalid_demo_credentials";
}

NSString *LabOutcomeMessage(NSString *outcome) {
    return @{
        @"missing_input": @"Renseigne les deux champs de démonstration.",
        @"check_unavailable": @"Simulation : DeviceCheck local indisponible.",
        @"locally_blocked": @"Simulation : appareil bloqué dans ce scénario local.",
        @"invalid_scenario": @"Scénario local inconnu.",
        @"local_success": @"Session de démonstration ouverte localement.",
        @"invalid_demo_credentials": @"Utilise uniquement le compte de démo : demo / sandbox."
    }[outcome] ?: @"Résultat local inconnu.";
}
