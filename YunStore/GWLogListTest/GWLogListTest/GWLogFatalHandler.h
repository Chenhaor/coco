//
//  GWLogListManager.h
//  Holoera
//
//  Created by yangye on 16/10/29.
//  Copyright © 2016年 gowild. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^LogFatalHandlerBlock)(NSException *exception);

@interface GWLogFatalHandler : NSObject

@property (nonatomic,copy)LogFatalHandlerBlock saveCrashDataBlock;

+ (GWLogFatalHandler *)shareInstance;

- (void)installUncaughtExceptionHandler;

@end

void HandleException(NSException *exception);
void SignalHandler(int signal);

