//
//  NetWorkManagerModel.h
//  CCFramework
//
//  Created by 冯倩 on 2018/12/22.
//  Copyright © 2018年 Caroline. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetWorkManagerModel : NSObject
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) id data;
@property (nonatomic, assign) NSInteger code;
@end

NS_ASSUME_NONNULL_END
