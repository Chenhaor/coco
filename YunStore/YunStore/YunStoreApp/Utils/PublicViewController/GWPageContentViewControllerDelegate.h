//
//  GWPageContentViewController.h
//  GowildXB
//
//  Created by Charse on 16/7/23.
//  Copyright © 2016年 Shenzhen Gowild Robotics Co.,Ltd. All rights reserved.
//

#import "GWBaseViewController.h"

@protocol GWPageContentViewControllerDelegate <NSObject>

@property (nonatomic, assign) CGRect pageContentFrame;

@optional
@property (nonatomic, copy) void (^viewDidLoadCallback)(void);
@property (nonatomic, copy) void (^viewWillAppearCallback)(void);
@property (nonatomic, copy) void (^viewWillDisapearCallback)(void);

@end
