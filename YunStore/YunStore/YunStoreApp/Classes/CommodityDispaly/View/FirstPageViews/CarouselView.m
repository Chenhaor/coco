//
//  CarouselView.m
//  YunFuStore
//
//  Created by apple on 2017/4/19.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CarouselView.h"

@interface CarouselView ()<UIScrollViewDelegate>

@property(nonatomic, strong)NSMutableArray *scrollDataArr;
@property(nonatomic, strong)UIImageView *pageBackimageView;
@end

@implementation CarouselView{
    CGFloat _ImageWidth;
    CGFloat _imageHeight;
    NSTimer *_timer;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addTimer];
        [self createUI];
    }
    return self;
}

-(void)addTimer{
    _timer=[NSTimer scheduledTimerWithTimeInterval:2.5f target:self selector:@selector(nextPhoto) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

-(void)createUI{
    _scroll=[[UIScrollView alloc]initWithFrame:self.frame];
    _scroll.delegate=self;
    _scroll.showsHorizontalScrollIndicator=NO;
    [self addSubview:_scroll];
    
    _scroll.contentOffset = CGPointMake(kScreenWidth, 0);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(adTap:)];
    _scroll.userInteractionEnabled=YES;
    [_scroll addGestureRecognizer:tap];
    
    _pageBackimageView=[UIImageView new];
    _pageBackimageView.frame=CGRectMake(0, self.frame.size.height - 30, kScreenWidth, 30);
    _pageBackimageView.image=[UIImage imageNamed:@"carouselRadian"];
    _pageBackimageView.contentMode=UIViewContentModeScaleToFill;
    [self addSubview:_pageBackimageView];
    
    _pageControl = [[YFPageControl alloc] initWithFrame:CGRectMake(0, 27, kScreenWidth, 3)];
    _pageControl.tag = 100;
    _pageControl.userInteractionEnabled = NO;
    _pageControl.backgroundColor = [UIColor clearColor];
    [_pageBackimageView addSubview:_pageControl];
}

-(void)setAdDataArry:(NSMutableArray *)adDataArry{
    
    if (_adDataArry != adDataArry) {
        _adDataArry=adDataArry;
        
        _scrollDataArr= [[NSMutableArray  alloc]initWithArray:_adDataArry];
        //处理好前后各加一张
        [_scrollDataArr addObject:[_scrollDataArr firstObject]];
        //0 1 2 3 4
        [_scrollDataArr insertObject:_scrollDataArr[_scrollDataArr.count - 2] atIndex:0];
        
        for (UIView *view in _scroll.subviews) {
            [view removeFromSuperview];
        }
        
        for (int i=0; i<_scrollDataArr.count; i++) {
            UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(i * _scroll.frame.size.width, 0, _scroll.frame.size.width, _scroll.frame.size.height)];
            
            iv.image=[UIImage imageNamed:_scrollDataArr[i]];
            [_scroll addSubview:iv];
            
        }
        _scroll.contentSize=CGSizeMake(kScreenWidth*_scrollDataArr.count, 0);
        _scroll.pagingEnabled=YES;
        
        //创建导航点
        [self creatPageControl];
    }
    
}

//创建导航点
-(void)creatPageControl{
    _pageControl.numberOfPages = _scrollDataArr.count - 2;

}

#pragma mark 广告页滚动时
- (void)nextPhoto{
    
    [UIView animateWithDuration:0.5 animations:^{
        _scroll.contentOffset = CGPointMake(_scroll.contentOffset.x + _scroll.frame.size.width, 0);
        
    }completion:nil];
}

#pragma mark - 处理scrollView的滑动轮播

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    _pageControl.currentPage = _scroll.contentOffset.x / _scroll.frame.size.width - 1;
    if (_scroll.contentOffset.x == (_scrollDataArr.count - 1) * _scroll.frame.size.width) {
        _scroll.contentOffset = CGPointMake(_scroll.frame.size.width, 0);
    }
    
    if (_scroll.contentOffset.x == 0) {
        _scroll.contentOffset = CGPointMake(_scroll.frame.size.width * (_scrollDataArr.count - 2), 0);
    }
    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [_timer invalidate];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self addTimer];
}
//点击
-(void)adTap:(UITapGestureRecognizer *)tap{


}

@end
