//
//  SJStaticTableViewController.m
//  SSJStaticTableViewDemo
//
//  Created by Sun Shijie on 2017/3/15.
//  Copyright © 2017年 Shijie. All rights reserved.
//

#import "SJStaticTableViewController.h"
#import "SJStaticTableViewDataSource.h"

@interface SJStaticTableViewController()

@property (nonatomic, readwrite, assign) SJDefaultDataType defualtDataType;

@end


@implementation SJStaticTableViewController

#pragma mark- init

- (instancetype)initWithDefaultDataType:(SJDefaultDataType)defualtDataType
{
    self = [super init];
    if (self) {
        self.defualtDataType = defualtDataType;
    }
    return self;
}

- (instancetype)init
{
    self = [self initWithDefaultDataType:SJDefaultDataTypeExist];
    return self;
}

#pragma mark- life circle
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //在能够提供给tableivew全部，或者部分数据源的情况下，可以先构造出tableview；
    //否则，需要在网络请求结束后，手动调用configureTableView方法
    if (self.defualtDataType == SJDefaultDataTypeExist) {
        [self configureTableView];
        [self configureNav];
    }
    
}

#pragma mark- configure subviews
- (void)configureNav
{
    [self.view addSubview:self.customNavBar];

    // 设置自定义导航栏背景图片
    self.customNavBar.barBackgroundImage = [UIImage imageNamed:@"Nav_bg"];

    // 设置自定义导航栏标题颜色
    self.customNavBar.titleLabelColor = [UIColor whiteColor];
    [self.customNavBar wr_setLeftButtonWithTitle:@"返回" titleColor:[UIColor whiteColor]];
//    if (self.navigationController.childViewControllers.count != 1) {
//        [self.customNavBar wr_setLeftButtonWithTitle:@"<返回" titleColor:[UIColor whiteColor]];
//    }
}

- (WRCustomNavigationBar *)customNavBar
{
    if (_customNavBar == nil) {
        _customNavBar = [WRCustomNavigationBar CustomNavigationBar];
    }
    return _customNavBar;
}

- (void)configureTableView
{
    [self createDataSource];
    [self createTableView];
}


- (void)createDataSource
{
    //交给子类实现

}

- (void)createTableView {
    
    if (!self.tableView) {
         self.tableView = [[SJStaticTableView alloc] initWithFrame:CGRectMake(0, 0, SJScreenWidth, SJScreenHeight)  style:UITableViewStylePlain];
         self.tableView.contentInset = UIEdgeInsetsMake(44,0,0,0);
         self.tableView.sjDelegate = self;
         self.tableView.sjDataSource = self.dataSource;
        [self.view addSubview:self.tableView];
    }
}



@end
