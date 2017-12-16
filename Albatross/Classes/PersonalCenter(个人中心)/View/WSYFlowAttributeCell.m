//
//  WSYFlowAttributeCell.m
//  Albatross
//
//  Created by wangshiyong on 2017/12/15.
//  Copyright © 2017年 王世勇. All rights reserved.
//

#import "WSYFlowAttributeCell.h"

@implementation WSYFlowAttributeCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {        
        [self setUpUI];
    }
    return self;
}

#pragma mark - UI
- (void)setUpUI
{
    self.backgroundColor = [UIColor whiteColor];
    
    self.isImageView = NO;  //默认为No
    self.imageView = [[UIImageView alloc] init];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    self.titleLab = [[UILabel alloc] init];
    self.titleLab.font = [UIFont systemFontOfSize:12.0f];
    self.titleLab.textAlignment = NSTextAlignmentCenter;
    self.titleLab.textColor = [UIColor darkGrayColor];
    
    self.numLab = [[UILabel alloc] init];
    self.numLab.font = [UIFont systemFontOfSize:12.0f];
    self.numLab.textAlignment = NSTextAlignmentCenter;
    self.numLab.textColor = [UIColor darkGrayColor];
    
//    [self addSubview:self.numLab];
//    [self addSubview:self.titleLab];
}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.type == WSYFlowTypeImage) {
        
        [self addSubview:self.imageView];
        [self addSubview:self.titleLab];
        
        [self setUpTypeWithTopImageVewBottonLabel];
    }else{
        [self addSubview:self.titleLab];
        if (self.isImageView) {
            [self addSubview:self.imageView];
            [self setUpTypeWithTopImageVewBottonLabel];
        }else{
            [self addSubview:self.numLab];
            [self setUpTypeWithTopLabelBottonLabel];
        }
    }
    
}

#pragma mark - typeOne
- (void)setUpTypeWithTopImageVewBottonLabel
{
    [self.numLab removeFromSuperview];
    
    @weakify(self);
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(12);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerX.equalTo(self);
        make.top.equalTo(self.imageView.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth/4, 30));
    }];
}

#pragma mark - typeTwo
- (void)setUpTypeWithTopLabelBottonLabel
{
    [self.imageView removeFromSuperview];
    
    @weakify(self);
    [self.numLab mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerX.mas_equalTo(self);
        make.top.equalTo(self).offset(5);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth/4, 30));
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.centerX.mas_equalTo(self);
        make.top.equalTo(self.numLab.mas_bottom).offset(-5);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth/4, 30));
    }];
}


@end
