//
//  GWCommon.h
//  SmallGowildClient
//
//  Created by gowild on 16/6/16.
//  Copyright © 2016年 Shenzhen Gowild Robotics Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GWCommon : NSObject


+ (NSDate *)calculateTime:(NSString *)sec;

+ (BOOL)verifyIsPhone:(NSString *)phone;

+ (CGSize)sizeForTitle:(NSString*)text font:(UIFont*)font;

+ (NSString *)dateToNSString:(NSDate *)date format:(NSString *)format;

+ (NSDate *)stringToDate:(NSString *)str format:(NSString *)format;


///正则检测是否符合要求
+ (BOOL)checkPredicate:(NSString *)predicateStr regularExp:(NSString *)expression;

@end
