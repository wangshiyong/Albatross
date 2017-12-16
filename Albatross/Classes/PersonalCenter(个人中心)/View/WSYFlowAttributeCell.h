//
//  WSYFlowAttributeCell.h
//  Albatross
//
//  Created by wangshiyong on 2017/12/15.
//  Copyright © 2017年 王世勇. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    WSYFlowTypeImage  =   0,
    WSYFlowTypeLabel  =   1,
} WSYFlowType;

@interface WSYFlowAttributeCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *numLab;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) BOOL isImageView;
@property (nonatomic, assign) WSYFlowType type;

@end
