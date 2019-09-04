//
//  UnspalshSuggestion
//
//  Created by xiaoyu on 2019/9/3.
//  Copyright © 2019 xiaoyu. All rights reserved.
//

#import "MBProgressHUD.h"

#define kDefaultShowDuration  1.f // 默认显示时间

@interface MBProgressHUD (USHUD)

+ (void)showMessage:(NSString *)msg into:(UIView *)view;

+ (void)showMessageToWindow:(NSString *)msg;

+ (void)showActivityIndicatorTo:(UIView *)view;

+ (void)showActivityIndicatorToWindow;

+ (void)hiddenActivityIndicatorFor:(UIView *)view;

+ (void)hiddenActivityIndicatorForWindow;
@end
