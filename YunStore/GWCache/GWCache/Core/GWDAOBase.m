//
//  GWDAOBase.m
//  GWCache
//
//  Created by yangye on 2016/12/6.
//  Copyright © 2016年 Shenzhen Gowild Robotics Co.,Ltd. All rights reserved.
//

#import "GWDAOBase.h"
#import "FMDB.h"

@interface GWDAOBase ()

@property (nonatomic, strong) FMDatabaseQueue *sharedQueue;

@end

@implementation GWDAOBase

- (id)initWithDBQueue:(FMDatabaseQueue *)dbQueue;
{
    self = [super init];
    if (self)
    {
        self.sharedQueue = dbQueue;
    }
    
    return self;
}

- (void)updateDataWithSQL:(NSString *)sql
{
    [self.sharedQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        [db executeUpdate:sql];
    }];
}

- (NSDictionary *)queryDataWithSQL:(NSString *)sql
{
    __block NSDictionary *dic = nil;
    [self.sharedQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        FMResultSet *rs = [db executeQuery:sql];
        dic = [rs.columnNameToIndexMap copy];
    }];
    
    return dic;
}

@end
