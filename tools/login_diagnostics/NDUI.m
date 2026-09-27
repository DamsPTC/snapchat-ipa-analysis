#import "NDCore.h"
#import <UIKit/UIKit.h>

@interface NDPanel : NSObject
@property(nonatomic, strong) UIButton *button;
@property(nonatomic, weak) UIWindow *window;
- (void)attach;
- (void)notification:(NSNotification *)notification;
- (UIViewController *)presenter;
- (void)show;
- (void)share:(NSDictionary *)snapshot;
@end

@implementation NDPanel
- (void)notification:(NSNotification *)notification {
    (void)notification;
    [self attach];
}
- (void)attach {
    UIApplication *app = UIApplication.sharedApplication;
    if (app.applicationState != UIApplicationStateActive) return;
    UIWindow *window = nil;
    if (@available(iOS 13.0, *)) {
        for (UIScene *scene in app.connectedScenes) {
            if (scene.activationState != UISceneActivationStateForegroundActive ||
                ![scene isKindOfClass:UIWindowScene.class]) continue;
            for (UIWindow *candidate in ((UIWindowScene *)scene).windows)
                if (candidate.isKeyWindow && candidate.rootViewController && candidate.windowLevel == UIWindowLevelNormal)
                    window = candidate;
        }
    } else {
        window = app.keyWindow;
    }
    if (!window || !window.rootViewController || self.window == window) return;
    [self.button removeFromSuperview];
    self.window = window;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    self.button = button;
    [button setTitle:@"Diagnostic" forState:UIControlStateNormal];
    [button setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    button.backgroundColor = [UIColor colorWithRed:0.12 green:0.30 blue:0.62 alpha:0.94];
    button.layer.cornerRadius = 15;
    button.titleLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightSemibold];
    button.accessibilityLabel = @"Afficher le diagnostic local de connexion";
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [button addTarget:self action:@selector(show) forControlEvents:UIControlEventTouchUpInside];
    [window addSubview:button];
    [NSLayoutConstraint activateConstraints:@[
        [button.topAnchor constraintEqualToAnchor:window.safeAreaLayoutGuide.topAnchor constant:8],
        [button.trailingAnchor constraintEqualToAnchor:window.safeAreaLayoutGuide.trailingAnchor constant:-12],
        [button.widthAnchor constraintEqualToConstant:112],
        [button.heightAnchor constraintEqualToConstant:36]]];
}
- (UIViewController *)presenter {
    UIViewController *controller = self.window.rootViewController;
    while (controller.presentedViewController && !controller.presentedViewController.isBeingDismissed)
        controller = controller.presentedViewController;
    return controller;
}
- (void)show {
    UIViewController *presenter = [self presenter];
    if (!presenter || presenter.isBeingPresented || presenter.isBeingDismissed ||
        [presenter isKindOfClass:UIAlertController.class]) return;
    NSMutableDictionary *snapshot = [NDSnapshot() mutableCopy];
    snapshot[@"signing_metadata"] = NDSigningSummary();
    snapshot[@"ios_version"] = UIDevice.currentDevice.systemVersion;
    NSUInteger installed = 0;
    for (NSString *state in [snapshot[@"coverage"] allValues]) if ([state isEqual:@"installed"]) ++installed;
    NSDictionary *lastResponse = snapshot[@"last_login_response"];
    NSNumber *keychainError = snapshot[@"last_keychain_error"];
    NSString *login = lastResponse ? [NSString stringWithFormat:@"Parcours : %@\nRéponse présente : %@\nCode transport : %@\nStatut protocole : %@",
        lastResponse[@"path"], [lastResponse[@"response_present"] boolValue] ? @"oui" : @"non",
        lastResponse[@"transport_error_code"] ?: @"aucun observé", lastResponse[@"proto_status"] ?: @"non disponible"] :
        @"Aucune réponse de connexion observée. Fais un essai avec saisie manuelle, puis rouvre ce panneau.";
    NSString *message = [NSString stringWithFormat:@"Observateurs : %lu/7\n%@\nErreur trousseau observée : %@\n\nLe rapport contient uniquement des codes techniques. Il reste local jusqu’à ton partage.",
        (unsigned long)installed, login, keychainError ?: @"aucune"];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Diagnostic du login"
        message:message preferredStyle:UIAlertControllerStyleAlert];
    __weak NDPanel *weakSelf = self;
    [alert addAction:[UIAlertAction actionWithTitle:@"Partager le rapport" style:UIAlertActionStyleDefault handler:^(__unused UIAlertAction *action) {
        // Wait for the alert's dismissal; never present from the login callback.
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 350 * NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
            [weakSelf share:snapshot];
        });
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Fermer" style:UIAlertActionStyleCancel handler:nil]];
    [presenter presentViewController:alert animated:YES completion:nil];
}
- (void)share:(NSDictionary *)snapshot {
    UIViewController *presenter = [self presenter];
    if (!presenter || presenter.isBeingDismissed || presenter.isBeingPresented ||
        [presenter isKindOfClass:UIAlertController.class]) return;
    NSError *error = nil;
    NSData *json = [NSJSONSerialization dataWithJSONObject:snapshot options:NSJSONWritingPrettyPrinted | NSJSONWritingSortedKeys error:&error];
    if (!json) return;
    NSURL *url = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:@"Snapchat-login-diagnostic.json"]];
    if (![json writeToURL:url options:NSDataWritingAtomic error:&error]) return;
    UIActivityViewController *sheet = [[UIActivityViewController alloc] initWithActivityItems:@[url] applicationActivities:nil];
    sheet.popoverPresentationController.sourceView = self.button;
    sheet.popoverPresentationController.sourceRect = self.button.bounds;
    [presenter presentViewController:sheet animated:YES completion:nil];
}
@end

__attribute__((constructor)) static void startDiagnostics(void) {
    dispatch_async(dispatch_get_main_queue(), ^{
        @try {
            NDInstallObservers();
            static NDPanel *panel;
            panel = [NDPanel new];
            [NSNotificationCenter.defaultCenter addObserver:panel selector:@selector(notification:)
                name:UIApplicationDidBecomeActiveNotification object:nil];
            [NSNotificationCenter.defaultCenter addObserver:panel selector:@selector(notification:)
                name:UIWindowDidBecomeKeyNotification object:nil];
            [panel attach];
        } @catch (__unused NSException *exception) {
            // No fallback hooking or change to the native authentication path.
        }
    });
}
