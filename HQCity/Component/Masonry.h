//
//  Masonry.h
//  HQCity
//
//  Created by 陆久银 on 2018/7/20.
//  Copyright © 2018年 lujiuyin. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MASONRY     ([Masonry sharedInstance])
@class Masonry;
typedef Masonry * (^Block)(float);

@interface Masonry : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, readonly)float val;

- (Masonry * (^) (float))add;
- (Masonry * (^) (float))sub;
- (Masonry * (^) (float))plus;
- (Masonry * (^) (float))div;

@end
