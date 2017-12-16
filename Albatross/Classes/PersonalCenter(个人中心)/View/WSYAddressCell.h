//
//  WSYAddressCell.h
//  Albatross
//
//  Created by wangshiyong on 2017/12/11.
//  Copyright © 2017年 王世勇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSYAddressCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *phoneLab;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UIButton *delBtn;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

@end
