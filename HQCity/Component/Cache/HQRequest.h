//
//  HQRequest.h
//  HQCity
//
//  Created by 陆久银 on 2018/7/25.
//  Copyright © 2018年 lujiuyin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^Success)(id);
typedef void(^Failure)(NSError *);
@interface HQRequest : NSURLCache

+ (NSString *)customCachePath;

+ (void)requestWithSuccess:(Success)success
                    failed:(Failure)failed;
@end
