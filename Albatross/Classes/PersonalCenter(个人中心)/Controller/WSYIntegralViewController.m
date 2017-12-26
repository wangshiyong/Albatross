//
//  WSYIntegralViewController.m
//  Albatross
//
//  Created by wangshiyong on 2017/12/25.
//  Copyright © 2017年 王世勇. All rights reserved.
//

#import "WSYIntegralViewController.h"

// Controllers
#import "WSYGetIntegralViewController.h"
#import "WSYUseIntegralViewController.h"

// Vendors
#import "ZJScrollPageView.h"

// Categories
#import "UILabel+BezierAnimation.h"

#define NAVBAR_COLORCHANGE_POINT (IMAGE_HEIGHT - NAV_HEIGHT*2)
#define IMAGE_HEIGHT 96
#define NAV_HEIGHT 64

//NSString *const ZJParentTableViewDidLeaveFromTopNotification = @"ZJParentTableViewDidLeaveFromTopNotification";

@interface WSYCustomGestureTableView : UITableView

@end

@implementation WSYCustomGestureTableView

/// 返回YES同时识别多个手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return [gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]];
}

@end

@interface WSYIntegralViewController ()<UITableViewDelegate, UITableViewDataSource,ZJScrollPageViewDelegate,ZJPageViewControllerDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) WSYCustomGestureTableView *tableView;
@property (nonatomic, strong) ZJScrollSegmentView *segmentView;
@property (nonatomic, strong) ZJContentView *contentView;

@property (nonatomic, strong) NSArray<NSString *> *titles;

@property (nonatomic, strong) UIScrollView *childScrollView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UILabel *numLab;

@end

@implementation WSYIntegralViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self.view addSubview:self.tableView];
    [self.topView addSubview:self.numLab];
//    [self.view insertSubview:self.customNavBar aboveSubview:self.tableView];
//    [self.customNavBar wr_setBackgroundAlpha:0];
    [self.numLab animationFromnum:0 toNum:10000 duration:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ============tableview delegate / dataSource============
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [cell.contentView addSubview:self.contentView];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.segmentView;
}

#pragma mark ============ZJPageViewControllerDelegate============

- (void)scrollViewIsScrolling:(UIScrollView *)scrollView {
    _childScrollView = scrollView;
    if (self.tableView.contentOffset.y < IMAGE_HEIGHT) {
        scrollView.contentOffset = CGPointZero;
        scrollView.showsVerticalScrollIndicator = NO;
    }
    else {
        self.tableView.contentOffset = CGPointMake(0.0f, IMAGE_HEIGHT);
        scrollView.showsVerticalScrollIndicator = YES;
    }
}

#pragma mark ============UIScrollViewDelegate============

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    CGFloat offsetY = scrollView.contentOffset.y ;
    //    if (offsetY > NAVBAR_COLORCHANGE_POINT )
    //    {
    //        //        [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@"back"]];
    //        self.customNavBar.title = @"当前积分";
    //        CGFloat alpha = (offsetY - NAVBAR_COLORCHANGE_POINT) / NAV_HEIGHT;
    //        [self.customNavBar wr_setBackgroundAlpha:alpha];
    //        //        [self.customNavBar wr_setTintColor:[[UIColor whiteColor] colorWithAlphaComponent:alpha]];
    //        //        [self wr_setStatusBarStyle:UIStatusBarStyleDefault];
    //    }
    //    else
    //    {
    //        //        [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@"navLeft"]];
    //        self.customNavBar.title = @"";
    //        [self.customNavBar wr_setBackgroundAlpha:0];
    //        //        [self.customNavBar wr_setTintColor:[UIColor whiteColor]];
    //        //        [self wr_setStatusBarStyle:UIStatusBarStyleLightContent];
    //    }
    if (self.childScrollView && _childScrollView.contentOffset.y > 0) {
        self.tableView.contentOffset = CGPointMake(0.0f, IMAGE_HEIGHT);
    }
//    if(offsetY < IMAGE_HEIGHT) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:ZJParentTableViewDidLeaveFromTopNotification object:nil];
//    }
    
}

#pragma ============ZJScrollPageViewDelegate============
- (NSInteger)numberOfChildViewControllers
{
    return self.titles.count;
}

- (UIViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index
{
    UIViewController<ZJScrollPageViewChildVcDelegate> *childVc = reuseViewController;
    
    if (!childVc) {
        if (index == 0) {
            childVc = [[WSYGetIntegralViewController alloc]init];
            WSYGetIntegralViewController *vc = (WSYGetIntegralViewController *)childVc;
            vc.delegate = self;
        }else{
            childVc = [[WSYUseIntegralViewController alloc]init];
            WSYUseIntegralViewController *vc = (WSYUseIntegralViewController *)childVc;
            vc.delegate = self;
        }
    }
    return childVc;
}

#pragma mark ============懒加载============

- (WSYCustomGestureTableView *)tableView
{
    if (_tableView == nil) {
        CGRect frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64);
        _tableView = [[WSYCustomGestureTableView alloc] initWithFrame:frame style:UITableViewStylePlain];
//        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        _tableView.tableHeaderView = self.topView;
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableView.showsVerticalScrollIndicator = false;
        // 设置cell行高为contentView的高度
        _tableView.rowHeight = self.contentView.bounds.size.height;
        _tableView.sectionHeaderHeight = 54.0;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (UIView *)topView
{
    if (_topView == nil) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, IMAGE_HEIGHT)];
//        _topView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"P_bg"]];
        _topView.backgroundColor = WSYColor(255, 89, 24, 1);
    }
    return _topView;
}

- (UILabel *)numLab
{
    if (_numLab == nil) {
        _numLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, IMAGE_HEIGHT)];
        _numLab.textAlignment = NSTextAlignmentCenter;
        _numLab.font = [UIFont systemFontOfSize:50.0f];
        _numLab.textColor = [UIColor whiteColor];
    }
    return _numLab;
}

- (ZJScrollSegmentView *)segmentView
{
    if (_segmentView == nil) {
        ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
        style.showLine = YES;
        style.scrollLineColor = kThemeColor;
        style.autoAdjustTitlesWidth = YES;
        style.scaleTitle = YES;
//        style.scrollTitle = NO;
        style.titleFont = [UIFont systemFontOfSize:16.0f];
        //标题一般状态颜色 --- 注意一定要使用RGB空间的颜色值
        style.normalTitleColor = [UIColor grayColor];
        //标题选中状态颜色 --- 注意一定要使用RGB空间的颜色值
        style.selectedTitleColor = kThemeColor;
        
        self.titles = @[@"获取记录",
                        @"使用记录",
                        ];
        
        // 注意: 一定要避免循环引用!!
        __weak typeof(self) weakSelf = self;
        ZJScrollSegmentView *segment = [[ZJScrollSegmentView alloc] initWithFrame:CGRectMake(0, IMAGE_HEIGHT, kScreenWidth, 54.0) segmentStyle:style delegate:self titles:self.titles titleDidClick:^(ZJTitleView *titleView, NSInteger index) {
            
            [weakSelf.contentView setContentOffSet:CGPointMake(weakSelf.contentView.bounds.size.width * index, 0.0) animated:YES];
            
        }];
//        segment.backgroundColor = [UIColor lightGrayColor];
        _segmentView = segment;
        
    }
    return _segmentView;
}

- (ZJContentView *)contentView
{
    if (_contentView == nil) {
        ZJContentView *content = [[ZJContentView alloc] initWithFrame:(CGRect){0, 0, kScreenWidth, kScreenHeight - 118} segmentView:self.segmentView parentViewController:self delegate:self];
        _contentView = content;
    }
    return _contentView;
}

@end
