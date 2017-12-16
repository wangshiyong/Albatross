//
//  Macros.h
//  Albatross
//
//  Created by wangshiyong on 2017/11/27.
//  Copyright © 2017年 王世勇. All rights reserved.
//

#ifndef Macros_h
#define Macros_h

/** 屏幕高度 */
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
/** 屏幕宽度 */
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

/*****************  屏幕适配  ******************/
#define iphone5 (kScreenHeight == 568)



/** RGB颜色(16进制) */
#define WSYColor_HEX(rgbValue, a) \
[UIColor colorWithRed:((CGFloat)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
green:((CGFloat)((rgbValue & 0xFF00) >> 8)) / 255.0 \
blue:((CGFloat)(rgbValue & 0xFF)) / 255.0 alpha:(a)]

#define WSYColor(r,g,b,a) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:a]
#define kThemeColor  [UIColor colorWithRed:251.0/255.0 green:88.0/255.0 blue:26.0/255.0 alpha:1.0]
#define kThemeTextColor  [UIColor colorWithRed:62.0/255.0 green:66.0/255.0 blue:70.0/255.0 alpha:1.0]
#define kLeftTextColor  [UIColor colorWithRed:45.0/255.0 green:45.0/255.0 blue:45.0/255.0 alpha:1.0]

#endif /* Macros_h */
