//
//  SlideSwitchView.h
//
//  Created by yangye on 15/8/7.
//  Copyright (c) 2015年. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SlideSwitchViewDelegate;

@interface GWSlideSwitchView :UIView<UIScrollViewDelegate>

@property (nonatomic,assign) CGFloat heightOfTopScrollView;

@property (nonatomic,assign) CGFloat widthOfButtonMargin;

@property (nonatomic,assign) CGFloat fontSizeOfTabButton;

@property (nonatomic, strong) UIColor *tabItemNormalColor;//正常时tab文字颜色
@property (nonatomic, strong) UIColor *tabItemSelectedColor;//选中时tab文字颜色

@property (nonatomic, strong) UIImage *tabItemNormalBackgroundImage;//正常时tab的背景
@property (nonatomic, strong) UIImage *tabItemSelectedBackgroundImage;//选中时tab的背景

@property (nonatomic, strong) UIImage *shadowImg;

@property (nonatomic, assign) BOOL isTopViewScroll; //顶部是否支持滑动

@property (nonatomic, weak) id<SlideSwitchViewDelegate> slideSwitchViewDelegate;

//必须要调用的
- (void)buildUI;

- (void)configTopScrollViewBtnTitle:(NSArray *)titleArr;

@end

@protocol SlideSwitchViewDelegate <NSObject>

@required

/*
 * @method 共有多少子控制器
 */
- (NSArray<UIViewController *> *)childsVcOfSlideSwitchView;

@optional

/*
 * @method 滑动左边界时传递手势
 */
- (void)slideSwitchView:(GWSlideSwitchView *)view panLeftEdge:(UIPanGestureRecognizer*) panParam;

/*
 * @method 滑动右边界时传递手势
 */
- (void)slideSwitchView:(GWSlideSwitchView *)view panRightEdge:(UIPanGestureRecognizer*) panParam;

/*
 * @method 点击tab
 */
- (void)slideSwitchView:(GWSlideSwitchView *)view didselectTab:(NSUInteger)number;

@end
