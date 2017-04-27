//
//  UtilsMacro.h
//  NewBaocai
//
//  Created by Teehom on 15/9/6.
//  Copyright © 2015年 Teehom. All rights reserved.
//  APP方便使用的宏定义

#ifndef UtilsMacro_h
#define UtilsMacro_h


#import "AppDelegate.h"


/***********************枚举值***************************/
typedef OBJC_ENUM(NSInteger, StatusCode)
{
    SUCCESS = 100
};

typedef NS_ENUM(NSInteger, ShopCartGoodsStyle) {
    GoodsEdit = 0,//编辑
    GoodsBuy = 1   //购买
};

///弱引用，强应用，主要用于block里面，现在block弱引用self，再在block里面强引用
#define WS(__KEY)  __weak typeof(self)__KEY = self


#define kNaviHeight    64.0f
#define kTabbarHeight    49.0f
#define kScreenWidth    [UIScreen mainScreen].bounds.size.width
#define kScreenHeight    [UIScreen mainScreen].bounds.size.height
#define kAppScale SCREEN_WIDTH/375.0f


//获取appDelegate实例。
UIKIT_STATIC_INLINE AppDelegate *appDelegate()
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

//use dlog to print while in debug model
#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif

//非空判断 宏
#define IsNilOrNull(_ref)   (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]))


#define DOBJ(obj)  DLOG(@"%s: %@", #obj, [(obj) description])

#define MARK    NSLog(@"\nMARK: %s, %d", __PRETTY_FUNCTION__, __LINE__)


#endif /* UtilsMacro_h */
