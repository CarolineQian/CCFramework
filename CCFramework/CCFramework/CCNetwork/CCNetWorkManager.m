//
//  CCNetWork.m
//  CCFramework
//
//  Created by 冯倩 on 2018/12/21.
//  Copyright © 2018年 Caroline. All rights reserved.
//

#import "CCNetWorkManager.h"
#import "NetWorkManagerModel.h"

@implementation CCNetWorkManager

+ (instancetype)defaultManager
{
    static CCNetWorkManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once( &onceToken,^{
        manager = [[self alloc] initWithBaseURL:[NSURL URLWithString:@"http://api.test.bpal.io:8080/"]];
    });
    return manager;
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
//        配置请求格式
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        self.requestSerializer.stringEncoding = NSUTF8StringEncoding;
        self.requestSerializer.timeoutInterval = 30;
        [self.requestSerializer setValue:@"*/*" forHTTPHeaderField:@"Accept"];
        [self.requestSerializer setValue:url.absoluteString forHTTPHeaderField:@"Referer"];
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [self.requestSerializer setValue:@"" forHTTPHeaderField:@"Authorization"];
        [self.requestSerializer setValue:@"BpalE/2.1 iOS IDFV/0BE4CD54A2F549DA9AB42318106D104E Lang/zh-Hans" forHTTPHeaderField:@"User-Agent"];
        [self.requestSerializer setValue:@"827B0946-7D52-4DAC-8C39-F2A7EAD6B677" forHTTPHeaderField:@"X-SIG-SALT"];
        [self.requestSerializer setValue:@"1545466545852" forHTTPHeaderField:@"X-SIG-TIME"];
        [self.requestSerializer setValue:@"13b9c6f34c3d261a78e70b78212f2063" forHTTPHeaderField:@"X-SIG-CHECKSUM"];
//        配置解析格式
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                               @"text/json",
                                                                               @"text/javascript",
                                                                               @"text/html",
                                                                               @"text/plain",
                                                                               @"text/xml",
                                                                               @"image/*",
                                                                               @"application/octet-stream",
                                                                               @"application/xml",
                                                                               @"application/zip"]];//若接收类型不一致会替换一致
        
        
    }
    return self;
}

#pragma mark - 处理请求
- (void)requestWithMethod:(HTTPMethod)method withPath:(NSString *)path withParams:(NSDictionary *)params WithSuccessBlock:(requestSuccessBlock)success WithFailurBlock:(requestFailureBlock)failure{
    switch (method) {
        case GET:{
            [self GET:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self httpSuccessHandlerWithResponseObject:responseObject successBlock:success failureBlock:failure];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"error");
            }];
            break;
        }
        case POST:{
            [self POST:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self httpSuccessHandlerWithResponseObject:responseObject successBlock:success failureBlock:failure];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"error");
            }];
            break;
        }
        default:
            break;
    }
    

}

#pragma mark - 处理解析
- (void)httpSuccessHandlerWithResponseObject:(id)responseObject successBlock:(requestSuccessBlock)successBlock failureBlock:(requestSuccessBlock)failureBlock{
    NSLog(@"success: \n%@", responseObject);
    NetWorkManagerModel *model = [NetWorkManagerModel yy_modelWithJSON:responseObject];
    if (model.code == 0) {
        successBlock(model.data);
    }else{
        
    }
    
}

@end
