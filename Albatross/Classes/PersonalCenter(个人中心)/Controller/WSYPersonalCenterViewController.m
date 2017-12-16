//
//  WSYPersonalCenterViewController.m
//  Albatross
//
//  Created by wangshiyong on 2017/11/27.
//  Copyright © 2017年 王世勇. All rights reserved.
//

#import "WSYPersonalCenterViewController.h"

// Controllers
#import "WSYSettingViewController.h"
#import "WSYLoginViewController.h"
#import "WSYPersonalInfoViewController.h"
#import "WSYMessageViewController.h"

// Views
#import "WSYFlowAttributeCell.h"
#import "WSYHeadView.h"

// Vendors
#import "WRNavigationBar.h"
#import "RKNotificationHub.h"

#define NAVBAR_COLORCHANGE_POINT (IMAGE_HEIGHT - NAV_HEIGHT*2)
#define IMAGE_HEIGHT 160
#define NAV_HEIGHT 64

typedef NS_ENUM(NSInteger, WSYPersonalCenterSection) {
    WSYPersonalCenterSectionRecord  = 0,
    WSYPersonalCenterSectionMy      = 1,
    WSYPersonalCenterSectionSetting = 2,
};

static NSString *const WSYFlowAttributeCellID = @"WSYFlowAttributeCell";
static NSString *const WSYHeadViewID = @"WSYHeadViewID";
static NSString *const WSYCollectionReusableViewID = @"WSYCollectionReusableViewID";

@interface WSYPersonalCenterViewController ()<UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UIGestureRecognizerDelegate>{
    RKNotificationHub *hub;
}

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation WSYPersonalCenterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self configureUI];
    
//    self.collecionView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [self.collecionView.mj_header endRefreshing];
//        });
//    }];
//    [self.collecionView.mj_header beginRefreshing];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 构建界面UI
 */
- (void)configureUI
{
    self.customNavBar.barBackgroundColor = kThemeColor;
    [self.customNavBar wr_setBackgroundAlpha:0];
    [self.customNavBar wr_setBottomLineHidden:YES];
    
    [self.customNavBar wr_setLeftButtonWithTitle:@"设置" titleColor:[UIColor whiteColor]];
    @weakify(self);
    self.customNavBar.onClickLeftButton = ^{
        @strongify(self);
        WSYSettingViewController *vc = [WSYSettingViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    };
    
    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@"navLeft"]];
    hub = [[RKNotificationHub alloc]initWithView:self.customNavBar.rightButton];
    [hub moveCircleByX:-10 Y:15];
    [hub increment];
    [hub hideCount];
    self.customNavBar.onClickRightButton = ^{
        @strongify(self);
        WSYMessageViewController *vc = [WSYMessageViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    };
    
    [self.view addSubview:self.collectionView];
    [self.view insertSubview:self.customNavBar aboveSubview:self.collectionView];
    
    if (@available(iOS 11.0, *)) {
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//        self.tableView.estimatedRowHeight = 0;
//        self.tableView.estimatedSectionHeaderHeight = 0;
//        self.tableView.estimatedSectionFooterHeight = 0;
    }

}



#pragma mark ============UICollectionViewDataSource============
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    }
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    UICollectionViewCell *cell = nil;
    WSYFlowAttributeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:WSYFlowAttributeCellID forIndexPath:indexPath];
    if (indexPath.section == 0) {
//        WSYFlowAttributeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:WSYFlowAttributeCellID forIndexPath:indexPath];
        cell.type = WSYFlowTypeLabel;
        NSArray *titles = @[@"收藏夹",@"关注",@"足迹"];
        NSArray *numbers = @[@"10",@"20",@"1"];
        
        cell.titleLab.text = titles[indexPath.row];
        cell.numLab.text = numbers[indexPath.row];
    } else {
        cell.type = WSYFlowTypeImage;
        
        NSArray *titles = @[@"交易订单",@"优惠卷",@"积分查询",@"更多"];
        NSArray *numbers = @[@"image4",@"image4",@"image4",@"image4"];
        
        cell.imageView.image = [UIImage imageNamed:numbers[indexPath.row]];
        cell.titleLab.text = titles[indexPath.row];

    }
    
    return cell;
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        if (indexPath.section == 0) {
            WSYHeadView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:WSYHeadViewID forIndexPath:indexPath];
            UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]init];
            [recognizer.rac_gestureSignal subscribeNext:^(id x){
                //        WSYLoginViewController *vc = [WSYLoginViewController new];
                //        vc.customNavBar.title = @"登录";
                //        [self.navigationController pushViewController:vc animated:YES];
                WSYPersonalInfoViewController *vc = [WSYPersonalInfoViewController new];
                vc.customNavBar.title = @"账号资料";
                [self.navigationController pushViewController:vc animated:YES];
            }];
            recognizer.delegate = self;
            [headView addGestureRecognizer:recognizer];
            reusableview = headView;
        }
    }
    if (kind == UICollectionElementKindSectionFooter) {
        UICollectionReusableView *footview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:WSYCollectionReusableViewID forIndexPath:indexPath];
        footview.backgroundColor = [UIColor groupTableViewBackgroundColor];
        reusableview = footview;
    }
    
    return reusableview;
}

#pragma mark ============UICollectionViewDelegate============

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了帮组与反馈Item");
}

//item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return CGSizeMake(kScreenWidth/3, 60);
    }
    return CGSizeMake(kScreenWidth/4, 90);
}

//X间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

//Y间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

//head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(kScreenWidth, 160);
    }
    return CGSizeZero;
}

//foot宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    
    return CGSizeMake(kScreenWidth, 10);
}

#pragma mark ============懒加载============

- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        //设置尺寸
//        layout.itemSize = CGSizeMake(kScreenWidth/3 , 60);
//        layout.minimumLineSpacing = layout.minimumInteritemSpacing = 1;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 49);
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        //头部
        [_collectionView registerClass:[WSYHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:WSYHeadViewID];
        //尾部
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:WSYCollectionReusableViewID]; //分割线
        //cell
        [_collectionView registerClass:[WSYFlowAttributeCell class] forCellWithReuseIdentifier:WSYFlowAttributeCellID];
    }
    return _collectionView;
}

#pragma mark ============UIScrollViewDelegate============

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y ;
    if (offsetY > NAVBAR_COLORCHANGE_POINT )
    {
        [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@"back"]];
        self.customNavBar.title = @"个人信息";
        CGFloat alpha = (offsetY - NAVBAR_COLORCHANGE_POINT) / NAV_HEIGHT;
        [self.customNavBar wr_setBackgroundAlpha:alpha];
        //        [self.customNavBar wr_setTintColor:[[UIColor whiteColor] colorWithAlphaComponent:alpha]];
        //        [self wr_setStatusBarStyle:UIStatusBarStyleDefault];
    }
    else
    {
        [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@"navLeft"]];
        self.customNavBar.title = @"";
        [self.customNavBar wr_setBackgroundAlpha:0];
        //        [self.customNavBar wr_setTintColor:[UIColor whiteColor]];
        //        [self wr_setStatusBarStyle:UIStatusBarStyleLightContent];
    }
}

@end
