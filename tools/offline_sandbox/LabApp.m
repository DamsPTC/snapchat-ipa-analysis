#import <UIKit/UIKit.h>
#import "LabModel.h"

@interface LabViewController : UIViewController <UITextFieldDelegate>
@property(nonatomic, strong) UITextField *username;
@property(nonatomic, strong) UITextField *password;
@property(nonatomic, strong) UISegmentedControl *scenario;
@property(nonatomic, strong) UILabel *status;
@property(nonatomic, strong) UIScrollView *scroll;
@property(nonatomic, copy) NSString *lastOutcome;
@property(nonatomic, weak) UITextField *activeField;
- (void)submit;
- (void)fillDemo;
- (void)reset;
#if LAB_ENABLE_SELF_TEST
- (void)runSelfTest;
#endif
@end

@implementation LabViewController
- (UILabel *)label:(NSString *)text style:(UIFontTextStyle)style {
    UILabel *label = [UILabel new];
    label.text = text;
    label.font = [UIFont preferredFontForTextStyle:style];
    label.adjustsFontForContentSizeCategory = YES;
    label.numberOfLines = 0;
    label.textColor = UIColor.labelColor;
    return label;
}
- (UITextField *)field:(NSString *)placeholder identifier:(NSString *)identifier {
    UITextField *field = [UITextField new];
    field.placeholder = placeholder;
    field.accessibilityLabel = placeholder;
    field.accessibilityIdentifier = identifier;
    field.borderStyle = UITextBorderStyleRoundedRect;
    field.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    field.adjustsFontForContentSizeCategory = YES;
    field.autocorrectionType = UITextAutocorrectionTypeNo;
    field.autocapitalizationType = UITextAutocapitalizationTypeNone;
    field.delegate = self;
    [field.heightAnchor constraintGreaterThanOrEqualToConstant:48].active = YES;
    return field;
}
- (UIButton *)button:(NSString *)title action:(SEL)action filled:(BOOL)filled {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    UIButtonConfiguration *configuration = filled ? UIButtonConfiguration.filledButtonConfiguration :
                                                   UIButtonConfiguration.grayButtonConfiguration;
    configuration.title = title;
    configuration.cornerStyle = UIButtonConfigurationCornerStyleMedium;
    configuration.contentInsets = NSDirectionalEdgeInsetsMake(14, 16, 14, 16);
    button.configuration = configuration;
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.systemGroupedBackgroundColor;
    self.view.tintColor = [UIColor colorWithRed:0.15 green:0.30 blue:0.78 alpha:1];
    self.scroll = [UIScrollView new];
    self.scroll.translatesAutoresizingMaskIntoConstraints = NO;
    self.scroll.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    [self.view addSubview:self.scroll];
    UIStackView *stack = [UIStackView new];
    stack.axis = UILayoutConstraintAxisVertical;
    stack.spacing = 16;
    stack.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scroll addSubview:stack];
    [NSLayoutConstraint activateConstraints:@[
        [self.scroll.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [self.scroll.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.scroll.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.scroll.bottomAnchor constraintEqualToAnchor:self.view.keyboardLayoutGuide.topAnchor],
        [stack.topAnchor constraintEqualToAnchor:self.scroll.contentLayoutGuide.topAnchor constant:24],
        [stack.bottomAnchor constraintEqualToAnchor:self.scroll.contentLayoutGuide.bottomAnchor constant:-24],
        [stack.leadingAnchor constraintEqualToAnchor:self.scroll.contentLayoutGuide.leadingAnchor constant:24],
        [stack.trailingAnchor constraintEqualToAnchor:self.scroll.contentLayoutGuide.trailingAnchor constant:-24],
        [stack.widthAnchor constraintEqualToAnchor:self.scroll.frameLayoutGuide.widthAnchor constant:-48]]];
    [stack addArrangedSubview:[self label:@"SnapLab" style:UIFontTextStyleLargeTitle]];
    [stack addArrangedSubview:[self label:@"Sandbox entièrement locale" style:UIFontTextStyleTitle2]];
    [stack addArrangedSubview:[self label:@"Aucune connexion aux serveurs Snapchat. Utilise uniquement les identifiants de démonstration." style:UIFontTextStyleBody]];
    NSDictionary *profile = LabProfile();
    NSString *identity = [NSString stringWithFormat:@"Profil fictif : %@\nModèle de test : %@\nSérie de test : %@",
        profile[@"model"], profile[@"product_type"], profile[@"serial"]];
    [stack addArrangedSubview:[self label:identity style:UIFontTextStyleCallout]];
    [stack addArrangedSubview:[self label:@"DeviceCheck simulé" style:UIFontTextStyleHeadline]];
    self.scenario = [[UISegmentedControl alloc] initWithItems:@[@"Autorisé", @"Bloqué", @"Erreur"]];
    self.scenario.selectedSegmentIndex = LabScenarioAllowed;
    self.scenario.accessibilityLabel = @"Scénario DeviceCheck local";
    [self.scenario addTarget:self action:@selector(scenarioChanged) forControlEvents:UIControlEventValueChanged];
    [stack addArrangedSubview:self.scenario];
    self.username = [self field:@"Identifiant de démonstration" identifier:@"lab.username"];
    self.username.textContentType = UITextContentTypeUsername;
    self.username.returnKeyType = UIReturnKeyNext;
    self.password = [self field:@"Mot de passe de démonstration" identifier:@"lab.password"];
    self.password.secureTextEntry = YES;
    self.password.textContentType = UITextContentTypePassword;
    self.password.returnKeyType = UIReturnKeyGo;
    [stack addArrangedSubview:self.username];
    [stack addArrangedSubview:self.password];
    [stack addArrangedSubview:[self label:@"Compte local : demo / sandbox" style:UIFontTextStyleFootnote]];
    [stack addArrangedSubview:[self button:@"Tester la connexion locale" action:@selector(submit) filled:YES]];
    [stack addArrangedSubview:[self button:@"Remplir la démo" action:@selector(fillDemo) filled:NO]];
    self.status = [self label:@"Prêt pour le test local." style:UIFontTextStyleBody];
    self.status.accessibilityIdentifier = @"lab.status";
    [stack addArrangedSubview:self.status];
    [stack addArrangedSubview:[self button:@"Réinitialiser le test" action:@selector(reset) filled:NO]];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(keyboardShown:)
        name:UIKeyboardDidShowNotification object:nil];
}
- (void)dealloc { [NSNotificationCenter.defaultCenter removeObserver:self]; }
- (void)keyboardShown:(NSNotification *)notification {
    (void)notification;
    UITextField *field = self.activeField;
    if (field.isFirstResponder) {
        CGRect rect = [field convertRect:field.bounds toView:self.scroll];
        [self.scroll scrollRectToVisible:CGRectInset(rect, 0, -16) animated:YES];
    }
}
- (void)textFieldDidBeginEditing:(UITextField *)field { self.activeField = field; }
- (void)textFieldDidEndEditing:(UITextField *)field {
    if (self.activeField == field) self.activeField = nil;
}
- (BOOL)textFieldShouldReturn:(UITextField *)field {
    if (field == self.username) [self.password becomeFirstResponder];
    else [self submit];
    return YES;
}
- (void)scenarioChanged {
    self.lastOutcome = nil;
    self.status.text = @"Scénario modifié. Lance un nouveau test local.";
    self.status.textColor = UIColor.labelColor;
}
- (void)fillDemo {
    [self.view endEditing:YES];
    self.username.text = @"demo";
    self.password.text = @"sandbox";
    [self scenarioChanged];
}
- (void)submit {
    [self.view endEditing:YES];
    self.lastOutcome = LabAuthenticate(self.username.text, self.password.text, (LabScenario)self.scenario.selectedSegmentIndex);
    self.status.text = LabOutcomeMessage(self.lastOutcome);
    self.status.textColor = [self.lastOutcome isEqual:@"local_success"] ? UIColor.systemGreenColor : UIColor.systemRedColor;
}
- (void)reset {
    [self.view endEditing:YES];
    self.username.text = @"";
    self.password.text = @"";
    self.scenario.selectedSegmentIndex = LabScenarioAllowed;
    self.lastOutcome = nil;
    self.status.text = @"Prêt pour le test local.";
    self.status.textColor = UIColor.labelColor;
}
#if LAB_ENABLE_SELF_TEST
- (void)runSelfTest {
    // This entry is compiled ONLY into the simulator build, never into the IPA.
    NSMutableArray *checks = [NSMutableArray new];
    NSMutableDictionary *result = [NSMutableDictionary new];
    @try {
        NSAssert(NSThread.isMainThread && self.view.window, @"Visible main-thread UI required");
        NSAssert([self.username.textContentType isEqual:UITextContentTypeUsername] &&
                 [self.password.textContentType isEqual:UITextContentTypePassword] && self.password.isSecureTextEntry, @"Input traits");
        [checks addObject:@"input_traits_and_secure_password"];
        [self fillDemo];
        [self submit];
        NSAssert([self.lastOutcome isEqual:@"local_success"], @"Demo success");
        [checks addObject:@"local_success"];
        self.password.text = @"incorrect";
        [self submit];
        NSAssert([self.lastOutcome isEqual:@"invalid_demo_credentials"], @"Invalid demo credentials");
        [checks addObject:@"invalid_demo_credentials"];
        [self fillDemo];
        self.scenario.selectedSegmentIndex = LabScenarioBlocked;
        [self submit];
        NSAssert([self.lastOutcome isEqual:@"locally_blocked"], @"Blocked fixture");
        [checks addObject:@"blocked_fixture"];
        self.scenario.selectedSegmentIndex = LabScenarioUnavailable;
        [self submit];
        NSAssert([self.lastOutcome isEqual:@"check_unavailable"], @"Unavailable fixture");
        [checks addObject:@"unavailable_fixture"];
        [self reset];
        NSAssert(!self.username.text.length && !self.password.text.length && self.password.isSecureTextEntry, @"Reset");
        [checks addObject:@"reset_preserves_secure_entry"];
        [self submit];
        NSAssert([self.lastOutcome isEqual:@"missing_input"], @"Required fields");
        [checks addObject:@"required_fields"];
        [self reset];
        NSAssert([self.username becomeFirstResponder], @"Username focus");
        [self.username insertText:@"demo"];
        [self textFieldShouldReturn:self.username];
        NSAssert(self.password.isFirstResponder, @"Return moves focus");
        [checks addObject:@"return_moves_focus_to_password"];
        [self.password insertText:@"sandboz"];
        [self.password deleteBackward];
        [self.password insertText:@"x"];
        [self textFieldShouldReturn:self.password];
        NSAssert(!self.password.isFirstResponder && [self.lastOutcome isEqual:@"local_success"], @"Return submits and closes keyboard");
        NSAssert([self.password.text isEqual:@"sandbox"] && self.password.isSecureTextEntry, @"Password survives focus transition");
        [checks addObject:@"return_submits_and_dismisses_keyboard"];
        [checks addObject:@"password_preserved_across_focus_transition"];
        result[@"passed"] = @YES;
    } @catch (NSException *exception) {
        result[@"passed"] = @NO;
        result[@"failed_assertion"] = exception.reason ?: @"Unknown test failure";
    }
    result[@"checks"] = checks;
    result[@"ios_version"] = UIDevice.currentDevice.systemVersion;
    result[@"real_face_id_autofill_tested"] = @NO;
    result[@"original_ipa_tested"] = @NO;
    result[@"network_authentication_tested"] = @NO;
    NSURL *directory = [NSFileManager.defaultManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].firstObject;
    NSData *data = [NSJSONSerialization dataWithJSONObject:result options:NSJSONWritingPrettyPrinted | NSJSONWritingSortedKeys error:nil];
    [data writeToURL:[directory URLByAppendingPathComponent:@"lab-ui-test-result.json"] atomically:YES];
}
#endif
@end

@interface LabSceneDelegate : UIResponder <UIWindowSceneDelegate>
@property(nonatomic, strong) UIWindow *window;
@end
@implementation LabSceneDelegate
- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)options {
    (void)session; (void)options;
    if (![scene isKindOfClass:UIWindowScene.class]) return;
    self.window = [[UIWindow alloc] initWithWindowScene:(UIWindowScene *)scene];
    LabViewController *controller = [LabViewController new];
    self.window.rootViewController = controller;
    [self.window makeKeyAndVisible];
#if LAB_ENABLE_SELF_TEST
    if ([NSProcessInfo.processInfo.environment[@"LAB_SELF_TEST"] isEqual:@"1"])
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC), dispatch_get_main_queue(), ^{ [controller runSelfTest]; });
#endif
}
@end

@interface LabAppDelegate : UIResponder <UIApplicationDelegate>
@end
@implementation LabAppDelegate
@end

int main(int argc, char *argv[]) {
    @autoreleasepool { return UIApplicationMain(argc, argv, nil, NSStringFromClass(LabAppDelegate.class)); }
}
