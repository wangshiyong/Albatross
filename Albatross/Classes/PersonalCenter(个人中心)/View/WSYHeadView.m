//
//  WSYHeadViewCell.m
//  Albatross
//
//  Created by wangshiyong on 2017/12/15.
//  Copyright © 2017年 王世勇. All rights reserved.
//

#import "WSYHeadView.h"
#import "UIButton+Layout.h"

@implementation WSYHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

#pragma mark - UI
- (void)setUpUI
{
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"P_bg"]];

    if (iphoneX) {
        self.containView = [[UIView alloc]initWithFrame:(CGRect){kScreenWidth - 100, 112, 100, 30}];
    } else {
        self.containView = [[UIView alloc]initWithFrame:(CGRect){kScreenWidth - 100, 90, 100, 30}];
    }
    self.containView.backgroundColor = [UIColor whiteColor];
    
    self.integralLab = [[YYLabel alloc]init];
    
    self.headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.headBtn setTitle:@"思密达" forState:UIControlStateNormal];
    [self.headBtn setImage:[UIImage imageNamed:@"image4"] forState:UIControlStateNormal];
    self.headBtn.imageRect = (CGRect){0, 0, 60, 60};
    self.headBtn.titleRect = (CGRect){74, 0, kScreenWidth - 200, 60};
    [self.headBtn addTarget:self action:@selector(headBtnBeTouched) forControlEvents:UIControlEventTouchUpInside];

    self.integralBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.integralBtn addTarget:self action:@selector(integralBtnBeTouched) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.headBtn];
    [self addSubview:self.containView];
    [self.containView addSubview:self.integralLab];
    [self addSubview:self.integralBtn];
    
    //设置所需的圆角位置以及大小
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.containView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(15, 15)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.containView.bounds;
    maskLayer.path = maskPath.CGPath;
    self.containView.layer.mask = maskLayer;
}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    @weakify(self);
    [self.headBtn mas_makeConstraints:^(MASConstraintMaker *make){
        @strongify(self);
        make.left.equalTo(self).offset(16);
        if (iphoneX) {
            make.top.equalTo(self).offset(97);
        } else {
            make.top.equalTo(self).offset(75);
        }
        make.right.equalTo(self).offset(-110);
    }];
    
    [self.integralLab mas_makeConstraints:^(MASConstraintMaker *make){
        @strongify(self);
        make.left.equalTo(self.containView).offset(5);
        make.centerY.equalTo(self.containView);
        make.size.mas_equalTo(CGSizeMake(105, 30));
    }];
    
    [self.integralBtn mas_makeConstraints:^(MASConstraintMaker *make){
        @strongify(self);
        make.left.equalTo(self.containView);
        make.top.equalTo(self).offset(70);
        make.size.mas_equalTo(CGSizeMake(105, 90));
    }];

}

- (void)headBtnBeTouched
{
    !_myHeadImageViewClickBlock ? : _myHeadImageViewClickBlock();
}

- (void)integralBtnBeTouched
{
    !_myHeadIntegralClickBlock ? : _myHeadIntegralClickBlock();
}

@end
