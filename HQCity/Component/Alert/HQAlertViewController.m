//
//  HQAlertViewController.m
//  HQCity
//
//  Created by 陆久银 on 2018/7/18.
//  Copyright © 2018年 lujiuyin. All rights reserved.
//

#import "HQAlertViewController.h"
#import "UIViewController+Container.h"


#pragma mark - Animation

#define UI_ANIMATION_DURATION   0.2
#define UI_ANIMATION_DAMPING    0.75
#define UI_ANIMATION_SPRING_VELOCITY    0.5
#define UI_ANIMATION_SPRING_DURATION    0.5


NSString *const AlertDidDismissNotification = @"AlertDidDismissNotification";
NSString *const AlertDidShowNotification = @"AlertDidShowNotification";

static NSString *const AlertContentIdentifierText = @"AlertContentIdentifierText";
static NSString *const AlertContentIdentifierTextAndInput = @"AlertContentIdentifierTextAndInput";
static NSString *const AlertContentIdentifierCustom = @"AlertContentIdentifierCustom";
static NSString *const AlertContentIdentifierReminder = @"AlertContentIdentifierReminder";
static NSString *const AlertContentIdentifierDownload = @"AlertContentIdentifierDownload";
static NSString *const AlertContentIdentifierDevice = @"AlertContentIdentifierDevice";

static const CGFloat AnimationScaleSmall = 0.1;

@interface HQAlertViewController ()
@property (weak, nonatomic) IBOutlet UIView *alertView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIView *singleButtonView;
@property (weak, nonatomic) IBOutlet UIView *doubleButtonView;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttons;
@property (copy, nonatomic) HQAlertButtonCallBack buttonCallBack;

@end

@implementation HQAlertViewController

#pragma mark - I/F
+ (instancetype)alertWithTitle:(NSString *)title message:(NSString *)message style:(HQAlertStyle)style buttons:(NSArray *)buttons callback:(HQAlertButtonCallBack)callback {
    
    HQAlertViewController *alert = [[UIStoryboard storyboardWithName:@"HQAlert" bundle:nil] instantiateViewControllerWithIdentifier:@"HQAlertViewController"];
    [alert configWithTitle:title message:message style:style buttons:buttons callback:callback];
    return alert;
}


- (void)show {
    UIViewController *frontViewController = [((UIWindow *)([UIApplication sharedApplication].windows.firstObject)).rootViewController frontViewController];
    [frontViewController.view endEditing:YES];
    
    UIViewController *rootViewController = ((UIWindow *)[UIApplication sharedApplication].windows.firstObject).rootViewController.childViewControllers.firstObject;
    
    [rootViewController attachChildViewController:self toView:[[UIApplication sharedApplication] windows].firstObject callAppearanceMethod:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:AlertDidShowNotification object:self];
}

- (void)dismiss {
    [UIView animateWithDuration:UI_ANIMATION_DURATION delay:0 usingSpringWithDamping:UI_ANIMATION_DAMPING initialSpringVelocity:UI_ANIMATION_SPRING_VELOCITY options:UIViewAnimationOptionLayoutSubviews animations:^{
        self.alertView.transform = CGAffineTransformMakeScale(AnimationScaleSmall, AnimationScaleSmall);
        self.view.alpha = 0;
    } completion:^(BOOL finished) {
        [self.parentViewController detachChildViewController:self callAppearanceMethod:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:AlertDidDismissNotification object:self];
    }];
}
#pragma mark - Getter & Setter
- (HQAlertContentViewController *)contentViewController {
    return (HQAlertContentViewController *)[self childViewControllerWithClass:[HQAlertContentViewController class]];
}

#pragma mark - IBAction
- (IBAction)onButton:(UIButton *)sender {
    [self.contentViewController hideKeyboard];
    for (UIButton *button in self.buttons) {
        button.userInteractionEnabled = NO;
    }
    
    __block BOOL shouldDismissAlert = YES;
    if (self.buttonCallBack) {
        self.buttonCallBack(self, sender.tag, &shouldDismissAlert);
    }
    if (shouldDismissAlert) {
        [self dismiss];
    }
    
    for (UIButton *button in self.buttons) {
        button.userInteractionEnabled = YES;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Life Cycle
- (void)configWithTitle:(NSString *)title
                message:(NSString *)message
                  style:(HQAlertStyle)style
                buttons:(NSArray *)buttons
               callback:(HQAlertButtonCallBack)callback {
    [self view];
    self.titleLabel.text = title;
    
    self.singleButtonView.hidden = buttons.count == 2;
    self.doubleButtonView.hidden = !self.singleButtonView.hidden;

    for (NSString *buttonTitle in buttons) {
        for (UIButton *button in self.buttons) {
            if (button.tag == [buttons indexOfObject:buttonTitle]) {
                [button setTitle:buttonTitle forState:UIControlStateNormal];
            }
        }
    }
    self.buttonCallBack = callback;
    
    NSString *contentIdentifier = @[
        AlertContentIdentifierText,
        AlertContentIdentifierTextAndInput,
        AlertContentIdentifierCustom,
        AlertContentIdentifierReminder,
        AlertContentIdentifierDownload,
        AlertContentIdentifierDevice
    ][style];
    
    HQAlertContentViewController *viewController = [[UIStoryboard storyboardWithName:@"HQAlert" bundle:nil] instantiateViewControllerWithIdentifier:contentIdentifier];
    viewController.style = style;
    viewController.message = message;
    viewController.alert = self;
    
    [self attachChildViewController:viewController toView:self.mainView callAppearanceMethod:NO];
}
@end
