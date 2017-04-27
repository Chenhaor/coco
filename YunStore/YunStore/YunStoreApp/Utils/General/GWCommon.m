//
//  GWCommon.m
//  SmallGowildClient
//
//  Created by gowild on 16/6/16.
//  Copyright © 2016年 Shenzhen Gowild Robotics Co.,Ltd. All rights reserved.
//

#import "GWCommon.h"

@implementation GWCommon


+ (NSDate *)calculateTime:(NSString *)sec
{
    if (sec == nil || sec.length == 0) {
        return nil;
    }
    NSDate *timeDate = [NSDate dateWithTimeIntervalSince1970:[sec integerValue]];
    
    return timeDate;
}

+ (BOOL)verifyIsPhone:(NSString *)phone
{
    //(^(13\\d|14[57]|15[^4,\\D]|17[13678]|18\\d)\\d{8}|170[^346,\\D]\\d{7})$
    NSString * MOBILE = @"^1(3|4|5|7|8)[0-9]{9}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject:phone];
}
/**
 *  根据文字的大小计算宽度
 */
+ (CGSize)sizeForTitle:(NSString*)text font:(UIFont*)font
{
    CGRect screen = [UIScreen mainScreen].bounds;
    CGFloat maxWidth = screen.size.width;
    CGSize maxSize = CGSizeMake(maxWidth, CGFLOAT_MAX);
    
    CGSize textSize = CGSizeZero;
    // iOS7以后使用boundingRectWithSize，之前使用sizeWithFont
    if ([text respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        // 多行必需使用NSStringDrawingUsesLineFragmentOrigin，网上有人说不是用NSStringDrawingUsesFontLeading计算结果不对
        NSStringDrawingOptions opts = NSStringDrawingUsesLineFragmentOrigin |
        NSStringDrawingUsesFontLeading;
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        [style setLineBreakMode:NSLineBreakByCharWrapping];
        
        NSDictionary *attributes = @{ NSFontAttributeName:font, NSParagraphStyleAttributeName:style };
        
        CGRect rect = [text boundingRectWithSize:maxSize
                                         options:opts
                                      attributes:attributes
                                         context:nil];
        textSize = rect.size;
    }
    
    return textSize;
}

/**
 *  日期转换
 *  @param date   日期
 *  @param format 格式化
 */
+ (NSString *)dateToNSString:(NSDate *)date format:(NSString *)format
{
    NSDateFormatter *formatter =  [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/beijing"];
    [formatter setTimeZone:timeZone];
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}

/**
 *  字符串转为日期
 */
+ (NSDate *)stringToDate:(NSString *)str format:(NSString *)format
{
    NSDateFormatter *formatter =  [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/beijing"];
    [formatter setTimeZone:timeZone];
    
    NSDate *date = [formatter dateFromString:str];
    
    return date;
}

///正则检测是否符合要求
+ (BOOL)checkPredicate:(NSString *)predicateStr regularExp:(NSString *)expression
{
    //    NSString * = @"[a-zA-Z0-9]{6,16}$";
    NSPredicate *regexp = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", expression];
    return [regexp evaluateWithObject:predicateStr];
}


@end
