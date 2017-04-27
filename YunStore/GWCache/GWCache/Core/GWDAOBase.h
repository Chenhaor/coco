//
//  GWDAOBase.h
//  GWCache
//
//  Created by yangye on 2016/12/6.
//  Copyright © 2016年 Shenzhen Gowild Robotics Co.,Ltd. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "GWDAOProtocal.h"

@class FMDatabaseQueue;

/**
 Data access object base class
 */
@interface GWDAOBase : NSObject <GWDAOProtocol>

@property (nonatomic, strong, readonly) FMDatabaseQueue *sharedQueue;
@property (nonatomic, weak, readonly) Class entityClass;

@property (nonatomic, assign) NSInteger tableVersion;
@property (nonatomic, copy) NSString *tableName;

- (id)initWithDBQueue:(FMDatabaseQueue *)dbQueue;
- (void)updateDataWithSQL:(NSString *)sql;
- (NSArray *)queryDataWithSQL:(NSString *)sql;

@end
