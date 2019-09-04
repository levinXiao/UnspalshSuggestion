//
//  UnspalshSuggestion
//
//  Created by xiaoyu on 2019/9/3.
//  Copyright © 2019 xiaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class USPhotoUrlModel;

@interface USPhotoModel : NSObject

@property (nonatomic, copy) NSString *photoId;

@property (nonatomic, copy) NSString *created_at;

@property (nonatomic, copy) NSString *updated_at;
// 原始图片宽
@property (nonatomic, assign) CGFloat width;
// 原始图片高
@property (nonatomic, assign) CGFloat height;
// 颜色
@property (nonatomic, copy) NSString *color;
// 图片描述
@property (nonatomic, copy) NSString *photoDescription;
// url
@property (nonatomic, strong) USPhotoUrlModel *urls;

// 行高
@property (nonatomic, assign) CGFloat rowHeight;




@end


