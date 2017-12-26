//
//  WSYLoginViewController.m
//  Albatross
//
//  Created by wangshiyong on 2017/12/7.
//  Copyright © 2017年 王世勇. All rights reserved.
//

#import "WSYLoginViewController.h"

// Controllers
#import "WSYRegisterViewController.h"

// Views
#import "WSYButton.h"

// Others
#import "PPNetworkHelper.h"

@interface WSYLoginViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UITextField *phoneTF;
@property (nonatomic, strong) UITextField *pwdTF;

@property (nonatomic, strong) UIView *phoneLine;
@property (nonatomic, strong) UIView *pwdLine;
@property (nonatomic, strong) UIView *leftLine;
@property (nonatomic, strong) UIView *rightLine;

/**境外手机按钮*/
@property (nonatomic, strong) WSYButton *overseasBtn;
/**无法登录按钮*/
@property (nonatomic, strong) UIButton *errorBtn;
/**手机验证登录按钮*/
@property (nonatomic, strong) UIButton *phoneLoginBtn;
/**账号注册按钮*/
@property (nonatomic, strong) UIButton *registerBtn;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIButton *qqBtn;
@property (nonatomic, strong) UIButton *weChatBtn;

@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation WSYLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self configureUI];
    [self bindUI];
    
    NSLog(@"网络缓存大小cache = %fKB",[PPNetworkCache getAllHttpCacheSize]/1024.f);

    
    NSDictionary *param = @{@"userName":@"d6666688888", @"psw":@"123456"};
    
    NSLog(@"%@",[PPNetworkCache httpCacheForURL:@"http://service.jezetrip.com:8081/Services/userserver.asmx/AourMemberLogin" parameters:param]);
    [WSYNetworkTool getLoginWithParameters:param success:^(id response) {
        NSLog(@"%@====",response[@"d"]);
    } failure:^(NSError *error) {
        NSLog(@"%@====",error);
    }];
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
    [self.view addSubview:self.phoneTF];
    [self.phoneTF mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        if (iphone5) {
            make.top.equalTo(self.view).offset(100);
        } else {
            make.top.equalTo(self.view).offset(120);
        }
        make.height.mas_equalTo(30);
    }];
    
    [self.view addSubview:self.phoneLine];
    [self.phoneLine mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.top.equalTo(self.phoneTF.mas_bottom).offset(4);
        make.height.mas_equalTo(1);
    }];
    
    [self.view addSubview:self.pwdTF];
    [self.pwdTF mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-140);
        if (iphone5) {
            make.top.equalTo(self.phoneTF.mas_bottom).offset(50);
        } else {
            make.top.equalTo(self.phoneTF.mas_bottom).offset(65);
        }
        make.height.mas_equalTo(30);
    }];
    
    [self.view addSubview:self.pwdLine];
    [self.pwdLine mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.top.equalTo(self.pwdTF.mas_bottom).offset(4);
        make.height.mas_equalTo(1);
    }];
    
    [self.view addSubview:self.errorBtn];
    [self.errorBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.equalTo(self.view).offset(-20);
        if (iphone5) {
            make.top.equalTo(self.phoneTF.mas_bottom).offset(50);
        }else{
            make.top.equalTo(self.phoneTF.mas_bottom).offset(65);
        }
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    
    [self.view addSubview:self.overseasBtn];
    [self.overseasBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.view).offset(25);
        make.top.equalTo(self.pwdTF.mas_bottom).offset(20);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    
    [self.view addSubview:self.loginBtn];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.view).offset(35);
        make.right.equalTo(self.view).offset(-35);
        make.centerY.equalTo(self.view).offset(20);
        make.height.mas_equalTo(50);
    }];
    
    [self.view addSubview:self.phoneLoginBtn];
    [self.phoneLoginBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.view).offset(40);
        make.top.equalTo(self.loginBtn.mas_bottom).offset(40);
        make.right.equalTo(self.view.mas_centerX).offset(-20);
        make.height.mas_equalTo(30);
    }];
    
    [self.view addSubview:self.registerBtn];
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.loginBtn.mas_bottom).offset(40);
        make.right.equalTo(self.view).offset(-40);
        make.left.equalTo(self.view.mas_centerX).offset(20);
        make.height.mas_equalTo(30);
    }];
    
    [self.view addSubview:self.qqBtn];
    [self.qqBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.equalTo(self.view).offset(-50);
        make.bottom.equalTo(self.view.mas_bottom).offset(-60);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];

    [self.view addSubview:self.weChatBtn];
    [self.weChatBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.equalTo(self.view).offset(50);
        make.bottom.equalTo(self.view.mas_bottom).offset(-60);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    [self.view addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.qqBtn.mas_top).offset(-30);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(80);
    }];
    
    [self.view addSubview:self.leftLine];
    [self.leftLine mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.equalTo(self.nameLabel.mas_left).offset(-8);
        make.left.equalTo(self.view).offset(50);
        make.bottom.equalTo(self.qqBtn.mas_top).offset(-40);
        make.height.mas_equalTo(1);
    }];
    
    [self.view addSubview:self.rightLine];
    [self.rightLine mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.nameLabel.mas_right).offset(8);
        make.right.equalTo(self.view).offset(-50);
        make.bottom.equalTo(self.qqBtn.mas_top).offset(-40);
        make.height.mas_equalTo(1);
    }];
}

- (void)bindUI
{
    @weakify(self);
    [[self.registerBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x){
        @strongify(self);
        WSYRegisterViewController *vc = [WSYRegisterViewController new];
        vc.customNavBar.title = @"注册";
        vc.isRegister = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    [[self.errorBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x){
        @strongify(self);
        WSYRegisterViewController *vc = [WSYRegisterViewController new];
        vc.customNavBar.title = @"找回密码";
        vc.isRegister = NO;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]init];
    [[recognizer rac_gestureSignal]subscribeNext:^(id x){
        @strongify(self);
        [self.pwdTF resignFirstResponder];
        [self.phoneTF resignFirstResponder];
    }];
    recognizer.delegate = self;
    [self.view addGestureRecognizer:recognizer];
}

#pragma mark ============懒加载============

- (UITextField *)phoneTF
{
    if (_phoneTF == nil) {
        _phoneTF = [[UITextField alloc] init];
        _phoneTF.font = [UIFont systemFontOfSize:17.0];
        _phoneTF.placeholder = @"请输入手机号";
        UIImageView *phoneImage = [[UIImageView alloc]initWithFrame:(CGRect){0, 0, 30, 30}];
        phoneImage.image = [UIImage imageNamed:@"P_phone"];
        _phoneTF.leftView = phoneImage;
        _phoneTF.leftViewMode = UITextFieldViewModeAlways;
        _phoneTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _phoneTF;
}

- (UITextField *)pwdTF
{
    if (_pwdTF == nil) {
        _pwdTF = [[UITextField alloc] init];
        _pwdTF.font = [UIFont systemFontOfSize:17.0];
        _pwdTF.placeholder = @"请输入密码";
        UIImageView *pwdImage = [[UIImageView alloc]initWithFrame:(CGRect){5, 0, 30, 30}];
        pwdImage.image = [UIImage imageNamed:@"P_pwd"];
        _pwdTF.leftView = pwdImage;
        _pwdTF.leftViewMode = UITextFieldViewModeAlways;
        _pwdTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _pwdTF.secureTextEntry = YES;
    }
    return _pwdTF;
}

- (UIView *)phoneLine
{
    if (_phoneLine == nil) {
        _phoneLine = [[UIView alloc]init];
        _phoneLine.backgroundColor = WSYColor(223, 223, 223, 1);
    }
    return _phoneLine;
}

- (UIView *)pwdLine
{
    if (_pwdLine == nil) {
        _pwdLine = [[UIView alloc]init];
        _pwdLine.backgroundColor = WSYColor(223, 223, 223, 1);
    }
    return _pwdLine;
}

- (UIView *)leftLine
{
    if (_leftLine == nil) {
        _leftLine = [[UIView alloc]init];
        _leftLine.backgroundColor = WSYColor(223, 223, 223, 1);
    }
    return _leftLine;
}

- (UIView *)rightLine
{
    if (_rightLine == nil) {
        _rightLine = [[UIView alloc]init];
        _rightLine.backgroundColor = WSYColor(223, 223, 223, 1);
    }
    return _rightLine;
}

- (UIButton *)errorBtn
{
    if (_errorBtn == nil) {
        _errorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _errorBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [_errorBtn setTitle:@"无法登录?" forState: UIControlStateNormal];
        [_errorBtn setTitleColor:WSYColor(89, 166, 235, 1) forState:UIControlStateNormal];
    }
    return _errorBtn;
}

- (UIButton *)overseasBtn
{
    if (_overseasBtn == nil) {
        _overseasBtn = [WSYButton buttonWithType:UIButtonTypeCustom];
        _overseasBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
        [_overseasBtn setImage:[UIImage imageNamed:@"P_info_1"] forState:UIControlStateNormal];
        [_overseasBtn setTitle:@"境外手机" forState: UIControlStateNormal];
        [_overseasBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _overseasBtn.imageRect = (CGRect){0, 0, 20, 20};
        _overseasBtn.titleRect = (CGRect){25, 0, 75, 30};
    }
    return _overseasBtn;
}

- (UIButton *)loginBtn
{
    if (_loginBtn == nil) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginBtn.titleLabel.font = [UIFont systemFontOfSize:20.0];
        [_loginBtn setTitle:@"登     录" forState: UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginBtn setBackgroundImage:[UIImage imageNamed:@"Nav_bg"] forState:UIControlStateNormal];
        _loginBtn.layer.cornerRadius = 25;
        _loginBtn.layer.masksToBounds = YES;
    }
    return _loginBtn;
}

- (UIButton *)phoneLoginBtn
{
    if (_phoneLoginBtn == nil) {
        _phoneLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (iphone5) {
            _phoneLoginBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        }else{
            _phoneLoginBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
        }
        [_phoneLoginBtn setTitle:@"手机验证登录" forState: UIControlStateNormal];
        [_phoneLoginBtn setTitleColor:WSYColor(72, 72, 72, 1) forState:UIControlStateNormal];
    }
    return _phoneLoginBtn;
}

- (UIButton *)registerBtn
{
    if (_registerBtn == nil) {
        _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (iphone5) {
            _registerBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        }else{
            _registerBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
        }
        [_registerBtn setTitle:@"账号注册>" forState: UIControlStateNormal];
        [_registerBtn setTitleColor:WSYColor(72, 72, 72, 1) forState:UIControlStateNormal];
    }
    return _registerBtn;
}

- (UIButton *)qqBtn
{
    if (_qqBtn == nil) {
        _qqBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_qqBtn setImage:[UIImage imageNamed:@"P_QQ"] forState:UIControlStateNormal];
    }
    return _qqBtn;
}

- (UIButton *)weChatBtn
{
    if (_weChatBtn == nil) {
        _weChatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_weChatBtn setImage:[UIImage imageNamed:@"P_weChat"] forState:UIControlStateNormal];
    }
    return _weChatBtn;
}

- (UILabel *)nameLabel
{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = [UIFont systemFontOfSize:13.0];
        _nameLabel.textColor = [UIColor lightGrayColor];
        _nameLabel.text = @"第三方登录";
        _nameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLabel;
}

@end
