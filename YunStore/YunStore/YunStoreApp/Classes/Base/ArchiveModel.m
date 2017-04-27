//
//  ArchiveModel.m
//  YunFuStore
//
//  Created by apple on 2017/4/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ArchiveModel.h"
#import <objc/runtime.h>

@implementation ArchiveModel

//归档
- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    unsigned int ivarCount = 0;
    Ivar *ivars = class_copyIvarList([self class], &ivarCount);
    for (unsigned int i = 0; i < ivarCount; i++) {
        Ivar ivar = ivars[i];
        
        //获取成员变量名
        const void *name = ivar_getName(ivar);
        NSString *ivarName = [NSString stringWithUTF8String:name];
        
        //去掉前面的下划线
        ivarName = [ivarName substringFromIndex:1];
        [aCoder encodeObject:[self valueForKey:ivarName] forKey:ivarName];
    }
    free(ivars);
}

//解档
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    unsigned int ivarCount = 0;
    Ivar *ivars = class_copyIvarList([self class], &ivarCount);
    for (unsigned int i = 0; i < ivarCount; i++) {
        Ivar ivar = ivars[i];
        
        const void *name = ivar_getName(ivar);
        NSString *ivarName = [NSString stringWithUTF8String:name];
        
        ivarName = [ivarName substringFromIndex:1];
        [self setValue:[aDecoder decodeObjectForKey:ivarName] forKey:ivarName];
    }
    free(ivars);
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)Dic {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:Dic];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
