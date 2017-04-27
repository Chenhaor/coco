//
//  commodityGridView.m
//  YunStoreApp
//
//  Created by apple on 2017/4/26.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import "GWCommodityGridView.h"

@interface GWCommodityGridView ()

@property(nonatomic, strong)UIImageView *commodityImageView;
@property(nonatomic, strong)UILabel *introduceLabel;
@property(nonatomic, strong)UILabel *priceLabel;
@property(nonatomic, strong)UILabel *evaluateLabel;
@end
@implementation GWCommodityGridView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    //    230
    self.backgroundColor=[UIColor whiteColor];
    
    self.commodityImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 145)];
    self.commodityImageView.image=[UIImage imageNamed:@"commodity_1"];
    [self addSubview:self.commodityImageView];
    
    self.introduceLabel=[[UILabel alloc]initWithFrame:CGRectMake(12, 145+8, self.frame.size.width-24, 13)];
    self.introduceLabel.font=[UIFont systemFontOfSize:13];
    self.introduceLabel.numberOfLines=0;
    self.introduceLabel.textColor=RGBCOLOR(100, 100, 100);
    [self addSubview:self.introduceLabel];
    self.introduceLabel.text=@"Xiaomi/小米4官方旗舰店5寸移动联通电信全网通智能4G手机";
    
    self.priceLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.introduceLabel.frame)+18, self.frame.size.width-20, 12)];
    self.priceLabel.textColor=RGBCOLOR(233, 69, 0);
    self.priceLabel.font=[UIFont systemFontOfSize:12];
    [self addSubview:self.priceLabel];
    self.priceLabel.text=@"￥968";
    
    self.evaluateLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.priceLabel.frame)+10, self.frame.size.width-20, 11)];
    self.evaluateLabel.font=[UIFont systemFontOfSize:10];
    self.evaluateLabel.textColor=RGBCOLOR(157, 157, 157);
    [self addSubview:self.evaluateLabel];
    self.evaluateLabel.text=@"23947条评论  99%好评";
    
//    CALayer *layer=[CALayer layer];
//    layer.frame=CGRectMake(100, 109, kScreenWidth-100, 1);
//    layer.backgroundColor=DEFAULT_CUTTINGLINE_COLOR.CGColor;
//    [self.layer addSublayer:layer];
}

@end
