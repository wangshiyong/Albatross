//
//  MBProgress+HUD.h
//  Albatross
//
//  Created by wangshiyong on 2017/12/27.
//  Copyright © 2017年 王世勇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIViewController (HUD)

-(void)showHUD;

-(void)showStrHUD:(NSString *)str;

-(void)showSuccessHUD:(NSString *)str;

-(void)hideHUD;

@end
