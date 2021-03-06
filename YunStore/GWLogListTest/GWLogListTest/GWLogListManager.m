//
//  GWLogListManager.m
//  Holoera
//
//  Created by yangye on 16/10/29.
//  Copyright © 2016年 gowild. All rights reserved.
//

#import "GWLogListManager.h"
#import "GWLogCacheTool.h"
#import "GWLogListViewController.h"

@interface GWLogListManager()
{
    dispatch_queue_t _isolationQueue;
}

@property (nonatomic,strong)GWLogFatalHandler *logFatalHandler;

@property(nonatomic,copy) NSString* logPath;

@property (nonatomic,assign)BOOL isShow;

@property (nonatomic,strong)GWLogListViewController *logListVc;

@property (nonatomic,strong)NSMutableArray<GWLogModel *> *logBufferArrM;////缓存60条log数据

@end

@implementation GWLogListManager

- (NSMutableArray<GWLogModel *> *)logBufferArrM
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _logBufferArrM = [NSMutableArray<GWLogModel *> array];
    });
    return _logBufferArrM;
}

- (GWLogListViewController *)logListVc
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _logListVc = [[GWLogListViewController alloc] init];
    });
    return _logListVc;
}

+ (instancetype)shareInstance
{
    static GWLogListManager *_sharedManager = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[GWLogListManager alloc] init];
    });
    return _sharedManager;
}

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        
        self.logFatalHandler = [GWLogFatalHandler shareInstance];
        
        [self.logFatalHandler installUncaughtExceptionHandler];// 开启异常监控
        
        _isolationQueue = dispatch_queue_create("com.gowild.logIO", DISPATCH_QUEUE_SERIAL);
    }
    
    return self;
}

- (void)updateLogList
{
    if (_isShow)
    {
        [self.logListVc getLogMessage];
    }
}

- (void)cacheLog:(NSString *)msg fileMsg:(NSString *)fileMsg logType:(LogType)logType complementBlock:(void (^)(void))complementBlock// logType 0 表示异常
{
    GWLogModel *logModel = [[GWLogModel alloc] init];
    
    logModel.logCreatTime = [[NSDate date] timeIntervalSince1970];
    
    logModel.logType = logType;
    
    logModel.logMsg = msg;
    
    if (fileMsg.length > 0) {
        logModel.fileMsg = fileMsg;
    }
    
    dispatch_async(_isolationQueue, ^{
        //数据库同步操作
        [GWLogCacheTool addLogMsg:logModel];
        
        if (self.logBufferArrM.count >= 60)//缓存60条log数据
        {
            [self.logBufferArrM removeLastObject];
        }
        
        [self.logBufferArrM insertObject:logModel atIndex:0];

        if (complementBlock) {
            complementBlock(); //完成之后通知
        }
    });
}

- (void)cacheLog:(NSString *)msg logType:(LogType)logType complementBlock:(void (^)(void))complementBlock // logType 0 表示异常
{
    [self cacheLog:msg fileMsg:nil logType:logType complementBlock:complementBlock];
}

- (void)asyncQueryLogsFinishBlock:(void (^)(NSArray<GWLogModel *> *))finishBlock
{
    dispatch_async(_isolationQueue, ^{
        
        if (self.logBufferArrM.count >= 60)
        {
            finishBlock([self.logBufferArrM copy]);
        }
        else
        {
            finishBlock([self queryLogs]);
        }
    });
}

- (NSArray<GWLogModel *> *)queryLogs
{
    GWQueryLogModel *req = [[GWQueryLogModel alloc] init];
    
    NSInteger currentTime = [[NSDate date] timeIntervalSince1970];
    
    req.start_time = currentTime - 20 * 60; //从20分钟前开始查找日志
    
    NSArray<GWLogModel *> *logArr = [GWLogCacheTool queryLogsWithParam:req];
    
    return logArr;
}

- (void)popOrDismissConfigWithViewController:(UIViewController *)vc
{
    _isShow = !_isShow;
    
    if (_isShow)
    {
        [self.logListVc getLogMessage];
        
        if (vc.navigationController)
        {
            [vc.navigationController pushViewController:self.logListVc
                                               animated:YES];
        }
        else
        {
            [vc presentViewController:self.logListVc animated:YES completion:NULL];
        }
    }
    else
    {
        if (vc.navigationController)
        {
            [vc.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            [self.logListVc dismissViewControllerAnimated:YES completion:NULL];
        }
    }
}

@end
