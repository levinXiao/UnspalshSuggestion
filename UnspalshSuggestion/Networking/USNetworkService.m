//
//  UnspalshSuggestion
//
//  Created by xiaoyu on 2019/9/3.
//  Copyright © 2019 xiaoyu. All rights reserved.
//
#import "USNetworkService.h"

#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>
#import "USNetworkCache.h"
#import "USJSONResponseSerializer.h"


static NSString * const class_request = @"Request";
static NSString * const class_responce = @"Responce";

static NSString * const requestUrl = @"https://api.unsplash.com/photos/curated";

/// AFN
static AFHTTPSessionManager *_sessionManager;


@implementation USNetworkService
+ (void)initialize{
    
    _sessionManager = [AFHTTPSessionManager manager];
    
    _sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    _sessionManager.responseSerializer = [USJSONResponseSerializer serializer];
    _sessionManager.requestSerializer.timeoutInterval = 15.f;
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    [_sessionManager.requestSerializer setValue:@"Client-ID 5050168bad91ad793c904f67342c33fff95a53545f8dc03030f25ded76a04858" forHTTPHeaderField:@"Authorization"];
    // 版本
    [_sessionManager.requestSerializer setValue:@"v1" forHTTPHeaderField:@"Accept-Version"];

    
    
}

#pragma mark - 公共方法
+ (void)getDataWithParameter:(NSDictionary *)param notReachableFromeCache:(BOOL)fromeCache successBlock:(USSuccessBlock)successBlock failureBlock:(USFailureBlock)failureBlock {
    
        
        [_sessionManager GET:requestUrl parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nonnull responseObject) {
            //成功回调
            successBlock ? successBlock(responseObject) : nil;
            //存到本地
            if (fromeCache) {
                [USNetworkCache setCache:responseObject uniqueKey:[NSString stringWithFormat:@"%@?%@",requestUrl,[param mj_JSONString]]];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            // 读取缓存
            if (![USNetworkService isReachable] && fromeCache) {
                id responseObject = [USNetworkCache cacheForUniqueKey:[NSString stringWithFormat:@"%@?%@",requestUrl,[param mj_JSONString]]];
                if (responseObject) {
                    successBlock ? successBlock(responseObject) : nil;
                    return ;
                }
            }
            // 失败回调
            failureBlock ? failureBlock([[error userInfo] valueForKey:responce_data],error) : nil;
                                
        }];
    
}

@end



NSString * const USNotificationNetworkStatusUnknown      = @"USNotificationNetworkStatusUnknown";       //未知网络
NSString * const USNotificationNetworkStatusNotReachable = @"USNotificationNetworkStatusNotReachable";  //无网络
NSString * const USNotificationNetworkStatusViaWWAN      = @"USNotificationNetworkStatusViaWWAN";       //蜂窝网络
NSString * const USNotificationNetworkStatusViaWiFi      = @"USNotificationNetworkStatusViaWiFi";       //WIFI

@implementation USNetworkService (NetworkStatus)

+ (void)startNetworkStatusWithBlock:(void(^)(USNetworkStatus status))networkStatus{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
        [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status){
                case AFNetworkReachabilityStatusUnknown:{
                    networkStatus ? networkStatus(USNetworkStatusUnknown) : nil;
                    //发送通知
                    [[NSNotificationCenter defaultCenter] postNotificationName:USNotificationNetworkStatusUnknown object:nil];
                    NSLog(@"未知网络");
                }
                    break;
                case AFNetworkReachabilityStatusNotReachable:{
                    networkStatus ? networkStatus(USNetworkStatusNotReachable) : nil;
                    //发送通知
                    [[NSNotificationCenter defaultCenter] postNotificationName:USNotificationNetworkStatusNotReachable object:nil];
                    NSLog(@"无网络");
                }
                    break;
                case AFNetworkReachabilityStatusReachableViaWWAN:{
                    networkStatus ? networkStatus(USNetworkStatusViaWWAN) : nil;
                    //发送通知
                    [[NSNotificationCenter defaultCenter] postNotificationName:USNotificationNetworkStatusViaWWAN object:nil];
                    NSLog(@"蜂窝网络");
                }
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi:{
                    networkStatus ? networkStatus(USNetworkStatusViaWiFi) : nil;
                    //发送通知
                    [[NSNotificationCenter defaultCenter] postNotificationName:USNotificationNetworkStatusViaWiFi object:nil];
                    NSLog(@"WIFI");
                }
                    break;
            }
        }];
        
        [reachabilityManager startMonitoring];
    });
}

+ (BOOL)isReachable{
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

+ (BOOL)isWWANNetwork{
    return [AFNetworkReachabilityManager sharedManager].reachableViaWWAN;
}

+ (BOOL)isWiFiNetwork{
    return [AFNetworkReachabilityManager sharedManager].reachableViaWiFi;
}

@end

