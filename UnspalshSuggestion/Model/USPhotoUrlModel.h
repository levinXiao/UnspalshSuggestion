//
//  UnspalshSuggestion
//
//  Created by xiaoyu on 2019/9/3.
//  Copyright © 2019 xiaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>

// 保存图片url的数据模型
@interface USPhotoUrlModel : NSObject
// 原图链接
@property (nonatomic, copy) NSString *raw;
// 大图链接
@property (nonatomic, copy) NSString *full;
// 正常图片链接
@property (nonatomic, copy) NSString *regular;
// 小图链接
@property (nonatomic, copy) NSString *small;
// 缩略图链接
@property (nonatomic, copy) NSString *thumb;

@end


