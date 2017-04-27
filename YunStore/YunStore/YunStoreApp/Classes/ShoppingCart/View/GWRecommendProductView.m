//
//  GWRecommendProductView.m
//  YunStoreApp
//
//  Created by apple on 2017/4/21.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import "GWRecommendProductView.h"

@implementation GWRecommendProductView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self setUI];
    }
    
    return self;
}

- (void)setUI {
    
    UIImageView *shopImgView = [[UIImageView alloc] initWithFrame:CGRectMake(28, 11, 124, 124)];
    shopImgView.image = [UIImage imageNamed:@"commodity_2"];
    [self addSubview:shopImgView];
    
    CGFloat shopGoodsLabelY = CGRectGetMaxY(shopImgView.frame) + 8;
    
    UILabel *shopGoodslabel = [[UILabel alloc] initWithFrame:CGRectMake(14.0, shopGoodsLabelY, self.bounds.size.width - 28, 36)];
    shopGoodslabel.numberOfLines = 2.0;
    shopGoodslabel.font = [UIFont systemFontOfSize:14.0f];
    shopGoodslabel.textColor = RGBCOLOR(5, 5, 5);
    shopGoodslabel.text = @"keds旗舰店女鞋 帆布鞋 低帮鞋女 帆布鞋 低帮鞋女 帆布鞋 低帮鞋女";
    [self addSubview:shopGoodslabel];

    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(shopGoodslabel.frame) + 3, self.bounds.size.width, 0.5)];
    lineView.backgroundColor = RGBCOLOR(239, 239, 239);
    [self addSubview:lineView];
    
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(17.0, CGRectGetMaxY(lineView.frame) +  7, 50, 16.0)];
    priceLabel.font = [UIFont systemFontOfSize:14.0];
    priceLabel.textColor = UIColorFromHexValue(0xeb4f21);
    priceLabel.text = @"¥ 968";
    [self addSubview:priceLabel];
    
    UIButton *shopCartBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.bounds.size.width - 35, CGRectGetMaxY(lineView.frame) + 6.5, 22.5, 17)];
    [shopCartBtn setImage:[UIImage imageNamed:@"shopCart_buyCart"] forState:UIControlStateNormal];
    [self addSubview:shopCartBtn];
}

@end
