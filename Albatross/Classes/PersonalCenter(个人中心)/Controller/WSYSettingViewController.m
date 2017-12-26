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


@end

@implementation WSYSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.customNavBar.title = @"设置";
    self.tableView = [[SJStaticTableView alloc] initWithFrame:CGRectMake(0, 0, SJScreenWidth, SJScreenHeight)  style:UITableViewStyleGrouped];
    
//    if (@available(iOS 11.0, *)) {
//        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//        self.tableView.estimatedRowHeight = 0;
//        self.tableView.estimatedSectionHeaderHeight = 0;
//        self.tableView.estimatedSectionFooterHeight = 0;
//    }
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
                cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Nav_bg"]];
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

@end
