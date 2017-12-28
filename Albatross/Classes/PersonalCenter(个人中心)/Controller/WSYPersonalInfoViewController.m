//
//  WSYPersonalInfoViewController.m
//  Albatross
//
//  Created by wangshiyong on 2017/12/15.
//  Copyright © 2017年 王世勇. All rights reserved.
//

#import "WSYPersonalInfoViewController.h"

// Vendors
#import <TZImagePickerController/TZImagePickerController.h>
#import <Photos/Photos.h>

// Categories
#import <TZImagePickerController/UIView+Layout.h>

@interface WSYPersonalInfoViewController ()<TZImagePickerControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    NSMutableArray *_selectedPhotos;
}

@property (nonatomic, strong) UIImagePickerController *imagePickerVc;

@end

@implementation WSYPersonalInfoViewController

//- (UIImagePickerController *)imagePickerVc {
//    if (_imagePickerVc == nil) {
//        _imagePickerVc = [[UIImagePickerController alloc] init];
//        _imagePickerVc.delegate = self;
//        // set appearance / 改变相册选择页的导航栏外观
//        if (iOS7Later) {
//            _imagePickerVc.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
//        }
//        _imagePickerVc.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
//        UIBarButtonItem *tzBarItem, *BarItem;
//        if (iOS9Later) {
//            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
//            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
//        } else {
//            tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class], nil];
//            BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
//        }
//        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
//        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
//        
//    }
//    return _imagePickerVc;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _selectedPhotos = [NSMutableArray array];

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

- (void)didSelectViewModel:(SJStaticTableviewCellViewModel *)viewModel atIndexPath:(NSIndexPath *)indexPath
{

    switch (viewModel.identifier)
    {
        case 0:
        {
            TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
//            imagePickerVc.naviBgColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Nav_bg"]];
            imagePickerVc.maxImagesCount = 1;
            imagePickerVc.showSelectBtn = NO;
            imagePickerVc.allowCrop = YES;
            imagePickerVc.needCircleCrop = YES;
            imagePickerVc.isStatusBarDefault = NO;
            imagePickerVc.allowTakePicture = NO;
            // 设置竖屏下的裁剪尺寸
            NSInteger left = 30;
            NSInteger widthHeight = self.view.tz_width - 2 * left;
            NSInteger top = (self.view.tz_height - widthHeight) / 2;
            imagePickerVc.cropRect = CGRectMake(left, top, widthHeight, widthHeight);
            // 你可以通过block或者代理，来得到用户选择的照片.
            [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
                _selectedPhotos = [NSMutableArray arrayWithArray:photos];

                viewModel.indicatorLeftImage = _selectedPhotos.lastObject;
                [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            }];
            [self presentViewController:imagePickerVc animated:YES completion:nil];
        }
            break;


        default:
            break;
    }
}


@end
