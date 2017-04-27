//
//  SingleAddress.m
//  YunStoreApp
//
//  Created by apple on 2017/4/27.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import "SingleAddress.h"

@implementation SingleAddress

+ (SingleAddress *)shareAddress{
    static SingleAddress *singleAddress  = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleAddress = [[SingleAddress alloc] init];
    });
    return singleAddress;
}

- (instancetype)init {
    if (self = [super init]) {
        _addressArray = [NSMutableArray array];
    }
    return self;
}
@end
