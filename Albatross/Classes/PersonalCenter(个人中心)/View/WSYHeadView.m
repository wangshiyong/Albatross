//
//  WSYHeadViewCell.m
//  Albatross
//
//  Created by wangshiyong on 2017/12/15.
//  Copyright © 2017年 王世勇. All rights reserved.
//

#import "WSYHeadView.h"

@implementation WSYHeadView

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
    self.backgroundColor = kThemeColor;
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.font = [UIFont systemFontOfSize:16.0f];
    self.nameLabel.textAlignment = NSTextAlignmentLeft;
    self.nameLabel.textColor = [UIColor whiteColor];
    self.nameLabel.text = @"思密达";
    
    self.headImage = [[UIImageView alloc] init];
    self.headImage.image = [UIImage imageNamed:@"image4"];
    
    [self addSubview:self.headImage];
    [self addSubview:self.nameLabel];
}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.headImage mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self).offset(16);
        make.top.equalTo(self).offset(75);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self).offset(90);
        make.centerY.equalTo(self.headImage);
        make.right.equalTo(self).offset(-100);
    }];
    
    
}

@end
