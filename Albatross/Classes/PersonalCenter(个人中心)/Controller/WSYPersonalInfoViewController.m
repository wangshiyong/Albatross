//
//  WSYPersonalInfoViewController.m
//  Albatross
//
//  Created by wangshiyong on 2017/12/15.
//  Copyright © 2017年 王世勇. All rights reserved.
//

#import "WSYPersonalInfoViewController.h"

@interface WSYPersonalInfoViewController ()

@end

@implementation WSYPersonalInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.customNavBar wr_setLeftButtonWithTitle:@"返回" titleColor:[UIColor whiteColor]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createDataSource
{
    self.dataSource = [[SJStaticTableViewDataSource alloc] initWithViewModelsArray:[Factory infoPageData] configureBlock:^(SJStaticTableViewCell *cell, SJStaticTableviewCellViewModel *viewModel) {
        
        switch (viewModel.staticCellType) {
                
            case SJStaticCellTypeSystemAccessoryDisclosureIndicator:
            {
                [cell configureAccessoryDisclosureIndicatorCellWithViewModel:viewModel];
            }
                break;

                
            default:
                break;
        }
    }];
}

//- (void)didSelectViewModel:(SJStaticTableviewCellViewModel *)viewModel atIndexPath:(NSIndexPath *)indexPath
//{
//
//    switch (viewModel.identifier)
//    {
//        case 4:
//        {
//            WSYAddressViewController *vc = [WSYAddressViewController new];
//            vc.customNavBar.title = @"收货地址";
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//            break;
//
//
//        case 5:
//        {
//            WSYFeedbackViewController *vc = [WSYFeedbackViewController new];
//            vc.customNavBar.title = @"意见反馈";
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//            break;
//
//
//        default:
//            break;
//    }
//}


@end
