//
//  GWConnectDelegate.h
//  SmallGowildClient
//
//  Created by yangye on 16/5/27.
//  Copyright © 2016年 Teehom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GWRequestDelegate.h"

@protocol GWConnectDelegate <NSObject>


/**
 *  发送请求
 *
 *  @param param 请求的参数的对象
 */
- (NSError *)sendWithRequestParam:(id<GWRequestDelegate>)param;


@optional
/**
 *	@brief  取消掉某一个请求
 *
 *	@param 	param 请求的对象
 */
- (void)cancelWithRequestParam:(id<GWRequestDelegate>)param;

/**
 *  发送请求
 *
 *  @param body 请求的参数的数据
 */
- (NSError *)sendWithRequestBody:(NSData *)body;

- (void)didRecvData:(id)response
                 cmdCode:(NSUInteger)cmdCode
                     err:(NSError *)err;

@end
