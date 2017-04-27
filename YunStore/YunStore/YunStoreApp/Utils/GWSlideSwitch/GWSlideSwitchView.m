//
//  SlideSwitchView.m
//
//  Created by yangye on 15/8/7.
//  Copyright (c) 2015年. All rights reserved.
//

#import "GWSlideSwitchView.h"

@interface GWSlideSwitchView()
{
    BOOL _isBuildUI;                                //是否建立了ui
}

@property (nonatomic, strong) UIScrollView *rootScrollView;  //主视图
@property (nonatomic, strong) UIScrollView *topScrollView;   //顶部视图

@property (nonatomic, assign) NSInteger userSelectedChannelID; //点击按钮选择名字ID

@property (nonatomic, strong) NSArray *viewArray;//主视图的子视图数组\

@property (nonatomic, strong) UIImageView *shadowImgView;

@end

@implementation GWSlideSwitchView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initDefaultVaule];
        
        [self initViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initDefaultVaule];

        [self initViews];
    }
    return self;
}

- (void)initDefaultVaule
{
    _heightOfTopScrollView = 20.0;
    _widthOfButtonMargin = 14.0;
    _fontSizeOfTabButton = 14.0f;
}

- (void)initViews
{
    //创建顶部可滑动的tab
    _topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, _heightOfTopScrollView)];
    _topScrollView.backgroundColor = [UIColor whiteColor];
    _topScrollView.delegate = self;
    _topScrollView.pagingEnabled = NO;
    _topScrollView.showsHorizontalScrollIndicator = NO;
    _topScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self addSubview:_topScrollView];
    
    _userSelectedChannelID = 100;
    
    //创建主滚动视图
    _rootScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _heightOfTopScrollView + 8, self.bounds.size.width, self.bounds.size.height - _heightOfTopScrollView - 8)];
    _rootScrollView.delegate = self;
    _rootScrollView.pagingEnabled = YES;
    _rootScrollView.userInteractionEnabled = YES;
    _rootScrollView.bounces = NO;
    _rootScrollView.showsVerticalScrollIndicator = NO;
    _rootScrollView.showsHorizontalScrollIndicator = NO;
    _rootScrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    [_rootScrollView.panGestureRecognizer addTarget:self action:@selector(scrollHandlePan:)];
    [self addSubview:_rootScrollView];
    
    _isBuildUI = NO;
}

- (void)setHeightOfTopScrollView:(CGFloat)heightOfTopScrollView
{
    if (_heightOfTopScrollView != heightOfTopScrollView)
    {
        _heightOfTopScrollView = heightOfTopScrollView;
        
        _topScrollView.frame = CGRectMake(_topScrollView.frame.origin.x, _topScrollView.frame.origin.y, _topScrollView.frame.size.width, heightOfTopScrollView);
        _rootScrollView.frame = CGRectMake(0, _heightOfTopScrollView + 8, _rootScrollView.frame.size.width, self.bounds.size.height - _heightOfTopScrollView - 8);
    }
}

- (void)setShadowImg:(UIImage *)shadowImg
{
    if (!_shadowImgView) {
        _shadowImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [_topScrollView addSubview:_shadowImgView];
    }
    _shadowImgView.image = shadowImg;
}

- (void)slideShadowImgToIndex:(NSUInteger)index
{
    UIButton *button = (UIButton *)[_topScrollView viewWithTag:100 + index];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        _shadowImgView.frame = CGRectMake(button.frame.origin.x + 5, button.frame.size.height - 2, button.frame.size.width - 10, 2);
    }];
}

//当横竖屏切换时可通过此方法调整布局
- (void)layoutSubviews
{
    //创建完子视图UI才需要调整布局
    if (_isBuildUI)
    {
        //更新主视图各个子视图的宽度
        for (int i = 0; i < [_viewArray count]; i++) {
            
            UIViewController *listVC = _viewArray[i];
            listVC.view.frame = CGRectMake( 0 + _rootScrollView.bounds.size.width * i, 0,
                                           _rootScrollView.bounds.size.width, _rootScrollView.bounds.size.height);
        }
        
        //滚动到选中的视图
        [_topScrollView setContentOffset:CGPointMake((_userSelectedChannelID - 100) * self.bounds.size.width, 0) animated:YES];
        
        //调整顶部滚动视图选中按钮位置
        UIButton *button = (UIButton *)[_topScrollView viewWithTag:_userSelectedChannelID];
        
        [self adjustScrollViewContentX:button];
    }
}

#pragma mark - public methods

- (void)buildUI
{
    _viewArray = [self.slideSwitchViewDelegate childsVcOfSlideSwitchView];
    
    _rootScrollView.contentSize = CGSizeMake(self.bounds.size.width * _viewArray.count, 0);
    
    CGFloat buttonW = (CGFloat)(self.bounds.size.width - (_viewArray.count + 1) * _widthOfButtonMargin) / (CGFloat)_viewArray.count;
    
    CGFloat buttonX = _widthOfButtonMargin;
    
    for (int i = 0; i < [_viewArray count]; i++)
    {
        UIViewController *childVc = _viewArray[i];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.tag = i + 100;
        
        if (_isTopViewScroll)
        {
            CGSize titleSize = [childVc.title sizeWithAttributes:@{
                                                                   NSFontAttributeName:button.titleLabel.font
                                                                   }];
            buttonW = titleSize.width + 20;
            button.frame = CGRectMake(buttonX, 0, buttonW, _heightOfTopScrollView);
            buttonX += buttonW + _widthOfButtonMargin;
        }
        else
        {
            button.frame = CGRectMake(buttonX, 0 , buttonW , _heightOfTopScrollView);
            buttonX += _widthOfButtonMargin + buttonW;
        }
        
        [button setTitle:childVc.title forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:_fontSizeOfTabButton];
        [button setTitleColor:self.tabItemNormalColor forState:UIControlStateNormal];
        [button setTitleColor:self.tabItemSelectedColor forState:UIControlStateSelected];
        [button setBackgroundImage:self.tabItemNormalBackgroundImage forState:UIControlStateNormal];
        [button setBackgroundImage:self.tabItemSelectedBackgroundImage forState:UIControlStateSelected];
        [button addTarget:self action:@selector(selectNameButton:) forControlEvents:UIControlEventTouchUpInside];
        [_topScrollView addSubview:button];
        
        if (i == 0){
            button.selected = YES;
            _shadowImgView.frame = CGRectMake(button.frame.origin.x + 10, button.frame.size.height - 2, button.frame.size.width - 20, 2);
        }
        
        [_rootScrollView addSubview:childVc.view];
    }
    
    if (_isTopViewScroll) {
        //设置顶部滚动视图的内容总尺寸
        _topScrollView.contentSize = CGSizeMake(buttonX, 0);
    }
    
    //选中第一个view
    if (self.slideSwitchViewDelegate && [self.slideSwitchViewDelegate respondsToSelector:@selector(slideSwitchView:didselectTab:)])
        [self.slideSwitchViewDelegate slideSwitchView:self didselectTab:_userSelectedChannelID - 100];
    
    _isBuildUI = YES;
    //创建完子视图UI才需要调整布局
    [self setNeedsLayout];
}

- (void)configTopScrollViewBtnTitle:(NSArray *)titleArr
{
    NSAssert(titleArr.count == _viewArray.count, @"传入的数组元素个数与实际的不一致！！！");
    
    for (int index = 0; index < _viewArray.count; index ++){
        UIButton *button = [_topScrollView viewWithTag:100 + index];
        NSString *titleStr = titleArr[index];
        [button setTitle:titleStr forState:UIControlStateNormal];
    }
}

#pragma mark - private methods
/*
 * @method 选中tab时间
 */
- (void)selectNameButton:(UIButton *)sender
{
    [self adjustScrollViewContentX:sender];
    
    if (sender.tag != _userSelectedChannelID)
    {
        UIButton *lastButton = (UIButton *)[_topScrollView viewWithTag:_userSelectedChannelID];
        lastButton.selected = NO;
        //赋值按钮ID
        _userSelectedChannelID = sender.tag;
    }
    //按钮选中状态
    if (!sender.selected)
    {
        sender.selected = YES;
        
        //设置新页出现
        [_rootScrollView setContentOffset:CGPointMake((sender.tag - 100)*self.bounds.size.width, 0) animated:YES];
        [self slideShadowImgToIndex:_userSelectedChannelID - 100];

        if (self.slideSwitchViewDelegate && [self.slideSwitchViewDelegate respondsToSelector:@selector(slideSwitchView:didselectTab:)])
            [self.slideSwitchViewDelegate slideSwitchView:self didselectTab:_userSelectedChannelID - 100];
    }
}

/*
 * @method 调整顶部滚动视图x位置
 */
- (void)adjustScrollViewContentX:(UIButton *)sender
{
    if (_isTopViewScroll)
    {
        CGFloat targetX = CGRectGetMidX(sender.frame) - _topScrollView.bounds.size.width/2.0f;
        //左边缘适配
        if (targetX <=0) {
            targetX = 0;
        }
        //右边缘适配
        if (targetX >= _topScrollView.contentSize.width - _topScrollView.bounds.size.width) {
            targetX = _topScrollView.contentSize.width - _topScrollView.bounds.size.width;
        }
        [_topScrollView setContentOffset:CGPointMake(targetX, 0) animated:YES];
    }
}

//传递滑动事件给下一层
-(void)scrollHandlePan:(UIPanGestureRecognizer*) panParam
{
    //当滑道左边界时，传递滑动事件给代理
    if(_rootScrollView.contentOffset.x <= 0)
    {
        if (self.slideSwitchViewDelegate
            && [self.slideSwitchViewDelegate respondsToSelector:@selector(slideSwitchView:panLeftEdge:)])
        {
            [self.slideSwitchViewDelegate slideSwitchView:self panLeftEdge:panParam];
        }
    }
    else if(_rootScrollView.contentOffset.x >= _rootScrollView.contentSize.width - _rootScrollView.bounds.size.width)
    {
        if (self.slideSwitchViewDelegate
            && [self.slideSwitchViewDelegate respondsToSelector:@selector(slideSwitchView:panRightEdge:)])
        {
            [self.slideSwitchViewDelegate slideSwitchView:self panRightEdge:panParam];
        }
    }
}

#pragma mark - scrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == _rootScrollView)
    {
        //调整顶部滑条按钮状态
        int tag = (int)scrollView.contentOffset.x/self.bounds.size.width +100;
        UIButton *button = (UIButton *)[_topScrollView viewWithTag:tag];
        [self selectNameButton:button];
    }
}

@end
