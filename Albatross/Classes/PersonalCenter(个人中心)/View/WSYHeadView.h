//
//  WSYHeadViewCell.h
//  Albatross
//
//  Created by wangshiyong on 2017/12/15.
//  Copyright © 2017年 王世勇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSYHeadView : UICollectionReusableView

@property (nonatomic, strong)UIView *containView;
@property (nonatomic, strong)YYLabel *integralLab;
@property (nonatomic, strong)UIButton *headBtn;
@property (nonatomic, strong)UIButton *integralBtn;

@property (nonatomic, copy) dispatch_block_t myHeadImageViewClickBlock;
@property (nonatomic, copy) dispatch_block_t myHeadIntegralClickBlock;

@end
