//
//  Masonry.m
//  HQCity
//
//  Created by 陆久银 on 2018/7/20.
//  Copyright © 2018年 lujiuyin. All rights reserved.
//

#import "Masonry.h"

@interface Masonry()
@property (nonatomic, assign)float val;
@end
@implementation Masonry

+ (instancetype)sharedInstance {
    static Masonry *masonry = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        masonry = [[Masonry alloc] init];
    });
    return masonry;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.val = 0;
    }
    return self;
}

- (Masonry * (^) (float))add {
    return ^Masonry* (float a){
        self.val += a;
        return self;
    };
}

- (Masonry * (^) (float))sub {
    return ^Masonry* (float a){
        self.val -= a;
        return self;
    };
}

- (Masonry * (^) (float))plus {
    return ^Masonry* (float a){
        self.val *= a;
        return self;
    };
}

- (Masonry * (^) (float))div {
    return ^Masonry* (float a) {
        if (a != 0) {
            self.val /= a;
        }
        return self;
    };
}
@end
