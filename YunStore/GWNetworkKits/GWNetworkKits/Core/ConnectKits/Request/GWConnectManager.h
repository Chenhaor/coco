//
//  GWConnectManager.h
//  SmallGowildClient
//
//  Created by yangye on 16/5/26.
//  Copyright © 2016年 2016年 Shenzhen Gowild Robotics Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GWConnectDelegate.h"

@interface GWConnectManager : NSObject<GWConnectDelegate>

+ (instancetype)sharedConnectManager;

@end
