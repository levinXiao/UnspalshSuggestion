//
//  UnspalshSuggestion
//
//  Created by xiaoyu on 2019/9/3.
//  Copyright © 2019 xiaoyu. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface USNetworkCache : NSObject

+ (void)setCache:(id)data uniqueKey:(NSString *)uniqueKey;

+ (id)cacheForUniqueKey:(NSString *)uniqueKey;
@end
