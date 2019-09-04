//
//  Macros.h
//  UnspalshSuggestion
//
//  Created by xiaoyu on 2019/9/3.
//  Copyright © 2019 xiaoyu. All rights reserved.
//

#define SCREEN_HEIGHT  MAX([UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height)
#define SCREEN_WIDTH   MIN([UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height)


#define UI_NAVIGATIONBAR_HEIGHT     44.f

#define UI_IS_IPHONE      [[UIDevice currentDevice].model isEqualToString:@"iPhone"]

#define UI_IS_IPHONE_X    (UI_IS_IPHONE && ((SCREEN_WIDTH/SCREEN_HEIGHT) < 0.5))

#define UI_STATUSBAR_HEIGHT         (UI_IS_IPHONE_X ? 44.f : 20.f)
