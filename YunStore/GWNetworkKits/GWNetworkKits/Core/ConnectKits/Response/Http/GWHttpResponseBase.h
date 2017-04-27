//
//  GWHttpResponseBase.h
//  SmallGowildClient
//
//  Created by yangye on 16/5/27.
//  Copyright © 2016年 Teehom. All rights reserved.
//

#import "GWResponseDelegate.h"

@interface GWHttpResponseBase : NSObject<GWResponseDelegate>

@property (nonatomic, assign, readonly) BOOL isSucc;   //结果
@property (nonatomic, assign, readonly) NSInteger code;   //结果
@property (nonatomic, copy, readonly) NSString *alertMsg;   //提示信息
@property (nonatomic, assign, readonly) id data;   //数据
@property (nonatomic, strong, readonly) NSError *error;  //业务错误

@end
