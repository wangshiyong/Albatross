//
//  WSYHomeViewController.m
//  Albatross
//
//  Created by wangshiyong on 2017/12/28.
//  Copyright © 2017年 王世勇. All rights reserved.
//

#import "WSYHomeViewController.h"

// Vendors
#import "SDCycleScrollView.h"

//#define NAVBAR_COLORCHANGE_POINT (-IMAGE_HEIGHT + NAV_HEIGHT)
//#define NAV_HEIGHT 64
//#define IMAGE_HEIGHT 200

@interface WSYHomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

/** 轮播图 */
@property (nonatomic, strong) SDCycleScrollView *advView;

@property (nonatomic, strong) UIButton *searchButton;

@end

@implementation WSYHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureUI];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 构建界面UI
 */
- (void)configureUI
{
    //    self.customNavBar.barBackgroundColor = kThemeColor;
    [self.customNavBar wr_setBackgroundAlpha:0];
    
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"P_setting"]];
    @weakify(self);
    self.customNavBar.onClickLeftButton = ^{
        @strongify(self);
//        WSYSettingViewController *vc = [WSYSettingViewController new];
//        [self.navigationController pushViewController:vc animated:YES];
    };
    
    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@"P_info"]];
    self.customNavBar.onClickRightButton = ^{
        @strongify(self);
//        WSYMessageViewController *vc = [WSYMessageViewController new];
//        [self.navigationController pushViewController:vc animated:YES];
    };
    
//    [self.customNavBar.centerButton setTitle:@"搜索职位/公司/商区" forState:UIControlStateNormal];
    [self.customNavBar wr_setCenterButtonWithTitle:@"搜索职位/公司/商区" titleColor:[UIColor redColor]];
    
    [self.collectionView addSubview:self.advView];
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
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor greenColor];
    
    return cell;
    
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

#pragma mark ============UIScrollViewDelegate============

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y ;
    
    if (offsetY < -IMAGE_HEIGHT) {
        [self updateNavBarButtonItemsAlphaAnimated:.0f];
    } else {
        [self updateNavBarButtonItemsAlphaAnimated:1.0f];
    }
    
    if (offsetY > NAVBAR_COLORCHANGE_POINT - IMAGE_HEIGHT)
    {
        //        [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@"back"]];
//        self.customNavBar.title = @"个人信息";
        CGFloat alpha = (offsetY - NAVBAR_COLORCHANGE_POINT + IMAGE_HEIGHT) / NAV_HEIGHT;
        [self.customNavBar wr_setBackgroundAlpha:alpha];
        //        [self.customNavBar wr_setTintColor:[[UIColor whiteColor] colorWithAlphaComponent:alpha]];
        //        [self wr_setStatusBarStyle:UIStatusBarStyleDefault];
    }
    else
    {
        //        [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@"navLeft"]];
//        self.customNavBar.title = @"";
        [self.customNavBar wr_setBackgroundAlpha:0];
        //        [self.customNavBar wr_setTintColor:[UIColor whiteColor]];
        //        [self wr_setStatusBarStyle:UIStatusBarStyleLightContent];
    }
}

- (void)updateNavBarButtonItemsAlphaAnimated:(CGFloat)alpha
{
    [UIView animateWithDuration:0.2 animations:^{
        self.customNavBar.leftButton.alpha = alpha;
        self.customNavBar.rightButton.alpha = alpha;
    }];
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
        _collectionView.contentInset = UIEdgeInsetsMake(IMAGE_HEIGHT, 0, 0, 0);
        
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
//        //头部
//        [_collectionView registerClass:[WSYHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:WSYHeadViewID];
//        //尾部
//        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:WSYCollectionReusableViewID]; //分割线
//        //cell
//        [_collectionView registerClass:[WSYFlowAttributeCell class] forCellWithReuseIdentifier:WSYFlowAttributeCellID];
    }
    return _collectionView;
}

- (SDCycleScrollView *)advView
{
    if (_advView == nil) {
        NSArray *localImages = @[@"lagou0", @"lagou1", @"lagou2", @"lagou3"];
        _advView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, -IMAGE_HEIGHT, kScreenWidth, IMAGE_HEIGHT) imageNamesGroup:localImages];
        _advView.pageDotColor = [UIColor grayColor];
        _advView.autoScrollTimeInterval = 2;
        _advView.currentPageDotColor = [UIColor whiteColor];
        _advView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    }
    return _advView;
}

//- (UIButton*)searchButton
//{
//    if (_searchButton == nil) {
//        _searchButton = [[UIButton alloc]initWithFrame:CGRectMake(0, -3, 230, 30)];
//        [_searchButton setTitle:@"搜索职位/公司/商区" forState:UIControlStateNormal];
//        _searchButton.titleLabel.font = [UIFont systemFontOfSize:13];
//        [_searchButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
////        [_searchButton setBackgroundImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
//        self.customNavBar.centerButton = _searchButton;
//    }
//    return _searchButton;
//}

- (int)navBarBottom
{
    if (iphoneX) {
        return 88;
    } else {
        return 64;
    }
}

@end
