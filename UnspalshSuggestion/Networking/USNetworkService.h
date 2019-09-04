//
//  UnspalshSuggestion
//
//  Created by xiaoyu on 2019/9/3.
//  Copyright © 2019 xiaoyu. All rights reserved.
//
#import <Foundation/Foundation.h>

typedef void(^USSuccessBlock)(id responseObject);
typedef void(^USFailureBlock)(id responseObject,NSError *error);


@interface USNetworkService : NSObject

+ (void)getDataWithParameter:(NSDictionary *)param
        notReachableFromeCache:(BOOL)fromeCache
                  successBlock:(USSuccessBlock)successBlock
                  failureBlock:(USFailureBlock)failureBlock;
@end


#pragma mark - 网络状态枚举
typedef NS_ENUM(NSUInteger, USNetworkStatus) {
    /**
     *  未知网络
     */
    USNetworkStatusUnknown,
    /**
     *  无网络
     */
    USNetworkStatusNotReachable,
    /**
     *  手机网络
     */
    USNetworkStatusViaWWAN,
    /**
     * WIFI网络
     */
    USNetworkStatusViaWiFi,
};

#pragma mark - 网络状态通知

FOUNDATION_EXTERN  NSString *const USNotificationNetworkStatusUnknown;       //未知网络
FOUNDATION_EXTERN  NSString *const USNotificationNetworkStatusNotReachable;  //无网络
FOUNDATION_EXTERN  NSString *const USNotificationNetworkStatusViaWWAN;       //蜂窝网络
FOUNDATION_EXTERN  NSString *const USNotificationNetworkStatusViaWiFi;       //WIFI

@interface USNetworkService (NetworkStatus)

+ (void)startNetworkStatusWithBlock:(void(^)(USNetworkStatus status))networkStatus;

+ (BOOL)isReachable;

+ (BOOL)isWWANNetwork;

+ (BOOL)isWiFiNetwork;
@end


