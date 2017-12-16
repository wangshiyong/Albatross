//
//  WSYNetworkTool.h
//  Albatross
//
//  Created by wangshiyong on 2017/12/8.
//  Copyright © 2017年 王世勇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSYNetworkTool : NSObject

typedef void(^SuccessBlock)(id response);
typedef void(^FailureBlock)(NSError *error);


/** 登录*/
+ (NSURLSessionTask *)getLoginWithParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure;




@end
