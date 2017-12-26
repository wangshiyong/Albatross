//
//  WSYUseIntegralViewController.h
//  Albatross
//
//  Created by wangshiyong on 2017/12/25.
//  Copyright © 2017年 王世勇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJScrollPageViewDelegate.h"
#import "ZJPageViewController.h"

@interface WSYUseIntegralViewController : ZJPageViewController<ZJScrollPageViewChildVcDelegate>

@property (strong, nonatomic) NSArray *data;

@end
