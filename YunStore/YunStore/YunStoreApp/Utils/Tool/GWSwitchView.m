//
//  GWSwitchView.m
//  Holoera
//
//  Created by yangye on 16/10/19.
//  Copyright © 2016年. All rights reserved.
//

#import "GWSwitchView.h"

@interface GWSwitchView()
{
    BOOL _valueChange;
    
    NSInteger _touchBeganIndex;
    UIView *_lineView;
    UIImageView *_checkImgView;
}
@end

@implementation GWSwitchView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initData];
    }
    return self;
}

- (void)initData
{
    self.selectedStyle = LineView_Style;
    self.titleFont = [UIFont boldSystemFontOfSize:16];
    self.selectedTitleColor = [UIColor whiteColor];
    self.unSelectedTitleColor = UIColorFromHexValue(0x7e99a7);
}

- (void)setSelectedStyle:(SelectedStyle)selectedStyle
{
    _selectedStyle = selectedStyle;
    
    if (self.selectedStyle == LineView_Style)
    {
        if (!_lineView) {
            _lineView = [[UIView alloc] initWithFrame:CGRectZero];
            _lineView.backgroundColor = RGBCOLOR(29, 170, 252);
            [self addSubview:_lineView];
        }
    }
    else if (self.selectedStyle == SelectBox_Style)
    {
        if (!_checkImgView) {
            _checkImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
            [self addSubview:_checkImgView];
        }
    }
}

- (void)setLineViewColor:(UIColor *)lineViewColor
{
    _lineViewColor = lineViewColor;
    
    _lineView.backgroundColor = lineViewColor;
}

- (void)setSelectCheckedImg:(UIImage *)selectCheckedImg
{
    _checkImgView.image = selectCheckedImg;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    if (self.selectedStyle == SelectBox_Style && self.swithchViewBgImg)
        [self.swithchViewBgImg drawInRect:CGRectMake(0, 0, rect.size.width, rect.size.height)];
    
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    CGContextSetLineWidth(context, 0.5 * 0.5);
    
    CGFloat step = rect.size.width / [self.conditions count];
    
    /*if (self.showSpecLine)
    {
        //bottom line
        CGContextMoveToPoint(context, 0, rect.size.height - 0.5 * 0.5);
        CGContextAddLineToPoint(context, rect.size.width, rect.size.height - 0.5 * 0.5);
        
        CGContextSetStrokeColorWithColor(context, [UIColor colorWithWhite:0.6 alpha:1.0].CGColor);
        
        for (int i = 1; i < [self.conditions count]; i++)
        {
            CGContextMoveToPoint(context, step*i, 6);
            CGContextAddLineToPoint(context, step*i, rect.size.height-12);
        }
    }
    
    CGContextStrokePath(context);
    CGContextRestoreGState(context);*/
    
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.alignment = NSTextAlignmentCenter;
    UIColor *textColor = nil;
    
    NSDictionary *attr = nil;
    
    for (int index = 0; index < [self.conditions count] ; index++)
    {
        textColor = (index == _currentIndex) ? self.selectedTitleColor : self.unSelectedTitleColor;
        
        attr = @{ NSFontAttributeName : self.titleFont,
                  NSForegroundColorAttributeName : textColor,
                  NSParagraphStyleAttributeName : style};
        
        NSString *str = [self.conditions objectAtIndex:index];
        
        CGFloat strY = 0.0;
        CGFloat strH = 0.0;
        
        if (self.selectedStyle == LineView_Style)
        {
            strY = (rect.size.height - self.titleFont.pointSize)/2.0 - 3;
            strH = rect.size.height - 3;
        }
        else
        {
            strY = (rect.size.height - self.titleFont.pointSize)/2.0;
            strH = rect.size.height;
        }
        
        [str drawInRect:CGRectMake(step * index, strY, step, strH)
         withAttributes:attr];
    }
}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    [super beginTrackingWithTouch:touch withEvent:event];
    
    CGPoint location = [touch locationInView:self];
    CGRect frame = [self frame];
    
    //计算触点序号
    CGFloat widthPerItem = frame.size.width / (CGFloat)[self.conditions count];
    _touchBeganIndex = floor(location.x / widthPerItem);
    
    _touchBeganIndex = (_touchBeganIndex >= self.conditions.count) ? (self.conditions.count - 1) : _touchBeganIndex;
    
    //点击序号与已有序号不同则开始 更新绘图
    _valueChange = (_touchBeganIndex != _currentIndex);
    
    if (_valueChange)
    {
        _currentIndex = _touchBeganIndex;
    }
    
    return YES;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    [super endTrackingWithTouch:touch withEvent:event];
    
    if (_valueChange)
    {
        CGPoint location = [touch locationInView:self];
        CGRect frame = [self frame];
        CGFloat widthPerItem = frame.size.width / (CGFloat)[self.conditions count];
        NSUInteger itemIndex = floor(location.x / widthPerItem);
        
        itemIndex = (itemIndex >= self.conditions.count) ? (self.conditions.count - 1) : itemIndex;
        
        if (itemIndex == _touchBeganIndex)
        {
            _currentIndex = _touchBeganIndex;
            
            [self setNeedsDisplay];
            
            if ([self.delegate respondsToSelector:@selector(switchView:didselectTab:)])
            {
                [self.delegate switchView:self didselectTab:_currentIndex];
            }
            
            [self slideToIndex:itemIndex];
            
            [self sendActionsForControlEvents:UIControlEventValueChanged];
        }
    }
}

//在这个界面，手指移动时cancelled被调用
- (void)cancelTrackingWithEvent:(UIEvent *)event
{
    [super cancelTrackingWithEvent:event];
    _valueChange = NO;
    _currentIndex = -1;
}

#pragma mark utils 
- (void)slideToIndex:(NSInteger)index
{
    CGFloat widthPerItem = self.frame.size.width / (CGFloat)[self.conditions count];

    [UIView animateWithDuration:0.25 animations:^{
        
        if (self.selectedStyle == LineView_Style)
            _lineView.frame = CGRectMake(widthPerItem * index, self.frame.size.height - 3, widthPerItem, 3);
        else
            _checkImgView.frame = CGRectMake(widthPerItem * index, 0, widthPerItem, self.frame.size.height);
    }];
}

#pragma mark setter/getter
- (void)setConditions:(NSArray *)conditions
{
    if (_conditions != conditions)
    {
        _conditions = conditions;
        
        [self setNeedsDisplay];
        
        CGFloat widthPerItem = self.frame.size.width/(CGFloat)[self.conditions count];

        if (self.selectedStyle == LineView_Style)
            _lineView.frame = CGRectMake(widthPerItem * _currentIndex, self.frame.size.height - 3, widthPerItem, 3);
        else
            _checkImgView.frame = CGRectMake(widthPerItem * _currentIndex, 0, widthPerItem, self.frame.size.height);
    }
}

- (void)setCurrentIndex:(NSInteger)currentIndex
{
    if (currentIndex != _currentIndex)
    {
        _currentIndex = currentIndex;
        
        [self setNeedsDisplay];
        
        [self slideToIndex:currentIndex];
    }
}

- (void)setSelectedTitleColor:(UIColor *)selectedTitleColor
{
    if (_selectedTitleColor != selectedTitleColor) {
        _selectedTitleColor = selectedTitleColor;
        [self setNeedsDisplay];
    }
}

- (void)setUnSelectedTitleColor:(UIColor *)unSelectedTitleColor
{
    if (_unSelectedTitleColor != unSelectedTitleColor) {
        _unSelectedTitleColor = unSelectedTitleColor;
        [self setNeedsDisplay];
    }
}

@end
