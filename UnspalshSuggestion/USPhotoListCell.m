//
//  UnspalshSuggestion
//
//  Created by xiaoyu on 2019/9/3.
//  Copyright © 2019 xiaoyu. All rights reserved.
//

#import "USPhotoListCell.h"
#import "USPhotoModel.h"
#import "USPhotoUrlModel.h"

@interface USPhotoListCell ()

@end

@implementation USPhotoListCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self layout];
    }
    return self;
}

- (void)layout {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.accessoryType = UITableViewCellAccessoryNone;
    
    self.photoView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.photoView.layer.cornerRadius = 4.f;
    self.photoView.layer.masksToBounds = YES;
    self.photoView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:self.photoView];
    [self.photoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(5.f);
        make.left.equalTo(self.contentView.mas_left).offset(5.f);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5.f);
        make.right.equalTo(self.contentView.mas_right).offset(-5.f);
    }];
}

- (void)setModel:(USPhotoModel *)model {
    _model = model;
    [self.photoView sd_setImageWithURL:[NSURL URLWithString:model.urls.thumb] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
}

@end
