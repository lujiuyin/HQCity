//
//  HQRequest.m
//  HQCity
//
//  Created by 陆久银 on 2018/7/25.
//  Copyright © 2018年 lujiuyin. All rights reserved.
//

#import "HQRequest.h"
#import <AFNetworking/AFNetworking.h>

#define customURLString     @"http://www.sojson.com/api/beian/baidu.com"
@implementation HQRequest

+ (NSString *)customCachePath {
    return @"CustomCache";
}

+ (NSURLRequestCachePolicy)getCachePolicy {
    NSURLRequestCachePolicy cachePolicy;
    
    cachePolicy = NSURLRequestReturnCacheDataElseLoad;
    
    return cachePolicy;
}
+ (void)requestWithSuccess:(Success)success failed:(Failure)failed {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.requestSerializer.cachePolicy = [self getCachePolicy];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager GET:customURLString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failed(error);
    }];
}


- (NSCachedURLResponse *)cachedResponseForRequest:(NSURLRequest *)request {
    NSCachedURLResponse *cachedURLResponse = [super cachedResponseForRequest:request];
    id cacheData = nil;
    if (!cachedURLResponse.data) {
        cacheData = @"取到的缓存为空";
    }else {
        cacheData = [NSJSONSerialization JSONObjectWithData:cachedURLResponse.data options:NSJSONReadingMutableContainers error:nil];
    }
    NSLog(@"\n取缓存:\n \nURL:%@ \n response:%@\n",request.URL,cacheData);
    return cachedURLResponse;
}

- (void)storeCachedResponse:(NSCachedURLResponse *)cachedResponse forRequest:(NSURLRequest *)request {
    id cacheData = [NSJSONSerialization JSONObjectWithData:cachedResponse.data options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"\n存缓存:\n \nURL:%@ \n response:%@\n",request.URL,cacheData);
    [super storeCachedResponse:cachedResponse forRequest:request];
}
@end
