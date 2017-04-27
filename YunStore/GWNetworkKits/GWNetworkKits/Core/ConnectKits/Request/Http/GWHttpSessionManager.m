//
//  GWHttpSessionManager.m
//  smallWhite
//
//  Created by yangye on 16/5/17.
//  Copyright © 2016年 Shenzhen Gowild Robotics Co.,Ltd. All rights reserved.
//

#import "GWHttpSessionManager.h"
#import "GWHttpResponseBase.h"
#import <GWLogListTest/GWLogListTest.h>

static NSString * const  HTTP_HOST   = @"http://www.gowild.top:8080/AndroidServer/";


@interface GWHttpSessionManager ()
{
    NSMutableDictionary *_requestDic;  //缓存请求，用来cancel
}

- (void)resetCache;

@end

@implementation GWHttpSessionManager

- (id)init
{
    self = [super init];
    
    if (self)
    {
        self.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        NSSet *set = [NSSet setWithObjects:@"text/json",
                      @"application/json",
                      @"text/plain",
                      @"text/html",
                      @"application/javascript", nil];
        
        self.responseSerializer = [[AFHTTPResponseSerializer alloc] init];//[[AFJSONResponseSerializer alloc] init];
        self.responseSerializer.acceptableContentTypes = set;
        
        //start
        [self resetCache];
    }
    
    return self;
}

- (void)resetCache
{
    _requestDic = [[NSMutableDictionary alloc] init];
}

#pragma mark setter/getter

#pragma mark private methods
- (NSString *)contentTypeForImageData:(NSData *)data {
    uint8_t c;
    [data getBytes:&c length:1];
    
    switch (c) {
        case 0xFF:
            return @"image/jpeg";
        case 0x89:
            return @"image/png";
        case 0x47:
            return @"image/gif";
        case 0x49:
        case 0x4D:
            return @"image/tiff";
    }
    return nil;
}

#pragma mark pulice methods
- (NSError *)sendWithRequestParam:(id<GWRequestDelegate>)param
{
    if ([param isKindOfClass:[GWHttpRequestParamModel class]])
    {
        GWHttpRequestParamModel *req = (GWHttpRequestParamModel *)param;
        
        switch (req.parmaFormat)
        {
            case HTTP_PARMA_FORMAT_KEYVALUE:
            {
                self.requestSerializer = [[AFHTTPRequestSerializer alloc] init];
                self.requestSerializer.timeoutInterval = 30.f;

            }
                break;
            case HTTP_PARMA_FORMAT_JSON:
            {
                self.requestSerializer = [AFJSONRequestSerializer serializer];
                self.responseSerializer = [AFJSONResponseSerializer serializer];
                self.requestSerializer.timeoutInterval = 30.f;
            }
                break;
            default:
                break;
        }
        
        if (req.authorization)
        {
            [self.requestSerializer setValue:req.authorization
                          forHTTPHeaderField:@"Authorization"];
        }
        
        NSURLSessionDataTask *task = nil;
        
        GWLog(@"请求地址为%@ \n 参数为%@",req.interfaceUrl, req.reqParamDic);
        if (req.reqType == HTTP_REQUESTPYE_POST)
        {
            task = [self POST:req.interfaceUrl
                   parameters:req.reqParamDic
                    progress:nil
                      success:^(NSURLSessionDataTask * _Nonnull task,
                                id  _Nonnull responseObject) {
                          [param requestFinishedCallback:responseObject];
                      }
                      failure:^(NSURLSessionDataTask * _Nonnull task,
                                NSError * _Nonnull error) {
                           [param requestErrorCallback:error];
                      }];
        }
        else    //get
        {
            task = [self GET:req.interfaceUrl
                  parameters:req.reqParamDic
                    progress:nil
                     success:^(NSURLSessionDataTask * _Nonnull task,
                               id  _Nonnull responseObject) {
                         [param requestFinishedCallback:responseObject];
                     } failure:^(NSURLSessionDataTask * _Nonnull task,
                                 NSError * _Nonnull error) {
                         [param requestErrorCallback:error];
                     }];
        }
        
        if (task && req.flag)
        {
            NSNumber *key = [NSNumber numberWithInteger:req.flag];
            [_requestDic setObject:task
                            forKey:key];
        }
    }
    
    return nil;
}

- (void)cancelWithRequestParam:(id<GWRequestDelegate>)param
{
    if ([param isKindOfClass:[GWHttpRequestParamModel class]])
    {
        GWHttpRequestParamModel *req = (GWHttpRequestParamModel *)param;
        if (_requestDic && req.flag)
        {
            NSNumber *key = [NSNumber numberWithInteger:req.flag];
            NSURLSessionDataTask *task = [_requestDic objectForKey:key];
            if (task)
            {
                [task cancel];
                [_requestDic removeObjectForKey:key];
                param.callback = nil;
            }
        }
    }
}

- (void)cancelAll
{
    for (id obj in [_requestDic allValues])
    {
        if ([obj isKindOfClass:[NSURLSessionDataTask class]])
        {
            NSURLSessionDataTask *task = (NSURLSessionDataTask *)obj;
            [task cancel];
        }
    }
    
    [self resetCache];
}

- (void)cleanCache
{
}

@end
