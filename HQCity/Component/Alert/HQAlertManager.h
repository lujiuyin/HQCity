//
//  HQAlertManager.h
//  HQCity
//
//  Created by 陆久银 on 2018/7/18.
//  Copyright © 2018年 lujiuyin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HQAlertViewController.h"

@interface HQAlertManager : NSObject

+ (instancetype)shareInstance;

- (void)enqueueAlert:(HQAlertViewController *)alert;

+ (void)showAlertWithTitle:(NSString *)title
                   message:(NSString *)message
                     style:(HQAlertStyle)style
                   buttons:(NSArray *)buttons
                  callback:(HQAlertButtonCallBack)callback;
@end
