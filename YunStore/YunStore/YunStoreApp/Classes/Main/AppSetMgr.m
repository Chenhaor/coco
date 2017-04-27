//
//  AppSet.m
//
//  Created by yangye on 14-9-22.
//  Copyright (c) 2014年. All rights reserved.
//

#import "AppSetMgr.h"

@interface AppSetMgr()


@property (nonatomic,assign)BOOL isShowPic;  //图片开关，还没实现
@property (nonatomic,assign)BOOL wifi_ON;    //wifi开关

@end

@implementation AppSetMgr

static NSString *defaultsName = @"Default";

+ (instancetype)shareInstance
{
    static AppSetMgr *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[AppSetMgr alloc] init];
    });
    return _sharedManager;
}



@end
