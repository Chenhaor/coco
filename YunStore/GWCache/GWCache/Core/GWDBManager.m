//
//  GWDBManager.m
//  GWCache
//
//  Created by yangye on 2016/12/6.
//  Copyright © 2016年 Shenzhen Gowild Robotics Co.,Ltd. All rights reserved.
//

#import "GWDBManager.h"
#import "FMDB.h"

@interface GWDBManager ()

@property (nonatomic, strong) FMDatabaseQueue *queue;

@end

@implementation GWDBManager

#pragma mark pulice methods

- (id)initDBWithName:(NSString *)dbName
{
    self = [super init];
    
    if (self)
    {
        NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"dbName"];
        
        _queue = [FMDatabaseQueue databaseQueueWithPath:path];
    }
    
    return self;
}

- (void)createTableWithSql:(NSString *)sql
{
    [_queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:sql];
    }];
}

@end
