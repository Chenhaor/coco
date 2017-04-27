//
//  GWLogListManager.h
//  Holoera
//
//  Created by yangye on 16/10/29.
//  Copyright © 2016年 gowild. All rights reserved.
// 服务器返回的数据,普通数据，异常，错误，

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GWLogModel.h"
#import "GWLogFatalHandler.h"

@interface GWLogListManager : NSObject

@property (nonatomic,strong,readonly)GWLogFatalHandler *logFatalHandler;

+ (instancetype)shareInstance;


- (void)updateLogList;


//缓存log数据
- (void)cacheLog:(NSString *)msg logType:(LogType)logType complementBlock:(void (^)(void))complementBlock; // 0 代表异常 1 2 之后实现

- (void)cacheLog:(NSString *)msg fileMsg:(NSString *)fileMsg logType:(LogType)logType complementBlock:(void (^)(void))complementBlock;

//异步查找
- (void)asyncQueryLogsFinishBlock:(void (^)(NSArray<GWLogModel *> *))finishBlock;

- (void)popOrDismissConfigWithViewController:(UIViewController *)vc;

@end
