//
//  WSYMessageCell.m
//  Albatross
//
//  Created by wangshiyong on 2017/12/15.
//  Copyright © 2017年 王世勇. All rights reserved.
//

#import "WSYMessageCell.h"

@implementation WSYMessageCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.title = [[UILabel alloc]init];
        self.title.text = @"思密达";
        self.title.font = [UIFont systemFontOfSize:16.0];
        self.title.textColor = kThemeTextColor;
        
        self.subTitle = [[UILabel alloc]init];
        self.subTitle.text = @"您有一条新的短消息，请注意查收！";
        self.subTitle.font = [UIFont systemFontOfSize:12.0];
        self.subTitle.textColor = [UIColor lightGrayColor];
        
        self.time = [[UILabel alloc]init];
        self.time.text = @"13:00";
        self.time.font = [UIFont systemFontOfSize:12.0];
        self.time.textColor = [UIColor lightGrayColor];
        self.time.textAlignment = NSTextAlignmentRight;
        
        self.image = [[UIImageView alloc]init];
        self.image.image = [UIImage imageNamed:@"image4"];
        
        [self.contentView addSubview:self.title];
        [self.contentView addSubview:self.subTitle];
        [self.contentView addSubview:self.time];
        [self.contentView addSubview:self.image];
        

    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self);
    
    [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.contentView).offset(16);
        make.top.equalTo(self.contentView).offset(5);
        make.width.height.mas_equalTo(60);
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.contentView).offset(90);
        make.top.equalTo(self.contentView).offset(5);
        make.right.equalTo(self.contentView).offset(-80);
        make.height.mas_equalTo(30);
    }];
    
    [self.subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.contentView).offset(90);
        make.top.equalTo(self.title.mas_bottom);
        make.right.equalTo(self.contentView).offset(-80);
        make.height.mas_equalTo(30);
    }];
    
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.contentView).offset(5);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(70);
    }];
}

@end
