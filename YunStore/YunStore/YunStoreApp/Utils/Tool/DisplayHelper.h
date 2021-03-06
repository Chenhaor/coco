//
//  DisplayHelper.h
//  Ordering
//
//  Created by AaronKwok on 12-4-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"


@interface DisplayHelper : NSObject


+ (DisplayHelper *)shareDisplayHelper;

- (void)showLoading:(UIView *)aView;//默认10s
- (void)showFreeLoading:(UIView *)aView;//可交互 10s
- (void)showLoading:(UIView *)aView noteText:(NSString *)noteText;
- (void)hideLoading:(UIView *)aView;

+(void)displaySuccessAlert:(NSString*)title message:(NSString*)message;
+(void)displaySuccessAlert:(NSString*)message;
+(void)displaySuccessAlert:(NSString*)message interval:(float)interval;

//用于显示提示信息的浮动框
+(void)displayWarningAlert:(NSString*)message;
+(void)displayWarningAlert:(NSString*)title message:(NSString*)message;

+(void)displaySuccessAlert:(NSString*)title message:(NSString*)message onView:(UIView*)aView;
+(void)displaySuccessAlert:(NSString*)message onView:(UIView*)aView;


//用于显示提示信息的浮动框
+(void)displayWarningAlert:(NSString*)message onView:(UIView*)aView;
+(void)displayWarningAlert:(NSString*)title message:(NSString*)message onView:(UIView*)aView;


+(void)displaySuccessAlert:(NSString *)message onHUD:(MBProgressHUD *)HUD;
+(void)displaySuccessAlert:(NSString*)message interval:(float)interval onHUD:(MBProgressHUD *)HUD;


+(void)displayWarningAlert:(NSString*)message onHUD:(MBProgressHUD *)HUD;
+(void)displayWarningAlert:(NSString*)message interval:(float)interval onHUD:(MBProgressHUD *)HUD;


///显示加载中
+ (void)displayLoadingAlert:(NSString *)message onView:(UIView *)aView;

//网络提示(只在错误的时候才提示)
+ (void)displayFailNoteWithCode:(NSInteger)desCode andDesc:(NSString *)desc;

//delay <= 0时无超时时间
- (void)showLoading:(UIView *)aView andDelay:(NSTimeInterval)delay;

@end
