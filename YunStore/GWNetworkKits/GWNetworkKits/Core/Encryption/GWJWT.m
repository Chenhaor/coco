//
//  GWJWT.m
//  SmallGowildClient
//
//  Created by yangye on 16/6/22.
//  Copyright © 2016年 Shenzhen Gowild Robotics Co.,Ltd. All rights reserved.
//

#import "GWJWT.h"

@implementation GWJWT

+ (int)getDigestLengthWithAlgorithmType:(CCHmacAlgorithm)algorithm
{
    int result;
    
    switch(algorithm) {
        case kCCHmacAlgSHA256:
            result = CC_SHA256_DIGEST_LENGTH;
            break;
        case kCCHmacAlgSHA384:
            result = CC_SHA384_DIGEST_LENGTH;
            break;
        case kCCHmacAlgSHA512:
            result = CC_SHA512_DIGEST_LENGTH;
            break;
        default:
            break;
    }
    
    return result;
}

+ (NSString *)algorithmName:(CCHmacAlgorithm)algorithm
{
    NSString *result = nil;
    
    switch(algorithm) {
        case kCCHmacAlgSHA256:
            result = @"HS256";
            break;
        case kCCHmacAlgSHA384:
            result = @"HS284";
            break;
        case kCCHmacAlgSHA512:
            result = @"HS512";
            break;
        default:
            break;
    }
    
    return result;
}

+ (CCHmacAlgorithm)getAlgorithmWithName:(NSString *)algorithmName
{
    CCHmacAlgorithm algorithm;
    
    if([algorithmName isEqualToString:@"HS256"]) {
        algorithm = kCCHmacAlgSHA256;
    } else if([algorithmName isEqualToString:@"HS384"]) {
        algorithm = kCCHmacAlgSHA384;
    } else if([algorithmName isEqualToString:@"HS512"]) {
        algorithm = kCCHmacAlgSHA512;
    } else {
        @throw [NSException exceptionWithName:@"Bad AlgorithmType" reason:@"Algorithm not supported" userInfo:nil];
    }
    return algorithm;
}

+ (NSString *)base64EncodeWithBytes:(NSData *) bytes
{
    NSString * base64str = [bytes base64EncodedStringWithOptions:0];
    
    return [[[base64str stringByReplacingOccurrencesOfString:@"+" withString:@"-"]
             stringByReplacingOccurrencesOfString:@"/" withString:@"_"]
            stringByReplacingOccurrencesOfString:@"=" withString:@""];
}

+ (NSData *)base64DecodeWithString:(NSString *) string
{
    string = [[string stringByReplacingOccurrencesOfString:@"-" withString:@"+"]
              stringByReplacingOccurrencesOfString:@"_" withString:@"/"];
    
    int size = [string length] % 4;
    NSMutableString *segment = [[NSMutableString alloc] initWithString:string];
    for (int i = 0; i < size; i++) {
        [segment appendString:@"="];
    }
    
    return [[NSData alloc] initWithBase64EncodedString:segment options:0];
}

+(NSString *) signWithInput:(NSString *)input
                  andSecret:(NSString *)secret
               andAlgorithm:(CCHmacAlgorithm)algorithm
{
    const char *cSecret = [secret cStringUsingEncoding:NSASCIIStringEncoding];
    const char *cInput = [input cStringUsingEncoding:NSASCIIStringEncoding];
    NSData *bytes;
    
    unsigned char cHMAC[[GWJWT getDigestLengthWithAlgorithmType:algorithm]];
    
    CCHmac(algorithm, cSecret, strlen(cSecret), cInput, strlen(cInput), cHMAC);
    bytes = [[NSData alloc] initWithBytes:cHMAC length:sizeof(cHMAC)];
    
    return [GWJWT base64EncodeWithBytes:bytes];
}

+ (NSString *)encodeWithPayload:(NSDictionary *)payload
                      andSecret:(NSString *)secret
                   andAlgorithm:(CCHmacAlgorithm)algorithm
                       andError:(NSError **) error
{
    if(secret == nil || [secret length] == 0)
    {
        return nil;
    }
    
    NSDictionary *header = @{
                             @"typ": @"JWT",
                             @"alg": [GWJWT algorithmName:algorithm]
                             };
    
    NSData *jsonHeader = [NSJSONSerialization dataWithJSONObject:header
                                                         options:0
                                                           error:error];
    if(jsonHeader == nil)
    {
        return nil;
    }
    
    NSData *jsonPayload = [NSJSONSerialization dataWithJSONObject:payload
                                                          options:0
                                                            error:error];
    if(jsonPayload == nil)
    {
        return nil;
    }
    
    NSMutableArray *segments = [[NSMutableArray alloc] initWithCapacity:3];
    [segments addObject:[GWJWT base64EncodeWithBytes:jsonHeader]];
    [segments addObject:[GWJWT base64EncodeWithBytes:jsonPayload]];
    
    NSString *sign = [GWJWT signWithInput:[segments componentsJoinedByString:@"."]
                                andSecret:secret
                             andAlgorithm:algorithm];
    [segments addObject:sign];
    
    return [segments componentsJoinedByString:@"."];
}

// Decode a JSON Web Token
+ (NSDictionary *)decodeWithToken:(NSString *)token
                        andSecret:(NSString *)secret
                        andVerify:(BOOL)verify
                         andError:(NSError **)error
{
    NSArray *segments = [token componentsSeparatedByString:@"."];
    if([segments count] != 3)
    {
        return nil;
    }
    // Check key
    if(secret == nil || [secret length] == 0)
    {
        return nil;
    }
    
    // All segments should be base64
    NSString *headerSeg = segments[0];
    NSString *payloadSeg = segments[1];
    NSString *signatureSeg = segments[2];
    
    // Decode and parse header and payload JSON
    NSDictionary *header = [NSJSONSerialization JSONObjectWithData:[GWJWT  base64DecodeWithString:headerSeg]
                                                           options:NSJSONReadingMutableLeaves error:error];
    if(header == nil)
    {
        return nil;
    }
    
    NSDictionary *payload = [NSJSONSerialization JSONObjectWithData:[GWJWT base64DecodeWithString:payloadSeg]
                                                            options:NSJSONReadingMutableLeaves error:error];
    if(payload == nil)
    {
        return nil;
    }
    
    if(verify)
    {
        CCHmacAlgorithm algorithm = [GWJWT getAlgorithmWithName:header[@"alg"]];
        
        // Verify signature. `sign` will return base64 string
        NSString *signinInput = [[NSArray arrayWithObjects: headerSeg, payloadSeg, nil] componentsJoinedByString:@"."];
        
        NSString *sign = [GWJWT signWithInput:signinInput
                                    andSecret:secret
                                 andAlgorithm:algorithm];
        
        if (![sign isEqualToString:signatureSeg])
        {
            return nil;
        }
    }
    
    return payload;
}

@end
