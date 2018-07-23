//
//  HQAlertContentViewController.h
//  HQCity
//
//  Created by 陆久银 on 2018/7/18.
//  Copyright © 2018年 lujiuyin. All rights reserved.
//

#import "BaseViewController.h"

typedef NS_ENUM(NSUInteger, HQAlertStyle) {
    HQAlertStyleText,
    HQAlertStyleTextAndInput,
    HQAlertStyleCustom,
    HQAlertStyleReminder,
    HQAlertStyleDownload,
    HQAlertStyleDevice,
};

@class HQAlertViewController;

@interface HQAlertContentViewController : BaseViewController

@property (nonatomic, strong) NSString *message;

@property (nonatomic, assign) HQAlertStyle style;
@property (nonatomic, weak) HQAlertViewController *alert;


- (void)hideKeyboard;
@end
