//
//  GWLogModel.m
//  Holoera
//
//  Created by yangye on 16/10/31.
//  Copyright © 2016年 gowild. All rights reserved.
//

#import "GWLogModel.h"
#import <objc/runtime.h>

@implementation GWLogModel

- (instancetype)init
{
    if (self = [super init])
    {
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        self.softVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    }
    return self;
}

/*
- (NSArray *)getFieldList
{
    NSMutableArray* propertyArray = [[NSMutableArray alloc] init];
    
    Class subclass = [self class];
    
    u_int count = 0;
    
    objc_property_t* properties = class_copyPropertyList(subclass, &count);
    
    for (int i = 0; i < count ; i++)
    {
        objc_property_t prop=properties[i];
        const char* propertyName = property_getName(prop);
        NSString *property = [NSString  stringWithCString:propertyName
                                                 encoding:NSUTF8StringEncoding];
        
        if (property)
        {
            [propertyArray addObject:property];
        }
    }
    free(properties);
    
    NSDictionary* returnDic = [NSDictionary dictionaryWithObjects:valueArray forKeys:propertyArray];
    
    return [propertyArray copy];
}
*/

@end
