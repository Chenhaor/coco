//
//  GWHttpSessionManager.h
//  smallWhite
//
//  Created by yangye on 16/5/17.
//  Copyright © 2016年 Shenzhen Gowild Robotics Co.,Ltd. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "GWConnectDelegate.h"
#import "GWHttpRequestParamModel.h"

@interface GWHttpSessionManager : AFHTTPSessionManager<GWConnectDelegate>


- (void)cancelAll;
- (void)cleanCache;

@end
