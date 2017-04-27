//
//  GWMenuTableViewCell.h
//  GWMenuTableViewCell
//
//  Created by yangye on 15/3/27.
//  Copyright (c) 2015年 yangye. All rights reserved.
//

#import "GWMenuTableViewCell.h"
#import "GWMicro.h"
#import "UIView+JHExtension.h"
#import "GWMenuTextAction.h"
#import "GWMenuImgAction.h"

#define GWMenuTriggerDistance   (GWActionButtonWidth*2/3)           //触发Menu动画的距离

@interface GWMenuTableViewCell ()

@property (nonatomic, assign)CGFloat startOriginX;

@end

@implementation GWMenuTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.actionsView = [[GWMenuActionView alloc] initWithFrame:self.bounds];
        self.actionsView.delegate = self;
        [self addSubview:_actionsView];
        
        self.customView = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:_customView];
    }
    return self;
}

- (void)prepareForReuse
{
    self.menuState = GWMenuTableViewCellState_Common;
}

- (void)layoutSubviews
{
    CGFloat actionViewW = 0.0;
    
    for(NSInteger i = 0; i < [_actions count]; i++)
    {
        GWMenuAction *action = [_actions objectAtIndex:i];
        
        CGSize actionBtnSize = CGSizeZero;
        
        if ([action isKindOfClass:[GWMenuImgAction class]])
        {
            GWMenuImgAction *actionImg = (GWMenuImgAction *)action;
            UIImage *img = [UIImage imageNamed:actionImg.actionBtnPicNormal];
            actionViewW += (img.size.width + GWActionBtnPicPadding * 2);
        }
        else if ([action isKindOfClass:[GWMenuTextAction class]])
        {
            GWMenuTextAction *actionText = (GWMenuTextAction *)action;
            actionBtnSize = [actionText.title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:GWActionButtonTextFontSize]}];
            actionViewW += (actionBtnSize.width + GWActionBtnTitlePadding * 2);
        }
    }
    
    self.actionsView.frame = CGRectMake(self.bounds.size.width - actionViewW, 0, actionViewW, self.bounds.size.height);
    
    self.customView.frame = CGRectMake(_customView.frame.origin.x, _customView.frame.origin.y, self.bounds.size.width, self.bounds.size.height);
}

- (void)setActions:(NSArray *)actions
{
    _actions = actions;
    
    [_actionsView setActions:actions];
}

- (void)setMenuState:(GWMenuTableViewCellState)menuState
{
    _menuState = menuState;
    
    CGRect fromRect = self.customView.frame;
    CGRect toRect = fromRect;
    switch (_menuState) {
        case GWMenuTableViewCellState_Common:
        {
            toRect.origin.x = 0;
            [self.actionsView setMoreButtonHidden:NO];
        }
            break;
        case GWMenuTableViewCellState_Division:
        {
            toRect.origin.x = self.actionsView.divisionOriginX;
            [self.actionsView setMoreButtonHidden:NO];
        }
            break;
        case GWMenuTableViewCellState_Expanded:
        {
            toRect.origin.x = -self.actionsView.jh_width;
            [self.actionsView setMoreButtonHidden:YES];
        }
            break;
    }
    
    [UIView animateWithDuration:GWMenuExpandAnimationDuration animations:^{
        self.customView.frame = toRect;
    }];
}

- (void)setDeltaX:(CGFloat)deltaX
{
    _deltaX = deltaX;
    
    CGFloat originX = self.startOriginX + deltaX;
    
    if(_menuState == GWMenuTableViewCellState_Division)
    {
        //分段显示时，移动customView处理更多按钮的动画
        if(deltaX < 0)
            self.actionsView.moreBtn.alpha = 1 - MIN(1, ABS(deltaX) /GWMenuTriggerDistance);
    }
    
    if(originX > 0)
    {
        originX = 0;
    }
    
    if(originX < - _actionsView.jh_width)
    {
        originX = - _actionsView.jh_width;
    }
    
    self.customView.jh_originX = originX;
}

- (void)swipeBeganWithDeltaX:(CGFloat)deltaX
{
    self.startOriginX = self.customView.jh_originX;
}

- (void)swipeEndWithDeltaX:(CGFloat)deltaX
{
    switch (_menuState) {
        case GWMenuTableViewCellState_Common:
        {
            if(deltaX < -GWMenuTriggerDistance)
            {
                self.menuState = self.actionsView.canDivision ? GWMenuTableViewCellState_Division : GWMenuTableViewCellState_Expanded;
            }
            else
            {
                self.menuState = GWMenuTableViewCellState_Common;
            }
        }
            break;
        case GWMenuTableViewCellState_Division:
        {
            if(deltaX < -GWMenuTriggerDistance)
            {
                self.menuState = GWMenuTableViewCellState_Expanded;
            }
            else if(deltaX > GWMenuTriggerDistance)
            {
                self.menuState = GWMenuTableViewCellState_Common;
            }
            else
            {
                self.menuState = GWMenuTableViewCellState_Division;
            }
        }
            break;
        case GWMenuTableViewCellState_Expanded:
        {
            if(deltaX > GWMenuTriggerDistance)
            {
                self.menuState = GWMenuTableViewCellState_Common;
            }
            else
            {
                self.menuState = GWMenuTableViewCellState_Expanded;
            }
        }
            break;
    }
}

- (BOOL)leftSwipIsClose
{
    return self.deltaX == 0.0;
}

- (void)closeLeftSwip
{
    [self swipeEndWithDeltaX:self.actionsView.bounds.size.width];
    _deltaX = 0.0;
}

#pragma mark - GWMenuActionViewDelegate
- (void)actionViewEventHandler:(GWActionBlock)actionBlock
{
    if(actionBlock)
    {
        UITableView *tableView = (UITableView *)self.superview.superview;
        
        actionBlock(self, [tableView indexPathForCell:self]);
    }
}

- (void)moreButtonEventHandler
{
    self.menuState = GWMenuTableViewCellState_Expanded;
}

@end
