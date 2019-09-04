//
//  UnspalshSuggestion
//
//  Created by xiaoyu on 2019/9/3.
//  Copyright © 2019 xiaoyu. All rights reserved.
//
#import <UIKit/UIKit.h>

@class USPhotoModel;

@interface USPhotoListCell : UITableViewCell

@property (nonatomic, strong) UIImageView *photoView;

@property (nonatomic, strong) USPhotoModel *model;

@end
