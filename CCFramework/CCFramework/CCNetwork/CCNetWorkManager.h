//
//  CCNetWork.h
//  CCFramework
//
//  Created by 冯倩 on 2018/12/21.
//  Copyright © 2018年 Caroline. All rights reserved.
//

#import "AFHTTPSessionManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface CCNetWorkManager : AFHTTPSessionManager

typedef enum{
    GET,
    POST
}HTTPMethod;

//回调
typedef void (^requestSuccessBlock)(id Data);
typedef void (^requestFailureBlock)(NSError *error);
+ (instancetype)defaultManager;
//请求方法
- (void)requestWithMethod:(HTTPMethod)method withPath:(NSString *)path withParams:(NSDictionary *)params WithSuccessBlock:(requestSuccessBlock)success WithFailurBlock:(requestFailureBlock)failure;

@end

NS_ASSUME_NONNULL_END
