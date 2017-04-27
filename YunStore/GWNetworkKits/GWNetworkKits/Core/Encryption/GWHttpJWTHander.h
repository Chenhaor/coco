//
//  GWHttpJWTHander.h
//  SmallGowildClient
//
//  Created by yangye on 16/6/22.
//  Copyright © 2016年 Shenzhen Gowild Robotics Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GWHttpJWTHander : NSObject

+ (NSString *)encodeWithDictionary:(NSDictionary *)dic
                               key:(NSString *)key
                             error:(NSError **)error;
+ (NSDictionary *)decodeWithString:(NSString *)str
                               key:(NSString *)key
                             error:(NSError **)error;

@end
