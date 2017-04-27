//
//  GWSocketDataEncrypt.m
//  SmallGowildClient
//
//  Created by yangye on 16/6/22.
//  Copyright © 2016年 Shenzhen Gowild Robotics Co.,Ltd. All rights reserved.
//

#import "GWSocketDataEncrypt.h"

@implementation GWSocketDataEncrypt


+ (NSData *)encodeData:(NSData *)orgData
            encryptKey:(int *)encryptKey
             keyLength:(int)keyLength
                 speed:(NSInteger)speed
{
    int length = (int)orgData.length;
    if (!length)
    {
        return orgData;
    }
    
    Byte *byteData = (Byte*)malloc(length);
    memcpy(byteData, [orgData bytes], length);
    
    Byte lastCipherByte = 0;
    
    // 加密首字节
    lastCipherByte = (Byte) ((byteData[0] ^ encryptKey[0]) & 0xff);
    byteData[0] = (Byte) lastCipherByte;
    
    //加密第二个字节
    encryptKey[1] = (((encryptKey[1] ^ lastCipherByte)) & 0xff);
    lastCipherByte = (((byteData[1] ^ encryptKey[1]) & 0xff) + lastCipherByte) & 0xff;
    byteData[1] = (Byte) lastCipherByte;
    
    // 循环加密,包长度不加密
    int keyCount = keyLength;
    
    for (int i = 4, j = 0; i < length; i+=speed, j++)
    {
        if (j == keyCount)
        {
            j = 0;
        }
        encryptKey[j] = (((encryptKey[j] + lastCipherByte) ^ i) & 0xff);
        lastCipherByte = (((byteData[i] ^ encryptKey[j]) & 0xff) + lastCipherByte) & 0xff;
        byteData[i] = (Byte) lastCipherByte;
    }
    
    NSData *encodeData = [NSData dataWithBytes:byteData
                                        length:length];
    
    if (byteData)
    {
        free(byteData);
    }
    
    return encodeData;
}

+ (NSData *)decodeData:(NSData *)orgData
            decryptKey:(int *)decryptKey
             keyLength:(int)keyLength
                 speed:(NSInteger)speed
{
    if (!orgData.length)
    {
        return orgData;
    }
    
    int length = (int)orgData.length;
    Byte lastCipherByte = 0;
    
    Byte *byteData = (Byte*)malloc(length);
    memcpy(byteData, [orgData bytes], length);
    
    int plainText = 0;
    int key = 0;
    
    // 解密首字节
    lastCipherByte = byteData[0] & 0xff;
    byteData[0] ^= decryptKey[0];
    
    //解密第二个字节
    key = ((decryptKey[1] ^ lastCipherByte));
    plainText = (((byteData[1] & 0xff) - lastCipherByte) ^ key) & 0xff;
    // 更新变量值
    lastCipherByte = byteData[1] & 0xff;
    byteData[1] = (Byte) plainText;
    decryptKey[1] = (key & 0xff);
    
    int keyCount = keyLength;
    for (int i = 4, j = 0; i < length; i += speed, j++)
    {
        if (j == keyCount)
        {
            j = 0;
        }
        // 解密当前字节
        key = ((decryptKey[j] + lastCipherByte) ^ i);
        plainText = (((byteData[i] & 0xff) - lastCipherByte) ^ key) & 0xff;
        // 更新变量值
        lastCipherByte = byteData[i] & 0xff;
        byteData[i] = (Byte) plainText;
        decryptKey[j] = (key & 0xff);
    }
    
    NSData *decodeData = [NSData dataWithBytes:byteData
                                        length:length];
    
    if (byteData)
    {
        free(byteData);
    }
    
    return decodeData;
}

@end
