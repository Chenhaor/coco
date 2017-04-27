//
//  GWMenuActionView.h
//  GWMenuTableViewDemo
//
//  Created by yangye on 15/3/27.
//  Copyright (c) 2015年 yangye. All rights reserved.
//

#import "GWMenuActionView.h"
#import "GWMenuAction.h"
#import "GWMicro.h"
#import "UIView+JHExtension.h"
#import "GWMenuTextAction.h"
#import "GWMenuImgAction.h"

@interface GWMenuActionView ()

@property (nonatomic, strong)NSArray *actions;

@end

@implementation GWMenuActionView

- (void)setActions:(NSArray *)actions
{
    [self clearAllActions];
    
    _actions = actions;
    
    _canDivision = NO;
    
    CGFloat actionBtnX = 0.0;
    
    for(NSInteger i = 0; i < [_actions count]; i++)
    {
        GWMenuAction *action = [_actions objectAtIndex:i];
        
        UIButton *actionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        actionBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
        actionBtn.tag = i;
        [actionBtn setBackgroundColor:action.backgroundColor];
        [actionBtn addTarget:self action:@selector(actionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:actionBtn];

        if ([action isKindOfClass:[GWMenuImgAction class]])//处理图片
        {
            GWMenuImgAction *actionImg = (GWMenuImgAction *)action;
            UIImage *normalImg = [UIImage imageNamed:actionImg.actionBtnPicNormal];
            CGSize normalImgSize = normalImg.size;
            [actionBtn setImage:normalImg forState:UIControlStateNormal];
            if (actionImg.actionBtnPicSelected)
            {
                [actionBtn setImage:[UIImage imageNamed:actionImg.actionBtnPicSelected] forState:UIControlStateSelected];
            }
            actionBtn.frame = CGRectMake(actionBtnX, 0, normalImgSize.width + GWActionBtnPicPadding * 2, self.bounds.size.height);
            actionBtnX += (normalImgSize.width + GWActionBtnPicPadding * 2);
        }
        else if ([action isKindOfClass:[GWMenuTextAction class]]) //处理文字的
        {
            GWMenuTextAction *actionText = (GWMenuTextAction *)action;
            actionBtn.titleLabel.font = [UIFont systemFontOfSize:GWActionButtonTextFontSize];
            [actionBtn setTitle:actionText.title forState:UIControlStateNormal];
            [actionBtn setTitleColor:actionText.titleColor forState:UIControlStateNormal];
            actionBtn.titleLabel.numberOfLines = 0;
            CGSize actionBtnSize = [actionText.title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:GWActionButtonTextFontSize]}];
            actionBtn.frame = CGRectMake(actionBtnX, 0, actionBtnSize.width + GWActionBtnTitlePadding * 2, self.bounds.size.height);
            actionBtnX += (actionBtnSize.width + GWActionBtnTitlePadding * 2);
        }
    }
    
    if(GWActionMoreButtonShow && (_actions.count - 1) > GWActionMoreButtonIndex)
    {
        //这部分未实现
        _canDivision = YES;
        NSInteger i = _actions.count - GWActionMoreButtonIndex - 1;
        GWMenuTextAction *action = [_actions objectAtIndex:i];
        
        self.moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _moreBtn.titleLabel.font = [UIFont systemFontOfSize:GWActionButtonTextFontSize];
        [_moreBtn setBackgroundColor:action.backgroundColor];
        [_moreBtn setTitle:@"<" forState:UIControlStateNormal];
        [_moreBtn setTitleColor:action.titleColor forState:UIControlStateNormal];
        _moreBtn.titleLabel.numberOfLines = 0;
        CGSize actionBtnSize = [action.title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:GWActionButtonTextFontSize]}];
        _moreBtn.frame = CGRectMake(actionBtnX, 0, actionBtnSize.width + 20, self.bounds.size.height);
        _moreBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
        [_moreBtn addTarget:self action:@selector(moreButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_moreBtn];
    }
}

- (void)setMoreButtonHidden:(BOOL)hidden
{
    [UIView animateWithDuration:GWMenuExpandAnimationDuration animations:^{
        _moreBtn.alpha = hidden ? 0 : 1;
    } completion:^(BOOL finished) {
        _moreBtn.hidden = hidden;
    }];
}

- (CGFloat)divisionOriginX
{
    return - (self.jh_width - _moreBtn.jh_originX);
}

/**
 *  清除现有的Actions
 */
- (void)clearAllActions
{
    NSArray *subViews = [self subviews];
    
    for(UIView *subView in subViews)
    {
        [subView removeFromSuperview];
    }
    
    _actions = nil;
}

- (void)actionButtonClicked:(UIButton *)btn
{
    GWMenuAction *action = [_actions objectAtIndex:btn.tag];
    
    if([self.delegate respondsToSelector:@selector(actionViewEventHandler:)])
    {
        [self.delegate actionViewEventHandler:action.actionBlock];
    }
}

- (void)moreButtonClicked
{
    if([self.delegate respondsToSelector:@selector(moreButtonEventHandler)])
    {
        [self.delegate moreButtonEventHandler];
    }
}

@end
