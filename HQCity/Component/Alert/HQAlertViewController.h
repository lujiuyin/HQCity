//
//  HQAlertViewController.h
//  HQCity
//
//  Created by 陆久银 on 2018/7/18.
//  Copyright © 2018年 lujiuyin. All rights reserved.
//

#import "BaseViewController.h"
#import "HQAlertContentViewController.h"

extern NSString *const AlertDidDismissNotification;
extern NSString *const AlertDidShowNotification;

typedef NS_ENUM(NSUInteger, HQAlertPriority) {
    HQAlertPriorityDefault,
    HQAlertPriorityTimeuut
};
@class HQAlertViewController;

typedef void(^HQAlertButtonCallBack)(HQAlertViewController *alert, NSInteger buttonIndex, BOOL *shouldDismissAlert);

@interface HQAlertViewController : BaseViewController

+ (instancetype)alertWithTitle:(NSString *)title
                       message:(NSString *)message
                         style:(HQAlertStyle)style
                       buttons:(NSArray *)buttons
                      callback:(HQAlertButtonCallBack)callback;

@property (nonatomic, assign) HQAlertPriority priority;

@property (nonatomic, strong, readonly) HQAlertContentViewController *contentViewController;
@end
