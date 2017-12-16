//
//  WSYSettingViewController.m
//  Albatross
//
//  Created by wangshiyong on 2017/12/6.
//  Copyright © 2017年 王世勇. All rights reserved.
//

#import "WSYSettingViewController.h"

// Controllers
#import "WSYFeedbackViewController.h"
#import "WSYAddressViewController.h"

// Vendors
#import "SJStaticTableViewCell+MeAvatar.h"

@interface WSYSettingViewController ()

@property (nonatomic, strong) UIButton *logoutBtn;

@end

@implementation WSYSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.customNavBar.title = @"设置";
    
    [self.customNavBar wr_setLeftButtonWithTitle:@"返回" titleColor:[UIColor whiteColor]];
    
    self.logoutBtn.frame  = (CGRect){35, kScreenHeight - 100, kScreenWidth - 70, 50};
    [self.view addSubview:self.logoutBtn];
//    [self.tableView bringSubviewToFront:self.logoutBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createDataSource
{
    self.dataSource = [[SJStaticTableViewDataSource alloc] initWithViewModelsArray:[Factory mePageData] configureBlock:^(SJStaticTableViewCell *cell, SJStaticTableviewCellViewModel *viewModel) {
        
        switch (viewModel.staticCellType) {
                
            case SJStaticCellTypeSystemAccessoryDisclosureIndicator:
            {
                [cell configureAccessoryDisclosureIndicatorCellWithViewModel:viewModel];
            }
                break;
                
                
            case SJStaticCellTypeMeAvatar:
            {
                [cell configureMeAvatarTableViewCellWithViewModel:viewModel];
            }
                break;
                
            case SJStaticCellTypeSystemLogout:
            {
                [cell configureLogoutTableViewCellWithViewModel:viewModel];
            }
                break;
                
            default:
                break;
        }
    }];
}

- (void)didSelectViewModel:(SJStaticTableviewCellViewModel *)viewModel atIndexPath:(NSIndexPath *)indexPath
{
    
    switch (viewModel.identifier)
    {
        case 4:
        {
            WSYAddressViewController *vc = [WSYAddressViewController new];
            vc.customNavBar.title = @"收货地址";
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;

            
        case 5:
        {
            WSYFeedbackViewController *vc = [WSYFeedbackViewController new];
            vc.customNavBar.title = @"意见反馈";
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
            
        default:
            break;
    }
}

#pragma mark ============懒加载============

- (UIButton *)logoutBtn
{
    if (_logoutBtn == nil) {
        _logoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _logoutBtn.backgroundColor = kThemeColor;
        _logoutBtn.titleLabel.font = [UIFont systemFontOfSize:20.0];
        [_logoutBtn setTitle:@"退出登录" forState: UIControlStateNormal];
        [_logoutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _logoutBtn.layer.cornerRadius = 25;
        _logoutBtn.layer.masksToBounds = YES;
    }
    return _logoutBtn;
}


@end
