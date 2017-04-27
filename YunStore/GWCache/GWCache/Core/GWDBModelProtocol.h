//
//  GWDBModelProtocol.h
//  GWCache
//
//  Created by yangye on 2016/12/7.
//  Copyright © 2016年 Shenzhen Gowild Robotics Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GWDBModelProtocol <NSObject>

@optional
- (NSArray *)getFieldList;
- (instancetype)initWithCacheData:(NSDictionary *)dic;

@end
