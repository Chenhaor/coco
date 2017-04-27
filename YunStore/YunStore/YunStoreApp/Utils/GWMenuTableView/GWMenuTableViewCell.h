//
//  GWMenuTableViewCell.h
//  GWMenuTableViewCell
//
//  Created by yangye on 15/3/27.
//  Copyright (c) 2015年 yangye. All rights reserved.
//基类

#import <UIKit/UIKit.h>
#import "GWMenuAction.h"
#import "GWMenuActionView.h"
/**
 *  GWMenuTableViewCellState
 */
typedef NS_ENUM(NSInteger, GWMenuTableViewCellState){
    /**
     *  正常状态
     */
    GWMenuTableViewCellState_Common       = 0,
    /**
     *  展开一部分，显示更多按钮
     */
    GWMenuTableViewCellState_Division, //未实现
    /**
     *  全部展开
     */
    GWMenuTableViewCellState_Expanded
};


@interface GWMenuTableViewCell : UITableViewCell <GWMenuActionViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, assign)GWMenuTableViewCellState menuState;

@property (nonatomic, strong) UIView *customView; //创建的cell子视图添加到上面
@property (nonatomic, strong) GWMenuActionView *actionsView; //右滑出现的视图添加在上面

@property (nonatomic, strong) NSArray *actions;

@property (nonatomic, assign) CGFloat deltaX;

- (void)swipeBeganWithDeltaX:(CGFloat)deltaX;

- (void)swipeEndWithDeltaX:(CGFloat)deltaX;

- (BOOL)leftSwipIsClose;

- (void)closeLeftSwip;

@end
