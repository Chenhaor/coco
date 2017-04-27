//
//  GWPageViewController.h
//  GowildXB
//
//  Created by Charse on 16/7/23.
//  Copyright © 2016年 Shenzhen Gowild Robotics Co.,Ltd. All rights reserved.
//

#import "GWBaseViewController.h"
#import "GWPageContentViewControllerDelegate.h"

@protocol GWPageViewControllerDelegate <NSObject>

@optional

- (void)contentControllerAtIndexDidLoad:(NSInteger)idx;
- (void)contentControllerAtIndexWillAppear:(NSInteger)idx;
- (void)contentControllerAtIndexWillDisappear:(NSInteger)idx;

@end

@interface GWPageViewController : GWBaseViewController

@property (nonatomic, weak) id<GWPageViewControllerDelegate> delegate;
@property (nonatomic, assign) CGRect pageContentFrame;
@property (nonatomic, strong) NSArray<GWPageContentViewControllerDelegate> *contentControllers;
@property (nonatomic, assign) NSInteger currentIdx;

- (void)didShowControllerAtIndex:(NSInteger)idx;

@end
