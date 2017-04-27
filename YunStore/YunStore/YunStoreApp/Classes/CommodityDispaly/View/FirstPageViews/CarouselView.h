//
//  CarouselView.h
//  YunFuStore
//
//  Created by apple on 2017/4/19.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YFPageControl.h"

@interface CarouselView : UIView


@property(nonatomic, strong) UIScrollView *scroll;
@property(nonatomic, strong) NSMutableArray *adDataArry;
@property(nonatomic, strong) YFPageControl *pageControl;
@end
