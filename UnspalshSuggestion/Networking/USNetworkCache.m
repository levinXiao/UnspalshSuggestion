//
//  UnspalshSuggestion
//
//  Created by xiaoyu on 2019/9/3.
//  Copyright © 2019 xiaoyu. All rights reserved.
//
#import "USNetworkCache.h"

#import <YYCache/YYCache.h>

static NSString * const USHTTPResponseCache = @"USHTTPResponseCache";

static YYCache *_dataCache = nil;

@implementation USNetworkCache

+ (void)initialize{
    
    //网络数据缓存
    _dataCache = [YYCache cacheWithName:USHTTPResponseCache];
    
}

+ (void)setCache:(id)data uniqueKey:(NSString *)uniqueKey{
    
    [_dataCache setObject:data forKey:uniqueKey withBlock:nil];
    
}

+ (id)cacheForUniqueKey:(NSString *)uniqueKey{
    
    return [_dataCache objectForKey:uniqueKey];
    
}
@end
