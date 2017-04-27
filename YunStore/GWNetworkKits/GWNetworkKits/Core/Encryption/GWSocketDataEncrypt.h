//
//  GWSocketDataEncrypt.h
//  SmallGowildClient
//
//  Created by yangye on 16/6/22.
//  Copyright © 2016年 Shenzhen Gowild Robotics Co.,Ltd. All rights reserved.
//

/*
 *socket数据加密
 */

#import <Foundation/Foundation.h>

@interface GWSocketDataEncrypt : NSObject

+ (NSData *)encodeData:(NSData *)orgData
            encryptKey:(int *)encryptKey
             keyLength:(int)keyLength
                 speed:(NSInteger)speed;
+ (NSData *)decodeData:(NSData *)orgData
            decryptKey:(int *)decryptKey
             keyLength:(int)keyLength
                 speed:(NSInteger)speed;


@end
