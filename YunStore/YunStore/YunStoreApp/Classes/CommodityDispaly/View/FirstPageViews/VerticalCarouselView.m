//
//  VerticalCarouselView.m
//  YunFuStore
//
//  Created by apple on 2017/4/19.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "VerticalCarouselView.h"

@interface VerticalCarouselView ()<UIScrollViewDelegate>

@end

@implementation VerticalCarouselView{
    
    NSTimer *_timer;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addTimer];
        [self createScroll];
    }
    return self;
}

-(void)addTimer{
    _timer=[NSTimer scheduledTimerWithTimeInterval:2.5f target:self selector:@selector(nextPhoto) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

-(void)createScroll{
    _scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _scroll.delegate=self;
    _scroll.showsVerticalScrollIndicator=NO;
    [self addSubview:_scroll];
    
    _scroll.contentOffset = CGPointMake(0, _scroll.frame.size.height);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    _scroll.userInteractionEnabled=YES;
    [_scroll addGestureRecognizer:tap];
}

-(void)setAdDataArry:(NSMutableArray *)adDataArry{
    _adDataArry=adDataArry;
}

#pragma mark 广告页滚动时
- (void)nextPhoto{
    
    [UIView animateWithDuration:0.5 animations:^{
        _scroll.contentOffset = CGPointMake(0, _scroll.contentOffset.y + _scroll.frame.size.height);
        
    }completion:nil];
}

#pragma mark - 处理scrollView的滑动轮播

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    if (_scroll.contentOffset.y == (_adDataArry.count - 1) * _scroll.frame.size.height) {
        _scroll.contentOffset = CGPointMake(0, _scroll.frame.size.height);
    }
    
    if (_scroll.contentOffset.y == 0) {
        _scroll.contentOffset = CGPointMake(0, _scroll.frame.size.height * (_adDataArry.count - 2));
    }
    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [_timer invalidate];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self addTimer];
}


-(void)tapClick:(UITapGestureRecognizer *)tap{
    
    
}


@end
