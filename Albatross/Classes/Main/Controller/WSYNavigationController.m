//
//  WSYNavigationController.m
//  Albatross
//
//  Created by wangshiyong on 2017/11/27.
//  Copyright © 2017年 王世勇. All rights reserved.
//

#import "WSYNavigationController.h"

@interface WSYNavigationController ()

@end

@implementation WSYNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end
