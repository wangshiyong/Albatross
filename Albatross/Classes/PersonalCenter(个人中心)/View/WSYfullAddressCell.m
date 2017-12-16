//
//  WSYfullAddressCell.m
//  Albatross
//
//  Created by wangshiyong on 2017/12/11.
//  Copyright © 2017年 王世勇. All rights reserved.
//

#import "WSYfullAddressCell.h"
#import "UITextView+Placeholder.h"

@implementation WSYfullAddressCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.hitLab = [[UILabel alloc]init];
        self.hitLab.text = @"详细地址";
        self.hitLab.font = [UIFont systemFontOfSize:14.0];
        self.hitLab.textColor = kThemeTextColor;
        
        self.textView = [[UITextView alloc]init];
        self.textView.placeholder = @"请填写详细地址，不少于5个字";
        self.textView.font = [UIFont systemFontOfSize:14.0];
        self.textView.textColor = kThemeTextColor;
        
        [self.contentView addSubview:self.hitLab];
        [self.contentView addSubview:self.textView];

    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self);
    
    [self.hitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView).offset(-10);
        make.top.equalTo(self.contentView);
        make.height.mas_equalTo(50);
    }];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(40, 10, 10, 10));
    }];
    
}

@end
