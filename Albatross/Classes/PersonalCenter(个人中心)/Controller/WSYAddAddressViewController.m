//
//  WSYAddAddressViewController.m
//  Albatross
//
//  Created by wangshiyong on 2017/12/11.
//  Copyright © 2017年 王世勇. All rights reserved.
//

#import "WSYAddAddressViewController.h"

// Views
#import "WSYfullAddressCell.h"
#import "WSYTextField.h"

// Vendors
#import "BRAddressPickerView.h"

@interface WSYAddAddressViewController ()<UITableViewDelegate, UITableViewDataSource,UIGestureRecognizerDelegate,UITextFieldDelegate,UITextViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
/** 姓名 */
@property (nonatomic, strong) WSYTextField *nameTF;
/** 联系方式 */
@property (nonatomic, strong) WSYTextField *phoneTF;
/** 地区 */
@property (nonatomic, strong) WSYTextField *addressTF;
/** 街道 */
@property (nonatomic, strong) WSYTextField *roadTF;
/** 详细地址 */
@property (nonatomic, strong) WSYTextField *fullAddressTF;

@property (nonatomic, strong) NSArray *titleArr;

@end

@implementation WSYAddAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self configureUI];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self bindUI];
    });
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
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
    }
    
    [self.customNavBar wr_setRightButtonWithTitle:@"保存" titleColor:[UIColor whiteColor]];
    self.customNavBar.onClickRightButton = ^{
        NSLog(@"111");
    };
}

- (void)bindUI
{
    @weakify(self);
    [self.nameTF.rac_textSignal subscribeNext:^(NSString *str){
        @strongify(self);
        if([str length] > 11){
            self.nameTF.text = [NSString stringWithFormat:@"%@",[str substringToIndex:11]];
        }
    }];
    
    [self.phoneTF.rac_textSignal subscribeNext:^(NSString *str){
        @strongify(self);
        if([str length] > 11){
            self.phoneTF.text = [NSString stringWithFormat:@"%@",[str substringToIndex:11]];
        }
    }];
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]init];
    [[recognizer rac_gestureSignal]subscribeNext:^(id x){
        UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
        [keyWindow endEditing:YES];
    }];
    recognizer.delegate = self;
    [self.tableView addGestureRecognizer:recognizer];
}

- (BOOL)isChinaMobile:(NSString *)phoneNum
{
    NSString *CM = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$";
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    return [regextestcm evaluateWithObject:phoneNum];
}

#pragma mark ============Table view data source============

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.isAdd == NO && self.isSelect == YES) {
        return 3;
    } else if (self.isAdd == NO && self.isSelect == NO) {
        return 2;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 5;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 4) {
        return 100;
    }
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.textColor = kThemeTextColor;
    cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
    
    static NSString *cellIdentifier2 = @"Cell";
    WSYfullAddressCell *addressCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier2];
    if (addressCell == nil) {
        addressCell = [[WSYfullAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier2];
    }
    addressCell.textLabel.textColor = kThemeTextColor;
    
    if (self.isAdd == YES) {
        cell.textLabel.text = self.titleArr[indexPath.row];
        switch (indexPath.row) {
            case 0:
            {
                cell.accessoryType = UITableViewCellAccessoryNone;
                [self setupNameTF:cell];
            }
                break;
            case 1:
            {
                cell.accessoryType = UITableViewCellAccessoryNone;
                [self setupPhoneTF:cell];
            }
                break;
            case 2:
            {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                [self setupAddressTF:cell];
            }
                break;
            case 3:
            {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                [self setupRoadTF:cell];
            }
                break;
            case 4:
            {
                addressCell.accessoryType = UITableViewCellAccessoryNone;
                [self setupAddressTF:addressCell];
                return addressCell;
            }
                break;
            default:
                break;
        }
    } else {
        if (indexPath.section == 0) {
            cell.textLabel.text = self.titleArr[indexPath.row];
            switch (indexPath.row) {
                case 0:
                {
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    [self setupNameTF:cell];
                }
                    break;
                case 1:
                {
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    [self setupPhoneTF:cell];
                }
                    break;
                case 2:
                {
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    [self setupAddressTF:cell];
                }
                    break;
                case 3:
                {
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    [self setupRoadTF:cell];
                }
                    break;
                case 4:
                {
                    addressCell.accessoryType = UITableViewCellAccessoryNone;
                    addressCell.textView.delegate = self;
                    [self setupAddressTF:addressCell];
                    return addressCell;
                }
                    break;
                default:
                    break;
            }
        } else if (indexPath.section == 1 ) {
            if (self.isSelect == YES) {
                
            } else {
                cell.textLabel.text = @"删除地址";
                cell.textLabel.textColor = [UIColor redColor];
            }
        } else {
            cell.textLabel.text = @"删除地址";
            cell.textLabel.textColor = [UIColor redColor];
        }
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (WSYTextField *)getTextField:(UITableViewCell *)cell {
    WSYTextField *textField = [[WSYTextField alloc]initWithFrame:CGRectMake(100, 0, kScreenWidth - 140, 50)];
    textField.font = [UIFont systemFontOfSize:14.0f];
    textField.textColor = kThemeTextColor;
    textField.delegate = self;
    [cell.contentView addSubview:textField];
    return textField;
}

#pragma mark ============UITextViewDelegate============

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma mark ============懒加载============

- (UITableView *)tableView
{
    if (_tableView == nil) {
        CGRect frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64);
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
        _tableView.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (void)setupNameTF:(UITableViewCell *)cell {
    if (!_nameTF) {
        _nameTF = [self getTextField:cell];
        _nameTF.placeholder = @"请输入收货人";
        _nameTF.textAlignment = NSTextAlignmentLeft;
        _nameTF.tag = 0;
        _nameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
}

- (void)setupPhoneTF:(UITableViewCell *)cell {
    if (!_phoneTF) {
        _phoneTF = [self getTextField:cell];
        _phoneTF.placeholder = @"请输入联系电话";
        _phoneTF.keyboardType = UIKeyboardTypeNumberPad;
        _phoneTF.textAlignment = NSTextAlignmentLeft;
        _phoneTF.tag = 1;
        _phoneTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
}

- (void)setupAddressTF:(UITableViewCell *)cell {
    if (!_addressTF) {
        _addressTF = [self getTextField:cell];
        _addressTF.placeholder = @"请选择";
        _addressTF.textAlignment = NSTextAlignmentRight;
        @weakify(self);
        _addressTF.tapAcitonBlock = ^{
            [BRAddressPickerView showAddressPickerWithDefaultSelected:@[@10, @0, @3] isAutoSelect:NO resultBlock:^(NSArray *selectAddressArr) {
                @strongify(self);
                self.addressTF.text = [NSString stringWithFormat:@"%@%@%@", selectAddressArr[0], selectAddressArr[1], selectAddressArr[2]];
            }];
        };
    }
}

- (void)setupRoadTF:(UITableViewCell *)cell {
    if (!_roadTF) {
        _roadTF = [self getTextField:cell];
        _roadTF.placeholder = @"请选择";
        _roadTF.textAlignment = NSTextAlignmentRight;
        @weakify(self);
        _roadTF.tapAcitonBlock = ^{
            [BRAddressPickerView showAddressPickerWithDefaultSelected:@[@10, @0, @3] isAutoSelect:NO resultBlock:^(NSArray *selectAddressArr) {
                @strongify(self);
                self.roadTF.text = [NSString stringWithFormat:@"%@%@%@", selectAddressArr[0], selectAddressArr[1], selectAddressArr[2]];
            }];
        };
    }
}

- (NSArray *)titleArr {
    if (!_titleArr) {
        _titleArr = @[@"收货人", @"联系电话", @"所在地址", @"街道", @"详细地址"];
    }
    return _titleArr;
}

@end
