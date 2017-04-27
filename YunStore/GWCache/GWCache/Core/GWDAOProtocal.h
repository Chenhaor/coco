//
//  GWDAOProtocal.h
//  GWCache
//
//  Created by yangye on 2016/12/6.
//  Copyright © 2016年 Shenzhen Gowild Robotics Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GWDAOProtocol <NSObject>

@optional
- (void)insertObj:(NSObject *)obj;
- (NSArray *)queryDataWithConditionSQL:(NSString *)sql;

@end
