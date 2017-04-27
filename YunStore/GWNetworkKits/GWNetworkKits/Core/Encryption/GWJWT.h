//
//  GWJWT.h
//  SmallGowildClient
//
//  Created by yangye on 16/6/22.
//  Copyright © 2016年 Shenzhen Gowild Robotics Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonHMAC.h>

@interface GWJWT : NSObject

+ (NSData *)base64DecodeWithString:(NSString *)string;

+ (NSString *)encodeWithPayload:(NSDictionary *)payload
                      andSecret:(NSString *)secret
                   andAlgorithm:(CCHmacAlgorithm)algorithm
                       andError:(NSError **) error;

// Decode a JSON Web Token
+(NSDictionary *) decodeWithToken:(NSString *)token
                        andSecret:(NSString *)secret
                        andVerify:(BOOL)verify
                         andError:(NSError **)error;
@end
