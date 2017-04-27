//
//  GWHttpJWTHander.m
//  SmallGowildClient
//
//  Created by yangye on 16/6/22.
//  Copyright © 2016年 Shenzhen Gowild Robotics Co.,Ltd. All rights reserved.
//

#import "GWHttpJWTHander.h"
#import "GWJWT.h"

@implementation GWHttpJWTHander

+ (NSString *)encodeWithDictionary:(NSDictionary *)dic
                               key:(NSString *)key
                             error:(NSError **)error;
{
    if (![dic count] || !key)
    {
        return nil;
    }
    
    CCHmacAlgorithm algorithm = kCCHmacAlgSHA512;
    
    return [GWJWT encodeWithPayload:dic
                          andSecret:key
                       andAlgorithm:algorithm
                           andError:error];
}

+ (NSDictionary *)decodeWithString:(NSString *)str
                               key:(NSString *)key
                             error:(NSError **)error;
{
    if (!str || !key)
    {
        return nil;
    }
    
    return [GWJWT decodeWithToken:str
                        andSecret:key
                        andVerify:YES
                         andError:error];
}

@end
