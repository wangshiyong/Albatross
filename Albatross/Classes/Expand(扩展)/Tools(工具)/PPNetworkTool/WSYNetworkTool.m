//
//  WSYNetworkTool.m
//  Albatross
//
//  Created by wangshiyong on 2017/12/8.
//  Copyright © 2017年 王世勇. All rights reserved.
//

#import "WSYNetworkTool.h"
#import "PPNetworkHelper.h"
#import "WSYInterfacedConst.h"

@implementation WSYNetworkTool

+ (NSURLSessionTask *)getLoginWithParameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure
{
    NSString *url = [NSString stringWithFormat:@"%@%@",kApiPrefix,kLogin];
    return [self requestWithURL:url parameters:parameters success:success failure:failure];
}

#pragma mark - 请求的公共方法

+ (NSURLSessionTask *)requestWithURL:(NSString *)URL parameters:(NSDictionary *)parameter success:(SuccessBlock)success failure:(FailureBlock)failure
{
    [PPNetworkHelper setRequestTimeoutInterval:5];
    [PPNetworkHelper setRequestSerializer:PPRequestSerializerJSON];
    [PPNetworkHelper setResponseSerializer:PPResponseSerializerJSON];
    
    // 发起请求
    return [PPNetworkHelper POST:URL parameters:parameter responseCache:^(id responseCache) {
        //加载缓存数据
    } success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
