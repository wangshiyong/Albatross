//
//  WSYRegisterViewController.m
//  Albatross
//
//  Created by wangshiyong on 2017/12/7.
//  Copyright © 2017年 王世勇. All rights reserved.
//

#import "WSYRegisterViewController.h"

@interface WSYRegisterViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UITextField *phoneTF;
@property (nonatomic, strong) UITextField *codeTF;
@property (nonatomic, strong) UITextField *userNameTF;
@property (nonatomic, strong) UITextField *pwdTF;

@property (nonatomic, strong) UIView *phoneLine;
@property (nonatomic, strong) UIView *codeLine;
@property (nonatomic, strong) UIView *userNameLine;
@property (nonatomic, strong) UIView *pwdLine;

@property (nonatomic, strong) UIButton *registerBtn;
@property (nonatomic, strong) UIButton *codeBtn;
@property (nonatomic, strong) UIButton *areaCodeBtn;

@property (nonatomic, strong) YYLabel *registerLab;

@end

@implementation WSYRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self configureUI];
    [self bindUI];
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
    @weakify(self);
    [self.view addSubview:self.areaCodeBtn];
    [self.areaCodeBtn mas_makeConstraints:^(MASConstraintMaker *make){
        @strongify(self);
        make.left.equalTo(self.view).offset(20);
        if (iphone5) {
            make.top.equalTo(self.view).offset(100);
        } else {
            make.top.equalTo(self.view).offset(120);
        }
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(80);
    }];
    
    [self.view addSubview:self.phoneTF];
    [self.phoneTF mas_makeConstraints:^(MASConstraintMaker *make){
        @strongify(self);
        make.right.equalTo(self.view).offset(-20);
        if (iphone5) {
            make.top.equalTo(self.view).offset(100);
        } else {
            make.top.equalTo(self.view).offset(120);
        }
        make.height.mas_equalTo(30);
        make.left.equalTo(self.view).offset(100);
    }];
    
    [self.view addSubview:self.phoneLine];
    [self.phoneLine mas_makeConstraints:^(MASConstraintMaker *make){
        @strongify(self);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.top.equalTo(self.phoneTF.mas_bottom).offset(4);
        make.height.mas_equalTo(1);
    }];
    
    [self.view addSubview:self.codeTF];
    [self.codeTF mas_makeConstraints:^(MASConstraintMaker *make){
        @strongify(self);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-120);
        if (iphone5) {
            make.top.equalTo(self.view).offset(150);
        } else {
            make.top.equalTo(self.view).offset(180);
        }
        make.height.mas_equalTo(30);
    }];
    
    [self.view addSubview:self.codeBtn];
    [self.codeBtn mas_makeConstraints:^(MASConstraintMaker *make){
        @strongify(self);
        make.right.equalTo(self.view).offset(-20);
        if (iphone5) {
            make.top.equalTo(self.view).offset(150);
        } else {
            make.top.equalTo(self.view).offset(180);
        }
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(100);
    }];

    [self.view addSubview:self.codeLine];
    [self.codeLine mas_makeConstraints:^(MASConstraintMaker *make){
        @strongify(self);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.top.equalTo(self.codeTF.mas_bottom).offset(4);
        make.height.mas_equalTo(1);
    }];

    [self.view addSubview:self.userNameTF];
    [self.userNameTF mas_makeConstraints:^(MASConstraintMaker *make){
        @strongify(self);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        if (iphone5) {
            make.top.equalTo(self.view).offset(200);
        } else {
            make.top.equalTo(self.view).offset(240);
        }
        make.height.mas_equalTo(30);
    }];

    [self.view addSubview:self.userNameLine];
    [self.userNameLine mas_makeConstraints:^(MASConstraintMaker *make){
        @strongify(self);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.top.equalTo(self.userNameTF.mas_bottom).offset(4);
        make.height.mas_equalTo(1);
    }];

    [self.view addSubview:self.pwdTF];
    [self.pwdTF mas_makeConstraints:^(MASConstraintMaker *make){
        @strongify(self);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        if (iphone5) {
            make.top.equalTo(self.view).offset(250);
        } else {
            make.top.equalTo(self.view).offset(300);
        }
        make.height.mas_equalTo(30);
    }];

    [self.view addSubview:self.pwdLine];
    [self.pwdLine mas_makeConstraints:^(MASConstraintMaker *make){
        @strongify(self);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.top.equalTo(self.pwdTF.mas_bottom).offset(4);
        make.height.mas_equalTo(1);
    }];
    
    if (self.isRegister == YES) {
        [self.view addSubview:self.registerLab];
        [self.registerLab mas_makeConstraints:^(MASConstraintMaker *make){
            @strongify(self);
            make.left.equalTo(self.view).offset(35);
            make.right.equalTo(self.view).offset(-5);
            make.top.equalTo(self.pwdTF.mas_bottom).offset(25);
            make.height.mas_equalTo(30);
        }];
    }
    
    [self.view addSubview:self.registerBtn];
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make){
        @strongify(self);
        make.left.equalTo(self.view).offset(35);
        make.right.equalTo(self.view).offset(-35);
        make.top.equalTo(self.pwdTF.mas_bottom).offset(90);
        make.height.mas_equalTo(50);
    }];
}


- (void)bindUI
{
    @weakify(self);
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]init];
    [[recognizer rac_gestureSignal]subscribeNext:^(id x){
        @strongify(self);
        [self.pwdTF resignFirstResponder];
        [self.phoneTF resignFirstResponder];
        [self.codeTF resignFirstResponder];
        [self.pwdTF resignFirstResponder];
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
        phoneImage.image = [UIImage imageNamed:@"L_userName"];
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
        if (_isRegister == YES) {
            _pwdTF.placeholder = @"请输入密码";
        } else {
            _pwdTF.placeholder = @"确认密码";
        }
        UIImageView *pwdImage = [[UIImageView alloc]initWithFrame:(CGRect){5, 0, 30, 30}];
        pwdImage.image = [UIImage imageNamed:@"L_pwd"];
        _pwdTF.leftView = pwdImage;
        _pwdTF.leftViewMode = UITextFieldViewModeAlways;
        _pwdTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _pwdTF.secureTextEntry = YES;
    }
    return _pwdTF;
}

- (UITextField *)codeTF
{
    if (_codeTF == nil) {
        _codeTF = [[UITextField alloc] init];
        _codeTF.font = [UIFont systemFontOfSize:17.0];
        _codeTF.placeholder = @"请输入验证码";
        UIImageView *pwdImage = [[UIImageView alloc]initWithFrame:(CGRect){5, 0, 30, 30}];
        pwdImage.image = [UIImage imageNamed:@"L_pwd"];
        _codeTF.leftView = pwdImage;
        _codeTF.leftViewMode = UITextFieldViewModeAlways;
        _codeTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _codeTF.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _codeTF;
}

- (UITextField *)userNameTF
{
    if (_userNameTF == nil) {
        _userNameTF = [[UITextField alloc] init];
        _userNameTF.font = [UIFont systemFontOfSize:17.0];
        if (_isRegister == YES) {
            _userNameTF.placeholder = @"请输入用户名";
        } else {
            _userNameTF.placeholder = @"请输入新密码";
        }
        UIImageView *pwdImage = [[UIImageView alloc]initWithFrame:(CGRect){5, 0, 30, 30}];
        pwdImage.image = [UIImage imageNamed:@"L_pwd"];
        _userNameTF.leftView = pwdImage;
        _userNameTF.leftViewMode = UITextFieldViewModeAlways;
        _userNameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _userNameTF;
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

- (UIView *)codeLine
{
    if (_codeLine == nil) {
        _codeLine = [[UIView alloc]init];
        _codeLine.backgroundColor = WSYColor(223, 223, 223, 1);
    }
    return _codeLine;
}

- (UIView *)userNameLine
{
    if (_userNameLine == nil) {
        _userNameLine = [[UIView alloc]init];
        _userNameLine.backgroundColor = WSYColor(223, 223, 223, 1);
    }
    return _userNameLine;
}

- (YYLabel *)registerLab
{
    if (_registerLab == nil) {
        _registerLab = [[YYLabel alloc]init];
        NSString *str = @"点击注册即同意 《信天嗡用户注册协议》";
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:str];
        text.yy_font = [UIFont systemFontOfSize:14.0f];
        text.yy_color = [UIColor lightGrayColor];
        [text yy_setTextHighlightRange:NSMakeRange(8, (str.length - 8)) color:WSYColor(40, 180, 246, 1) backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
//            [self.navigationController popToRootViewControllerAnimated:YES];
            NSLog(@"《信天嗡用户注册协议》被点击了");
        }];
        _registerLab.attributedText = text;
        _registerLab.textAlignment = NSTextAlignmentLeft;
    }
    return _registerLab;
}

- (UIButton *)registerBtn
{
    if (_registerBtn == nil) {
        _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _registerBtn.titleLabel.font = [UIFont systemFontOfSize:20.0];
        if (_isRegister == YES) {
            [_registerBtn setTitle:@"注     册" forState: UIControlStateNormal];
        } else {
            [_registerBtn setTitle:@"确     定" forState: UIControlStateNormal];
        }
        _registerBtn.backgroundColor = kThemeColor;
        _registerBtn.layer.cornerRadius = 25;
        _registerBtn.layer.masksToBounds = YES;
    }
    return _registerBtn;
}

- (UIButton *)codeBtn
{
    if (_codeBtn == nil) {
        _codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _codeBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [_codeBtn setTitleColor:kThemeColor forState:UIControlStateNormal];
        [_codeBtn setTitle:@"获取验证码>" forState: UIControlStateNormal];
    }
    return _codeBtn;
}

- (UIButton *)areaCodeBtn
{
    if (_areaCodeBtn == nil) {
        _areaCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _areaCodeBtn.titleLabel.font = [UIFont systemFontOfSize:17.0];
        [_areaCodeBtn setTitleColor:WSYColor(12, 153, 246, 1) forState:UIControlStateNormal];
        [_areaCodeBtn setTitle:@"+8600" forState: UIControlStateNormal];
    }
    return _areaCodeBtn;
}

@end
