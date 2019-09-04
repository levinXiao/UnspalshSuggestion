//
//  UnspalshSuggestion
//
//  Created by xiaoyu on 2019/9/3.
//  Copyright © 2019 xiaoyu. All rights reserved.
//

#import "MBProgressHUD+USHUD.h"
#import "AppDelegate.h"

@implementation MBProgressHUD (USHUD)

+ (void)showMessage:(NSString *)msg into:(UIView *)view {
    dispatch_main_async_safe(^{
        [MBProgressHUD hideHUDForView:view animated:NO];
        if (msg.length==0) {
            return ;
        }
        MBProgressHUD *progressHUD = [[self alloc] initWithView:view];
        progressHUD.userInteractionEnabled = NO;
        progressHUD.removeFromSuperViewOnHide = YES;
        progressHUD.mode = MBProgressHUDModeText;
        progressHUD.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        progressHUD.bezelView.backgroundColor = [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.8];
        progressHUD.bezelView.layer.cornerRadius = 8.f;
        progressHUD.bezelView.layer.masksToBounds = YES;
        progressHUD.offset = CGPointMake(0, - (UI_NAVIGATIONBAR_HEIGHT + UI_STATUSBAR_HEIGHT)/2.f);
        progressHUD.label.text = msg;
        progressHUD.label.font = [UIFont systemFontOfSize:14.f];
        progressHUD.label.textColor = [UIColor whiteColor];
        progressHUD.label.numberOfLines = 0;
        progressHUD.margin = 10.f;
        [view addSubview:progressHUD];
        [progressHUD showAnimated:YES];
        [progressHUD hideAnimated:NO afterDelay:kDefaultShowDuration];
    });
}


+ (void)showMessageToWindow:(NSString *)msg {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UIView *view  =  appDelegate.window;
    [self showMessage:msg into:view];
}


+ (void)showActivityIndicatorTo:(UIView *)view {
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:view animated:NO];
        MBProgressHUD *progressHUD = [[self alloc] initWithView:view];
        progressHUD.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        progressHUD.userInteractionEnabled = NO;
        progressHUD.bezelView.backgroundColor = [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.8];
        progressHUD.bezelView.layer.cornerRadius = 8.f;
        progressHUD.bezelView.layer.masksToBounds = YES;
        progressHUD.removeFromSuperViewOnHide = YES;
        progressHUD.offset = CGPointMake(0, - (UI_NAVIGATIONBAR_HEIGHT + UI_STATUSBAR_HEIGHT)/2.f);
        [UIActivityIndicatorView appearanceWhenContainedInInstancesOfClasses:@[[MBProgressHUD class]]].color = [UIColor whiteColor];
        [view addSubview:progressHUD];
        [progressHUD showAnimated:YES];
    });
    
}

+ (void)showActivityIndicatorToWindow {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UIView *view  =  appDelegate.window;
    [self showActivityIndicatorTo:view];
}

/// 隐藏指定view上的旋转菊花
+ (void)hiddenActivityIndicatorFor:(UIView *)view {
    dispatch_main_async_safe(^{
        [MBProgressHUD hideHUDForView:view animated:NO];
    });
}

/// 隐藏window上的旋转菊花
+ (void)hiddenActivityIndicatorForWindow {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UIView *view  =  appDelegate.window;
    [self hiddenActivityIndicatorFor:view];
}
@end
