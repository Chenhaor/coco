//
//  GWMenuActionView.h
//  GWMenuTableViewDemo
//
//  Created by yangye on 15/3/27.
//  Copyright (c) 2015年 yangye. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GWMenuAction.h"

@protocol GWMenuActionViewDelegate <NSObject>

- (void)actionViewEventHandler:(GWActionBlock)actionBlock;

- (void)moreButtonEventHandler;

@end

@interface GWMenuActionView : UIView

@property (nonatomic, strong)UIButton *moreBtn;

@property (nonatomic, assign)id<GWMenuActionViewDelegate> delegate;
/**
 *  Menu是否能够分开展示
 */
@property (nonatomic, readonly)BOOL canDivision;

@property (nonatomic, getter = divisionOriginX)CGFloat divisionOriginX;

- (void)setActions:(NSArray *)actions;

- (void)setMoreButtonHidden:(BOOL)hidden;

@end
