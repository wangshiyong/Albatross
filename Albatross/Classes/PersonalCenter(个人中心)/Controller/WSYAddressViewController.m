//
//  WSYAddressViewController.m
//  Albatross
//
//  Created by wangshiyong on 2017/12/11.
//  Copyright © 2017年 王世勇. All rights reserved.
//

#import "WSYAddressViewController.h"

// Controllers
#import "WSYAddAddressViewController.h"

// Views
#import "WSYAddressCell.h"

@interface WSYAddressViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *addBtn;

@end

@implementation WSYAddressViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self configureUI];
    [self bindUI];
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
    [self.view addSubview:self.tableView];
    @weakify(self);
    [self.view addSubview:self.addBtn];
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make){
        @strongify(self);
        make.bottom.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 110;
//    if (@available(iOS 11.0, *)) {
//        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//        self.tableView.estimatedRowHeight = 0;
//        self.tableView.estimatedSectionHeaderHeight = 0;
//        self.tableView.estimatedSectionFooterHeight = 0;
//    }
}

/**
 绑定UI信号
 */
- (void)bindUI
{
    @weakify(self);
    [[self.addBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x){
        @strongify(self);
        WSYAddAddressViewController *vc = [WSYAddAddressViewController new];
        vc.customNavBar.title = @"新增地址";
        vc.isAdd = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }];
}

#pragma mark ============Table view data source============

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    WSYAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([WSYAddressCell class]) owner:nil options:nil] lastObject];
    }
    if (indexPath.row == 0) {
        cell.addressLab.text = @"东省广东省广东省广东省广东省";
    } else {
        cell.addressLab.text = @"广东省广东省广东省广东省广东省广东省广东省广东省广东省广东省广东省广东省广东省广东省广东省广东省";
    }
    
    @weakify(self);
    [[cell.editBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x){
        WSYAddAddressViewController *vc = [WSYAddAddressViewController new];
        vc.customNavBar.title = @"修改地址";
        vc.isSelect = NO;
        @strongify(self);
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark ============懒加载============

- (UITableView *)tableView
{
    if (_tableView == nil) {
        CGRect frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight - 114);
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        //        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:@"WSYAddressCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (UIButton *)addBtn
{
    if (_addBtn == nil) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addBtn.titleLabel.font = [UIFont systemFontOfSize:18.0];
        [_addBtn setTitle:@"新增地址" forState: UIControlStateNormal];
        [_addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_addBtn setBackgroundImage:[UIImage imageNamed:@"Nav_bg"] forState:UIControlStateNormal];
//        _addBtn.layer.cornerRadius = 25;
//        _addBtn.layer.masksToBounds = YES;
    }
    return _addBtn;
}

@end
