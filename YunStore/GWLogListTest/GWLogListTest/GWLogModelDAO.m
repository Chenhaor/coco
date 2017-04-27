//
//  GWLogModelDAO.m
//  GWLogListTest
//
//  Created by yangye on 2016/12/6.
//  Copyright © 2016年 gowild. All rights reserved.
//

#import "GWLogModelDAO.h"


@implementation GWLogModelDAO

- (void)insertObj:(NSObject *)obj
{
    if ([obj isKindOfClass:[GWLogModel class]])
    {
        GWLogModel *logModel = (GWLogModel *)obj;
        NSNumber *logCreatTime = [NSNumber numberWithInteger:logModel.logCreatTime];
        NSString *softVersion = logModel.softVersion;
        NSNumber *logType = [NSNumber numberWithInt:logModel.logType];
        NSString *logMsg = logModel.logMsg ? logModel.logMsg : @"";
        NSString *fileMsg = logModel.fileMsg ? logModel.fileMsg : @"";
        
        NSString *sql = [NSString stringWithFormat:@"insert into t_log (logCreatTime, softVersion, logType, logMsg, fileMsg) values(?, ?, ? , ?, ?)",logCreatTime,softVersion, logType, logMsg, fileMsg];
        
        [self updateDataWithSQL:sql];
    }
}

- (NSArray *)queryDataWithConditionSQL:(NSString *)sql
{
    NSDictionary *dic = [self queryDataWithSQL:sql];
}

- (NSArray *)getAllobj
{
    // 1.定义数组
    __block NSMutableArray<GWLogModel *> *logsArrM = nil;
    
    // 2.使用数据库
    [_queue inDatabase:^(FMDatabase *db) {
        // 创建数组
        logsArrM = [NSMutableArray<GWLogModel *> array];
        
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *softVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        
        FMResultSet *rs = nil;
        
        if (param.start_time)
        {
            NSNumber *startTime = [NSNumber numberWithInteger:param.start_time];
            rs = [db executeQuery:@"select * from t_log where softVersion = ? and logCreatTime >= ? order by logCreatTime desc", softVersion, startTime];
        }
        
        while (rs.next)
        {
            GWLogModel *logModel = [[GWLogModel alloc] init];
            logModel.logCreatTime = [rs intForColumn:@"logCreatTime"];
            logModel.softVersion = [rs stringForColumn:@"softVersion"];
            logModel.logType = [rs intForColumn:@"logType"];
            logModel.logMsg = [rs stringForColumn:@"logMsg"];
            logModel.fileMsg = [rs stringForColumn:@"fileMsg"];
            [logsArrM addObject:logModel];
        }
    }];
    
    [_queue close];
    
    // 3.返回数据
    return [logsArrM copy];
}

@end
