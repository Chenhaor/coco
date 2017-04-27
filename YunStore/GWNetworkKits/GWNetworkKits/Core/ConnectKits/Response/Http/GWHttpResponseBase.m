//
//  GWHttpResponseBase.m
//  SmallGowildClient
//
//  Created by yangye on 16/5/27.
//  Copyright © 2016年 Teehom. All rights reserved.
//

#import "GWHttpResponseBase.h"

@implementation GWHttpResponseBase

//@synthesize result = _result;
@synthesize error = _error;
@synthesize code = _code;
@synthesize data = _data;

- (id)initWithData:(id)responseData err:(NSError *)err
{
    self = [super init];
    
    if (self)
    {
        if (err)
        {
            _isSucc = NO;
            _error = err;
        }
        else
        {
            if ([responseData isKindOfClass:[NSDictionary class]])
            {
                NSNumber *code = [responseData objectForKey:@"code"];
                if (code)
                {
                    _isSucc = (code.integerValue == 100);
                    _code = code.integerValue;
                    
                    id data = [responseData objectForKey:@"data"];
                    
                    if (data != [NSNull null])
                    {
                        _data = data;
                    }
                    
                    if (!_isSucc)
                    {
                        NSString *errorMsg = [responseData objectForKey:@"desc"];
                        if (!errorMsg)
                        {
                            errorMsg = @"返回数据处理异常";
                        }
                        
                        _error = [NSError errorWithDomain:errorMsg
                                                     code:code.integerValue
                                                 userInfo:nil];
                    }
                    else
                    {
                        if (_data && [_data isKindOfClass:[NSDictionary class]])
                        {
                            _alertMsg = [_data objectForKey:@"msg"];
                        }
                    }
                }
                else
                {
                    NSString *errMsg = [responseData objectForKey:@"error"];
                    if (errMsg)
                    {
                        _isSucc = NO;
                        _error = [NSError errorWithDomain:errMsg
                                                     code:code.integerValue
                                                 userInfo:nil];
                    }
                    else
                    {
                        _isSucc = YES;
                        _data = responseData;
                    }
                }
            }
            else
            {
                _isSucc = NO;
                _error = [NSError errorWithDomain:@"服务器返回数据结构异常"
                                             code:10000
                                         userInfo:nil];
            }
        }
    }
    
    return self;
}

@end
