//
//
//  Created by yangye on 14-10-14.
//  Copyright (c) 2014年. All rights reserved.
// 提示框（基类）

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PopStyle) {
    Style_PopFromCenter = 0,
    Style_PopFromBottom = 1
};

@interface GWCustomerAlertView : UIView

@property (nonatomic,assign) CGFloat alertViewW;
@property (nonatomic,assign) CGFloat alertViewH; //alertView height

@property (nonatomic, copy)  dispatch_block_t leftBlock;
@property (nonatomic, copy)  dispatch_block_t rightBlock;

@property (nonatomic, assign) BOOL touchOutSideIsDismiss; //default is no，set yes it will dismiss when you click the backgroundView

@property (nonatomic,assign) CGFloat locationY; //set alertView's location y
@property (nonatomic,assign) CGFloat locationX; //set alertView's location X

@property (nonatomic,strong) UIView *backgroundView;

@property (nonatomic,assign) PopStyle popStyle;

- (void)show;
- (void)showInView:(UIView *)aView;

- (void)dismissAlert:(dispatch_block_t)dismissFinishBlock;
- (void)dismissAlert;
@end


