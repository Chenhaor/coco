//
//  CarouselCollectionViewCell.m
//  YunFuStore
//
//  Created by apple on 2017/4/19.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CarouselCollectionViewCell.h"
#import "CarouselView.h"

@interface CarouselCollectionViewCell ()
@property(nonatomic, strong) CarouselView *carouselView;
@end

@implementation CarouselCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{

    self.carouselView=[[CarouselView alloc]initWithFrame:self.frame];
    [self.contentView addSubview:self.carouselView];
}

-(void)setAdDataArry:(NSMutableArray *)adDataArry{
    _adDataArry=adDataArry;
    self.carouselView.adDataArry=_adDataArry;
}
@end
