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

#define WSYCachesPath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]

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
                if (viewModel.identifier == 3) {
                    viewModel.indicatorLeftTitle = [NSString stringWithFormat:@"%.2fM",[self getCashes]];
                }
                [cell configureAccessoryDisclosureIndicatorCellWithViewModel:viewModel];
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
        case 3:
        {
            NSString *cashes = [NSString stringWithFormat:@"%.2f",[self getCashes]];
            if (![cashes isEqualToString:@"0.00"]) {
                [self cleanup];
                viewModel.indicatorLeftTitle = @"0.00M";
            }
        }
            break;
            
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
            
        case 7:
        {
            [self logout];
        }
            
        default:
            break;
    }
}

/**
 退出登录
 */
- (void)logout
{
    SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
    [alert setHorizontalButtons:YES];
    [alert addButton:@"确定" actionBlock:^(void) {
        
    }];
    alert.completeButtonFormatBlock = ^NSDictionary* (void) {
        NSMutableDictionary *buttonConfig = [[NSMutableDictionary alloc] init];
        buttonConfig[@"backgroundColor"] = [UIColor lightGrayColor];
        return buttonConfig;
    };
    
    [alert showCustom:[UIImage imageNamed:@"P_logout"] color:kThemeColor title:@"退出登录" subTitle:@"确定退出当前登录?"closeButtonTitle:@"取消" duration:0.0f];
}

/**
 清理缓存
 */
-(void)cleanup{
    SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
    [alert setHorizontalButtons:YES];
    [alert addButton:@"确定" actionBlock:^(void) {
        NSString *path = WSYCachesPath;
        NSFileManager *fileManager=[NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:path]) {
            NSArray *childerFiles=[fileManager subpathsAtPath:path];
            for (NSString *fileName in childerFiles) {
                NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
                [fileManager removeItemAtPath:absolutePath error:nil];
            }
            [self showStrHUD:@"正在清理中..."];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self hideHUD];
                [self showSuccessHUD:@"清理完成"];
            });
        }
    }];
    alert.completeButtonFormatBlock = ^NSDictionary* (void) {
        NSMutableDictionary *buttonConfig = [[NSMutableDictionary alloc] init];
        buttonConfig[@"backgroundColor"] = [UIColor lightGrayColor];
        return buttonConfig;
    };
    
    [alert showCustom:self image:[UIImage imageNamed:@"P_clean"] color:kThemeColor title:@"清理缓存" subTitle:[NSString stringWithFormat:@"缓存大小为%.2fM,是否要清理缓存?", [self getCashes]] closeButtonTitle:@"取消" duration:0.0f];
}

-(float)getCashes{
    NSString *path = WSYCachesPath;
    NSFileManager *fileManager=[NSFileManager defaultManager];
    float folderSize = 0.0;
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles = [fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            NSString *fullPath = [path stringByAppendingPathComponent:fileName];
            folderSize += [self fileSizeAtPath:fullPath];
        }
    }
    return folderSize;
}

-(float)fileSizeAtPath:(NSString *)path{
    
    NSFileManager *fileManager=[NSFileManager defaultManager];
    
    if([fileManager fileExistsAtPath:path]){
        
        long long size=[fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size/1024.0/1024.0;
    }
    return 0;
}

@end
