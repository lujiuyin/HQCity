//
//  HQAlertManager.m
//  HQCity
//
//  Created by 陆久银 on 2018/7/18.
//  Copyright © 2018年 lujiuyin. All rights reserved.
//

#import "HQAlertManager.h"

#define SHARE_INSTANCE(class)                                                                                                                                  \
+(instancetype)shareInstance                                                                                                                               \
{                                                                                                                                                          \
static dispatch_once_t class##_predicate;                                                                                                              \
static class *class##_instance = nil;                                                                                                                  \
dispatch_once(&class##_predicate,                                                                                                                      \
^() {                                                                                                                                              \
class##_instance = [[class alloc] init];                                                                                                           \
});                                                                                                                                                \
return class##_instance;                                                                                                                               \
}

@interface HQAlertManager()

@property (atomic, strong) NSMutableArray *alertQueue;
@property (nonatomic, strong) HQAlertViewController *currentAlert;

@end

@implementation HQAlertManager

SHARE_INSTANCE(HQAlertManager);

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message style:(HQAlertStyle)style buttons:(NSArray *)buttons callback:(HQAlertButtonCallBack)callback {
    
    HQAlertViewController *alert = [HQAlertViewController alertWithTitle:title message:message style:style buttons:buttons callback:callback];
    [[HQAlertManager shareInstance] enqueueAlert:alert];
}


- (void)enqueueAlert:(HQAlertViewController *)alert {
    if ([self existsHightPriorityAlert]) {
        return;
    }
    if (alert.priority == HQAlertPriorityTimeuut) {
        [self.alertQueue removeAllObjects];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        [self.currentAlert performSelector:@selector(dismiss)];
#pragma clang diagnostic pop
    
    }
    [self.alertQueue addObject:alert];
    
    [self showNext];
}

- (BOOL)existsHightPriorityAlert {
    if (self.currentAlert.priority == HQAlertPriorityTimeuut) {
        return YES;
    }
    for (HQAlertViewController *alert in self.alertQueue) {
        if (alert.priority == HQAlertPriorityTimeuut) {
            return YES;
        }
    }
    return NO;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onAlertDismiss:) name:AlertDidDismissNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onAlertShow:) name:AlertDidShowNotification object:nil];
        self.alertQueue = [NSMutableArray array];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)showNext {
    if (self.currentAlert || self.alertQueue.count == 0) {
        return;
    }
    HQAlertViewController *alert = self.alertQueue.firstObject;
    [self.alertQueue removeObjectAtIndex:0];
    self.currentAlert = alert;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    [alert performSelector:@selector(show)];
#pragma clang diagnostic pop
}

- (void)onAlertDismiss:(NSNotification *)notification {
    self.currentAlert = nil;
    [self showNext];
}

- (void)onAlertShow:(NSNotification *)notification {
    self.currentAlert = notification.object;
}
@end
