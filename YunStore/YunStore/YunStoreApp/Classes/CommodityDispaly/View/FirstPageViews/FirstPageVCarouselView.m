//
//  FirstPageVCarouselView.m
//  YunFuStore
//
//  Created by apple on 2017/4/19.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "FirstPageVCarouselView.h"
#import "FrontPageView.h"

#import "FrontPageModel.h"

@interface FirstPageVCarouselView ()

@end

@implementation FirstPageVCarouselView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}


-(void)setAdDataArry:(NSMutableArray *)adDataArry{
    [super setAdDataArry:adDataArry];
    //处理好前后各加一张
    [adDataArry addObject:[adDataArry firstObject]];
    //0 1 2 3 4
    [adDataArry insertObject:adDataArry[adDataArry.count - 2] atIndex:0];
    for (UIView *view in self.scroll.subviews) {
        [view removeFromSuperview];
    }
    for (int i=0; i<adDataArry.count; i++) {
        FrontPageView *fronView = [[FrontPageView alloc] initWithFrame:CGRectMake(0, i * self.scroll.frame.size.height, self.scroll.frame.size.width, self.frame.size.height)];
        FrontPageModel *model=adDataArry[i];
        fronView.model=model;
        [self.scroll addSubview:fronView];
    }
    self.scroll.contentSize=CGSizeMake(0, self.scroll.frame.size.height*adDataArry.count);
    self.scroll.pagingEnabled=YES;
}

@end
