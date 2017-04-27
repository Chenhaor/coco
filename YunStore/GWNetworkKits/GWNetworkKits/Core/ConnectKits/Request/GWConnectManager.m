//
//  GWConnectManager.m
//  SmallGowildClient
//
//  Created by yangye on 16/5/26.
//  Copyright © 2016年 2016年 Shenzhen Gowild Robotics Co.,Ltd. All rights reserved.
//

#import "GWConnectManager.h"
#import "GWHttpSessionManager.h"
#import "GWHttpRequestParamModel.h"

static GWConnectManager *_shareInstance = nil;

@interface GWConnectManager ()


@property (nonatomic, strong) GWHttpSessionManager *httpManager;
@property (nonatomic, assign, readonly) NSUInteger reqFlag;

@end

@implementation GWConnectManager

@synthesize reqFlag = _reqFlag;

+ (instancetype)sharedConnectManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareInstance = [[GWConnectManager alloc] init];
        [_shareInstance reset];
    });
    return _shareInstance;
}

#pragma mark private methods
- (void)reset
{
    _reqFlag = 1000;
}

#pragma mark setter/getter

- (GWHttpSessionManager *)httpManager
{
    if (!_httpManager)
    {
        _httpManager = [[GWHttpSessionManager alloc] init];
    }
    
    return _httpManager;
}

- (NSUInteger)reqFlag
{
    return _reqFlag++;
}

#pragma mark - GWConnectDelegate
- (NSError *)sendWithRequestParam:(id<GWRequestDelegate>)param
{
    NSError *err = nil;
    //主动调用的请求都应该有唯一flag，用来处理callback以及cancel
    param.flag = self.reqFlag;
    
    if ([param isKindOfClass:[GWHttpRequestParamModel class]])
    {
        GWHttpRequestParamModel *httpReq = (GWHttpRequestParamModel *)param;
        err = [self.httpManager sendWithRequestParam:httpReq];
    }

    return err;
}

- (void)cancelWithRequestParam:(id<GWRequestDelegate>)param
{
    if ([param isKindOfClass:[GWHttpRequestParamModel class]])
    {
        GWHttpRequestParamModel *httpReq = (GWHttpRequestParamModel *)param;
        [self.httpManager cancelWithRequestParam:httpReq];
    }
}

@end
