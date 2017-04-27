//
//  GWConnectDelegate.h
//  SmallGowildClient
//
//  Created by yangye on 16/5/27.
//  Copyright © 2016年 Teehom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GWResponseDelegate.h"


typedef void(^GWResponseCallback)(id result, NSError *error);

@protocol GWRequestDelegate <NSObject>

@property (nonatomic, assign) NSUInteger flag;
@property (nonatomic, assign) NSTimeInterval timeOut;
@property (nonatomic, copy) GWResponseCallback callback;

@required
/**
 *  request param info
 *
 *  @return request param
 */
- (NSDictionary *)reqParamDic;
- (void)requestFinishedCallback:(id)result;
- (void)requestErrorCallback:(NSError *)error;
- (id<GWResponseDelegate>)getResponseWithInfo:(id)result
                                          err:(NSError *)err;
@optional

@end
