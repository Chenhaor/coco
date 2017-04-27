//
//  GWHttpJWTResponseBase.h
//  SmallGowildClient
//
//  Created by yangye on 16/6/22.
//  Copyright © 2016年 Shenzhen Gowild Robotics Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GWResponseDelegate.h"

@interface GWHttpJWTResponseBase : NSObject<GWResponseDelegate>

@property (nonatomic, strong, readonly) NSDictionary *decodeData;   //结果
@property (nonatomic, strong, readonly) NSError *error;

@end
