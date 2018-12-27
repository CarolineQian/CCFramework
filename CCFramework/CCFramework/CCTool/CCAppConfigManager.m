//
//  CCAppConfigManager.m
//  CCFramework
//
//  Created by 冯倩 on 2018/12/21.
//  Copyright © 2018年 Caroline. All rights reserved.
//

#import "CCAppConfigManager.h"

@implementation CCAppConfigManager

+ (instancetype)defaultManager
{
    static CCAppConfigManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once( &onceToken,^{
        
        NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"111"];
        if (dict) {
            manager = [CCAppConfigManager mj_objectWithKeyValues:dict];
        }else{
            manager = [[self alloc] init];
        }
    });
    
    return manager;
}

@end
