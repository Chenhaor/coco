//
//  DisplayHelper.m
//  Ordering
//
//  Created by AaronKwok on 12-4-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DisplayHelper.h"
#import "MBProgressHUD.h"

@implementation DisplayHelper

+ (DisplayHelper *)shareDisplayHelper
{
    static DisplayHelper *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[DisplayHelper alloc]init];
    });
    return shareInstance;
}

- (void)showLoading:(UIView *)aView
{
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:aView];
    [aView addSubview:HUD];
//    [HUD show:NO];
    [HUD show:YES];//解决显示超时
    [HUD hide:YES afterDelay:10];
}

- (void)showFreeLoading:(UIView *)aView//可交互
{
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:aView];
    HUD.userInteractionEnabled = NO;
    [aView addSubview:HUD];
    [HUD show:YES];//解决显示超时
    [HUD hide:YES afterDelay:10];
}

- (void)showLoading:(UIView *)aView andDelay:(NSTimeInterval)delay
{
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:aView];
    [aView addSubview:HUD];
    
    if(delay > 0){
        
        [HUD show:YES];
        [HUD hide:YES afterDelay:delay];
    }else{
        
        [HUD show:NO];
    }
    
}

- (void)showLoading:(UIView *)aView noteText:(NSString *)noteText
{
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:aView];
    HUD.labelText = noteText;
    [aView addSubview:HUD];
    [HUD show:NO];
}

- (void)hideLoading:(UIView *)aView
{
    [MBProgressHUD hideHUDForView:aView animated:NO];
}


//用于显示提示信息的浮动框
+(void)displaySuccessAlert:(NSString*)title message:(NSString*)message{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:window];
    // Add HUD to screen
    [window addSubview:HUD];
    
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MBProgressHUD_con_success.png"]];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.labelText = title;
    HUD.detailsLabelText = message;
    [HUD show:YES];
    [HUD hide:YES afterDelay:1.5];
}


+(void)displaySuccessAlert:(NSString*)message interval:(float)interval{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:window];
    // Add HUD to screen
    [window addSubview:HUD];
    
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.labelText = message;
    [HUD show:YES];
    [HUD hide:YES afterDelay:interval];
}

//用于显示提示信息的浮动框
+(void)displayWarningAlert:(NSString*)title message:(NSString*)message{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:window];
    // Add HUD to screen
    [window addSubview:HUD];
    
//    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MBProgressHUD_con_failed.png"]];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.labelText = title;
    HUD.detailsLabelText = message;
    [HUD show:YES];
    [HUD hide:YES afterDelay:1.5];
}

+(void)displaySuccessAlert:(NSString*)message{
    if (message.length == 0) {
        return;
    }
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:window];
    // Add HUD to screen
    [window addSubview:HUD];
    
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MBProgressHUD_con_success.png"]];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.labelText = message;
    [HUD show:YES];
    [HUD hide:YES afterDelay:1.5];
}
//用于显示提示信息的浮动框
+(void)displayWarningAlert:(NSString*)message{
    
    if(message.length == 0){
        return;
    }
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *HUD = [[MBProgressHUD alloc] init];
    [window addSubview:HUD];
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MBProgressHUD_con_failed.png"]];
    
    HUD.detailsLabelText = message;
    HUD.mode = MBProgressHUDModeText;
    HUD.margin = 10.f;
    HUD.yOffset = 15.f;
    HUD.detailsLabelFont = [UIFont systemFontOfSize:15.0f];
    
    if(message.length >= 13){
        CGSize size = HUD.size;
        
        int lines = ((int)message.length / 13) + 1;
        
        HUD.minSize = CGSizeMake(size.width, lines * 16);
    }
    
    [HUD show:YES];
    [HUD hide:YES afterDelay:0.5f];
}

//用于显示提示信息的浮动框
+(void)displaySuccessAlert:(NSString*)title message:(NSString*)message onView:(UIView*)aView{
    //UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:aView];
    // Add HUD to screen
    [aView addSubview:HUD];
    
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MBProgressHUD_con_success.png"]];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.labelText = title;
    HUD.detailsLabelText = message;
    [HUD show:YES];
    [HUD hide:YES afterDelay:1.5];
}


//用于显示提示信息的浮动框
+(void)displayWarningAlert:(NSString*)title message:(NSString*)message onView:(UIView*)aView{
    //UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:aView];
    // Add HUD to screen
    [aView addSubview:HUD];
    
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MBProgressHUD_con_failed.png"]];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.labelText = title;
    HUD.detailsLabelText = message;
    [HUD show:YES];
    [HUD hide:YES afterDelay:1.5];
}

+(void)displaySuccessAlert:(NSString*)message onView:(UIView*)aView{
    //UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:aView];
    // Add HUD to screen
    [aView addSubview:HUD];
    
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MBProgressHUD_con_success.png"]];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.labelText = message;
    [HUD show:YES];
    [HUD hide:YES afterDelay:1.5];
}


//用于显示提示信息的浮动框
+(void)displayWarningAlert:(NSString*)message onView:(UIView*)aView{
    //UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:aView];
    // Add HUD to screen
    [aView addSubview:HUD];
    
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MBProgressHUD_con_failed.png"]];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.labelText = message;
    [HUD show:YES];
    [HUD hide:YES afterDelay:1.5];
}

+(void)displaySuccessAlert:(NSString *)message onHUD:(MBProgressHUD *)HUD{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (!HUD) {
        HUD = [[MBProgressHUD alloc] initWithView:window];
    }
    [window addSubview:HUD];
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MBProgressHUD_con_success.png"]];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.labelText = message;
    [HUD show:YES];
    [HUD hide:YES afterDelay:1.5f];
}


+(void)displaySuccessAlert:(NSString*)message interval:(float)interval onHUD:(MBProgressHUD *)HUD{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (!HUD) {
        HUD = [[MBProgressHUD alloc] initWithView:window];
    }
    [window addSubview:HUD];
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MBProgressHUD_con_success.png"]];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.labelText = message;
    [HUD show:YES];
    [HUD hide:YES afterDelay:interval];
}

+(void)displayWarningAlert:(NSString*)message onHUD:(MBProgressHUD *)HUD{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (!HUD) {
        HUD = [[MBProgressHUD alloc] initWithView:window];
    }
    
    [window addSubview:HUD];
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MBProgressHUD_con_failed.png"]];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.labelText = message;
    [HUD show:YES];
    [HUD hide:YES afterDelay:2.0f];
}


+(void)displayWarningAlert:(NSString*)message interval:(float)interval onHUD:(MBProgressHUD *)HUD{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (!HUD) {
        HUD = [[MBProgressHUD alloc] initWithView:window];
    }
    [window addSubview:HUD];
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MBProgressHUD_con_failed.png"]];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.labelText = message;
    [HUD show:YES];
    [HUD hide:YES afterDelay:interval];
}

+ (void)displayLoadingAlert:(NSString *)message onView:(UIView *)aView
{
    
}

+ (void)displayFailNoteWithCode:(NSInteger)desCode andDesc:(NSString *)desc{
    
    if(desCode != 100){
        
        [self displayWarningAlert:desc];
    }
}

@end
