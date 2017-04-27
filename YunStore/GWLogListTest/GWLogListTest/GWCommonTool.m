//
//  GWCommonTool.m
//  GWLogListTest
//
//  Created by yangye on 16/10/31.
//  Copyright © 2016年 gowild. All rights reserved.
//

#import "GWCommonTool.h"
#import "GWLogListManager.h"

@implementation GWCommonTool

void GWLog(NSString *format,...)
{
#ifdef DEBUG
    va_list arglist;
    va_start(arglist, format);
    NSString *outStr = [[NSString alloc] initWithFormat:format arguments:arglist];
    va_end(arglist);
    NSLog(@"%@",outStr);
    
    NSString *sourceString = [[NSThread callStackSymbols] objectAtIndex:1];
    
    NSCharacterSet *separatorSet = [NSCharacterSet characterSetWithCharactersInString:@" -[]+?.,"];
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:[sourceString  componentsSeparatedByCharactersInSet:separatorSet]];
    
    if ([array containsObject:@""])
    {
        [array removeObject:@""];
    }
    
    NSString *fileMsg = @"";
    if (array.count >= 4)
    {
        fileMsg = [NSString stringWithFormat:@"类:%@方法:%@",[array objectAtIndex:3],[array objectAtIndex:4]];
    }
    
    [[GWLogListManager shareInstance] cacheLog:outStr fileMsg:fileMsg logType:LogType_NetWorkLog complementBlock:NULL];
    
    [[GWLogListManager shareInstance] updateLogList];
#endif
}

@end
