//
//  GWDBManager.h
//  GWCache
//
//  Created by yangye on 2016/12/6.
//  Copyright © 2016年 Shenzhen Gowild Robotics Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FMDatabaseQueue;

@interface GWDBManager : NSObject

@property (nonatomic, strong, readonly) FMDatabaseQueue *queue;

- (id)initDBWithName:(NSString *)dbName;
- (void)createTableWithSql:(NSString *)sql;


@end
