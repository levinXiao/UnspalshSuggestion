//
//  UnspalshSuggestion
//
//  Created by xiaoyu on 2019/9/3.
//  Copyright © 2019 xiaoyu. All rights reserved.
//

#import "USPhotoModel.h"
#import "USPhotoUrlModel.h"

@implementation USPhotoModel

+ (NSDictionary<NSString *,NSString *> *)replacedKeyFromPropertyName{
    
    return @{@"photoId":@"id",
             @"photoDescription":@"description"
             };
}


- (CGFloat)rowHeight {
    if (_rowHeight > 0) {
        return _rowHeight;
    }else {
        if (self.width > 0 && self.height > 0) {
            _rowHeight = (self.height / self.width ) * (SCREEN_WIDTH-10) + 10.f;
            return _rowHeight;
        }
       
    }
    return 0.f;
}
@end
