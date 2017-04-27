//
//  FrontPageCollectionViewCell.m
//  YunFuStore
//
//  Created by apple on 2017/4/19.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "FrontPageCollectionViewCell.h"
#import "FirstPageVCarouselView.h"

@interface FrontPageCollectionViewCell ()

@property(nonatomic, strong)UIImageView *frontImageView;
@property(nonatomic, strong)FirstPageVCarouselView *carouselView;
@end

@implementation FrontPageCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{

    self.contentView.backgroundColor=[UIColor whiteColor];
    CALayer *intervallayer=[CALayer layer];
    intervallayer.frame=CGRectMake(0, 0, kScreenWidth, 1);
    intervallayer.backgroundColor=DEFAULT_BACKGROUND_COLOR.CGColor;
    [self.contentView.layer addSublayer:intervallayer];
    
    _frontImageView=[[UIImageView alloc]initWithFrame:CGRectMake(15, 12, self.frame.size.height-25, self.frame.size.height-25)];
    _frontImageView.image=[UIImage imageNamed:@"yunFuFrontPage"];
    _frontImageView.contentMode=UIViewContentModeScaleToFill;
    [self.contentView addSubview:_frontImageView];
    
    CALayer *linelayer=[CALayer layer];
    linelayer.frame=CGRectMake(self.frame.size.height-1, 15, 1, self.frame.size.height-30);
    linelayer.backgroundColor=RGBCOLOR(232, 232, 232).CGColor;
    [self.contentView.layer addSublayer:linelayer];
    
    self.carouselView=[[FirstPageVCarouselView alloc]initWithFrame:CGRectMake(self.frame.size.height, 1, kScreenWidth-self.frame.size.height, self.frame.size.height-1)];
    [self.contentView addSubview:self.carouselView];
    
}

-(void)setAdDataArry:(NSMutableArray *)adDataArry{
    _adDataArry=adDataArry;
    self.carouselView.adDataArry=_adDataArry;
}
@end

