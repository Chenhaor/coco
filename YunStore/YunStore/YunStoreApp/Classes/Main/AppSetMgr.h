//
//  AppSet.h
//
//  Created by yangye on 14-9-22.
//  Copyright (c) 2014年. All rights reserved.
//


@interface AppSetMgr : NSObject

@property (nonatomic,strong,readonly)NSString *devToken; //设备token，还没实现

@property (nonatomic,assign,readonly)BOOL isShowPic;  //图片开关，还没实现
@property (nonatomic,assign,readonly)BOOL wifi_ON;    //wifi开关

+ (instancetype)shareInstance;

@end
