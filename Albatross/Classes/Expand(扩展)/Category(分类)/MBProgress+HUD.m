//
//  MBProgress+HUD.m
//  Albatross
//
//  Created by wangshiyong on 2017/12/27.
//  Copyright © 2017年 王世勇. All rights reserved.
//

#import "MBProgress+HUD.h"
#import "MBProgressHUD.h"
#import "UIImage+Tint.h"

@implementation UIViewController (HUD)

-(void)showHUD{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.labelText = @"数据加载中...";
}

-(void)showStrHUD:(NSString *)str
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.labelText = str;
}

-(void)showSuccessHUD:(NSString *)str
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    // Set the custom view mode to show any view.
    hud.mode = MBProgressHUDModeCustomView;
    // Set an image view with a checkmark.
    UIImage *image = [[UIImage imageNamed:@"P_success"] imageWithTintColor:[UIColor whiteColor]];
    hud.customView = [[UIImageView alloc] initWithImage:image];
    hud.labelText = str;
    [hud hide:YES afterDelay:1.f];
}

-(void)hideHUD
{
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
}

@end
