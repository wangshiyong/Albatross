//
//  WSYFeedbackViewController.m
//  Albatross
//
//  Created by wangshiyong on 2017/12/11.
//  Copyright © 2017年 王世勇. All rights reserved.
//

#import "WSYFeedbackViewController.h"
#import "UITextView+Placeholder.h"

@interface WSYFeedbackViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIButton *submitsBtn;

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UILabel *hitLab;
@property (nonatomic, strong) UILabel *numberLab;

@property (nonatomic, strong) UITextView *textView;

@end

@implementation WSYFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
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
//    [self.view addSubview:self.bgView];
//    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make){
//        @strongify(self);
//        make.top.equalTo(self.view).offset(74);
//        make.left.right.equalTo(self.view);
//        make.height.mas_equalTo(270);
//    }];
//
//    [self.bgView addSubview:self.hitLab];
//    [self.hitLab mas_makeConstraints:^(MASConstraintMaker *make){
//        @strongify(self);
//        make.top.equalTo(self.bgView).offset(5);
//        make.left.equalTo(self.bgView).offset(15);
//        make.right.equalTo(self.bgView).offset(-15);
//        make.height.mas_equalTo(30);
//    }];
    
    [self.view addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make){
        @strongify(self);
        make.top.equalTo(self.view).offset(74);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(180);
    }];
    
//    [self.bgView addSubview:self.numberLab];
//    [self.numberLab mas_makeConstraints:^(MASConstraintMaker *make){
//        @strongify(self);
//        make.top.equalTo(self.textView.mas_bottom).offset(20);
//        make.left.equalTo(self.bgView).offset(15);
//        make.right.equalTo(self.bgView).offset(-15);
//        make.height.mas_equalTo(30);
//    }];
//
    [self.view addSubview:self.submitsBtn];
    [self.submitsBtn mas_makeConstraints:^(MASConstraintMaker *make){
        @strongify(self);
        make.top.equalTo(self.textView.mas_bottom).offset(60);
        make.left.equalTo(self.textView).offset(30);
        make.right.equalTo(self.textView).offset(-30);
        make.height.mas_equalTo(50);
    }];
}

/**
 绑定UI信号
 */
- (void)bindUI
{
    @weakify(self);
//    [self.textView.rac_textSignal subscribeNext:^(NSString *str){
//        @strongify(self);
//        if (str.length > 0) {
//            self.submitsBtn.enabled = YES;
//            self.submitsBtn.alpha = 1.0;
//            if (str.length >= 100) {
//                self.textView.text = [NSString stringWithFormat:@"%@",[str substringToIndex:100]];
//                self.numberLab.text = @"100/100";
//            } else {
//                self.numberLab.text = [NSString stringWithFormat:@"%lu/100",(unsigned long)str.length];
//            }
//        } else {
//            self.submitsBtn.enabled = NO;
//            self.submitsBtn.alpha = 0.4;
//        }
//    }];
    
    [[self.submitsBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x){
        @strongify(self);
        NSLog(@"1111");
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]init];
    [[recognizer rac_gestureSignal]subscribeNext:^(id x){
        @strongify(self);
        [self.textView resignFirstResponder];
    }];
    recognizer.delegate = self;
    [self.view addGestureRecognizer:recognizer];
}

#pragma mark ============懒加载============
//- (UIView *)bgView
//{
//    if (_bgView == nil) {
//        _bgView = [[UIView alloc]init];
//        _bgView.backgroundColor = [UIColor whiteColor];
//    }
//    return _bgView;
//}

- (UIButton *)submitsBtn
{
    if (_submitsBtn == nil) {
        _submitsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitsBtn.titleLabel.font = [UIFont systemFontOfSize:18.0];
        [_submitsBtn setBackgroundImage:[UIImage imageNamed:@"Nav_bg"] forState:UIControlStateNormal];
        [_submitsBtn setTitle:@"提    交" forState: UIControlStateNormal];
        _submitsBtn.layer.cornerRadius = 25;
        _submitsBtn.layer.masksToBounds = YES;
    }
    return _submitsBtn;
}

//- (UILabel *)hitLab
//{
//    if (_hitLab == nil) {
//        _hitLab = [[UILabel alloc]init];
//        _hitLab.textColor = [UIColor blackColor];
//        _hitLab.text = @"请输入您要对我们说的话";
//    }
//    return _hitLab;
//}
//
//- (UILabel *)numberLab
//{
//    if (_numberLab == nil) {
//        _numberLab = [[UILabel alloc]init];
//        _numberLab.textColor = [UIColor lightGrayColor];
//        _numberLab.text = @"0/100";
//        _numberLab.textAlignment = NSTextAlignmentRight;
//    }
//    return _numberLab;
//}

- (UITextView *)textView
{
    if (_textView == nil) {
        _textView = [[UITextView alloc]init];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.font = [UIFont systemFontOfSize:16];
        _textView.placeholder = @"请输入您要对我们说的话（100字以内）";
    }
    return _textView;
}

@end
