//
//  GWHttpJWTResponseBase.m
//  SmallGowildClient
//
//  Created by yangye on 16/6/22.
//  Copyright © 2016年 Shenzhen Gowild Robotics Co.,Ltd. All rights reserved.
//

#import "GWHttpJWTResponseBase.h"
#import "GWHttpJWTHander.h"

NSString *const kHttpDefaultSecretKey = @"fdiDLE_31kdio3.23nd92kzLIjhemD";

@interface GWHttpJWTResponseBase ()

@property (nonatomic, strong) NSDictionary *decodeData;
@property (nonatomic, strong) NSError *error;

@end

@implementation GWHttpJWTResponseBase

- (id)initWithData:(id)responseData err:(NSError *)err
{
    self = [super init];
    
    if (self)
    {
        if (err)
        {
            _error = err;
        }
        else
        {
            if ([responseData isKindOfClass:[NSString class]])
            {
                NSError *err = nil;
                self.decodeData = [GWHttpJWTHander decodeWithString:responseData
                                                                key:kHttpDefaultSecretKey
                                                              error:&err];
                self.error = err;
            }
            else
            {
                _error = [NSError errorWithDomain:@"服务器返回数据结构异常"
                                             code:10000
                                         userInfo:nil];
            }
        }
    }
    
    return self;
}

@end
