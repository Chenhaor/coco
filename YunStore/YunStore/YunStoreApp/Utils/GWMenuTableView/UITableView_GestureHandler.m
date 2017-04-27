//
//  UITableView_GestureHandler.m
//
//  Created by ybs on 15/10/28.
//  Copyright © 2015年 yangye. All rights reserved.
//

#import "UITableView_GestureHandler.h"
#import "GWMicro.h"
#import "GWMenuTableViewCell.h"

@interface UITableView_GestureHandler()<UIGestureRecognizerDelegate>
{
    UIPanGestureRecognizer *_panGesture;
}

@property (nonatomic, weak)GWMenuTableViewCell *currentMenuTableCell;

@end

@implementation UITableView_GestureHandler

#pragma mark -

- (void)openGWTableViewMenu
{
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if(_panGesture == nil)
    {
        _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureHandler:)];
        _panGesture.maximumNumberOfTouches = 1;
        _panGesture.delegate = self;
    }
    [self addGestureRecognizer:_panGesture];
}

- (void)closeGWTableViewMenu
{
    [self removeGestureRecognizer:_panGesture];
    _panGesture = nil;
}

#pragma mark - 手势处理
- (void)panGestureHandler:(UIPanGestureRecognizer *)gesture
{
    CGFloat deltaX = [gesture translationInView:self].x;
    
    switch (gesture.state)
    {
        case UIGestureRecognizerStateBegan:
        {
            CGPoint point = [gesture locationInView:self];
            NSIndexPath *indexPath = [self indexPathForRowAtPoint:point];
            self.currentMenuTableCell = (GWMenuTableViewCell *)[self cellForRowAtIndexPath:indexPath];
            [self.currentMenuTableCell swipeBeganWithDeltaX:deltaX];
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            self.currentMenuTableCell.deltaX = deltaX;
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            [self.currentMenuTableCell swipeEndWithDeltaX:deltaX];
        }
            break;
        default:
            break;
    }
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ( gestureRecognizer == _panGesture )
    {
        if(self.currentMenuTableCell && self.currentMenuTableCell.menuState != GWMenuTableViewCellState_Common)
        {
            CGPoint point = [gestureRecognizer locationInView:self];
            
            NSIndexPath *indexPath = [self indexPathForRowAtPoint:point];
            
            GWMenuTableViewCell *cell = (GWMenuTableViewCell *)[self cellForRowAtIndexPath:indexPath];
            
            if(cell != self.currentMenuTableCell)
            {
                self.currentMenuTableCell.menuState = GWMenuTableViewCellState_Common;
                return NO;
            }
        }
        
        CGPoint translation = [_panGesture translationInView:self];
        return fabs(translation.y) <= fabs(translation.x);
    }
    else
    {
        return YES;
    }
}

@end
