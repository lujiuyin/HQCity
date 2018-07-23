//
//  HQAlertContentViewController.m
//  HQCity
//
//  Created by 陆久银 on 2018/7/18.
//  Copyright © 2018年 lujiuyin. All rights reserved.
//

#import "HQAlertContentViewController.h"

@interface HQAlertContentViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIView *customView;

@end

@implementation HQAlertContentViewController

- (void)hideKeyboard {
    if (self.style == HQAlertStyleTextAndInput && self.textField.isFirstResponder) {
        [self.textField resignFirstResponder];
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


@end
