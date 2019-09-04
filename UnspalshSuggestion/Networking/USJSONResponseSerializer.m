//
//  UnspalshSuggestion
//
//  Created by xiaoyu on 2019/9/3.
//  Copyright © 2019 xiaoyu. All rights reserved.
//

#import "USJSONResponseSerializer.h"

@implementation USJSONResponseSerializer

- (id)responseObjectForResponse:(NSURLResponse *)response
                           data:(NSData *)data
                          error:(NSError *__autoreleasing *)error {
    if (![self validateResponse:(NSHTTPURLResponse *)response data:data error:error]) {
        if (*error != nil && data != nil) {
            NSMutableDictionary* userInfo = [NSMutableDictionary dictionaryWithDictionary:[*error userInfo]];
            [userInfo setValue:data forKey:responce_data];
            *error = [NSError errorWithDomain:(*error).domain code:(*error).code userInfo:userInfo];
        }
        
        return data;
    }
    
    return ([super responseObjectForResponse:response data:data error:error]);
}
@end
