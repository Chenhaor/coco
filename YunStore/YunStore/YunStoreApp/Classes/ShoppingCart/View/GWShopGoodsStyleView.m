//
//  GWShopGoodsStyleView.m
//  YunStoreApp
//
//  Created by apple on 2017/4/21.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import "GWShopGoodsStyleView.h"

@implementation GWShopGoodsStyleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self initData];
        
        [self setUI];
    }
    
    return self;
}

- (void)initData {
    self.popStyle = Style_PopFromBottom;
    self.alertViewW = self.bounds.size.width;
    self.alertViewH = self.bounds.size.height;
    
    self.locationY = kScreenHeight - self.alertViewH;
}

- (void)setUI{
    UIImageView *shopGoodsImgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, -15, 77, 77)];
    shopGoodsImgView.clipsToBounds = YES;
    shopGoodsImgView.layer.cornerRadius = 5.0;
    shopGoodsImgView.image = [UIImage imageNamed:@"commodity_1"];
    [self addSubview:shopGoodsImgView];

    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(shopGoodsImgView.frame) + 19, 18, 50, 17)];
    priceLabel.font = [UIFont systemFontOfSize:16.0];
    priceLabel.textColor = UIColorFromHexValue(0xeb4f21);
    priceLabel.text = @"¥968";
    [self addSubview:priceLabel];
    
    UILabel *shopGoodsNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(priceLabel.frame), CGRectGetMaxY(priceLabel.frame) + 4 , 150, 17)];
    shopGoodsNumLabel.font = [UIFont systemFontOfSize:12.0];
    shopGoodsNumLabel.textColor = RGBCOLOR(172, 172, 172);
    shopGoodsNumLabel.text = @"商品编号：56845987";
    [self addSubview:shopGoodsNumLabel];
    
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.alertViewW - 40, 10, 28.5, 28.5)];
    [closeBtn setImage:[UIImage imageNamed:@"shopCart_coupon_close"] forState:UIControlStateNormal];
    [self addSubview:closeBtn];
    [closeBtn addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 66, self.alertViewW, 0.5)];
    lineView.backgroundColor = RGBCOLOR(239, 239, 239);
    [self addSubview:lineView];
    
    UILabel *colorNoteLabel = [[UILabel alloc] initWithFrame:CGRectMake(14, CGRectGetMaxY(lineView.frame) + 10, 60, 16)];
    colorNoteLabel.font = [UIFont systemFontOfSize:14.0];
    colorNoteLabel.text = @"颜色";
    colorNoteLabel.textColor = RGBCOLOR(172, 172, 172);
    [self addSubview:colorNoteLabel];
    
    CGFloat selectBtnW = 70.5;
    CGFloat selectBtnH = 34.5;
    CGFloat padding = (kScreenWidth - 4 * selectBtnW)/5.0;
    
    CGFloat colorBtnX = 0.0;
    CGFloat colorBtnY = 0.0;
    
    NSArray *colorArr = @[@"黑色",@"红色",@"深蓝色",@"绿色",@"紫色",@"大红色",@"橙色"];
    for (int i = 0; i < 7; i ++) {
        colorBtnX = padding + (i % 4) * (padding + selectBtnW);
        colorBtnY = 107.0 + (i / 4) * (5 + selectBtnH);
        UIButton *colorBtn = [[UIButton alloc] initWithFrame:CGRectMake(colorBtnX, colorBtnY, selectBtnW, selectBtnH)];
        colorBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [colorBtn setTitle:colorArr[i] forState:UIControlStateNormal];
        [colorBtn setTitleColor:RGBCOLOR(104, 104, 104) forState:UIControlStateNormal];
        [colorBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [colorBtn setBackgroundImage:[UIImage imageNamed:@"shopCart_style_unselect"] forState:UIControlStateNormal];
        [colorBtn setBackgroundImage:[UIImage imageNamed:@"shopCart_style_select"] forState:UIControlStateSelected];
        [self addSubview:colorBtn];
        [colorBtn addTarget:self action:@selector(colorBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UILabel *sizeNoteLabel = [[UILabel alloc] initWithFrame:CGRectMake(14, CGRectGetMaxY(lineView.frame) + 129, 60, 16)];
    sizeNoteLabel.font = [UIFont systemFontOfSize:14.0];
    sizeNoteLabel.text = @"尺寸";
    sizeNoteLabel.textColor = RGBCOLOR(172, 172, 172);
    [self addSubview:sizeNoteLabel];
    
    CGFloat sizeBtnX = 0.0;
    CGFloat sizeBtnY = 0.0;
    NSArray *sizeArr = @[@"38码",@"39",@"40",@"41",@"42",@"43",@"44"];

    for (int i = 0; i < 7; i ++) {
        sizeBtnX = padding + ( i % 4) * (padding + selectBtnW);
        sizeBtnY = CGRectGetMaxY(sizeNoteLabel.frame) +10.0 + (i / 4) * (5 + selectBtnH);
        UIButton *sizeBtn = [[UIButton alloc] initWithFrame:CGRectMake(sizeBtnX, sizeBtnY, selectBtnW, selectBtnH)];
        [sizeBtn setTitle:sizeArr[i] forState:UIControlStateNormal];
        [sizeBtn setTitleColor:RGBCOLOR(104, 104, 104) forState:UIControlStateNormal];
        [sizeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [sizeBtn setBackgroundImage:[UIImage imageNamed:@"shopCart_style_unselect"] forState:UIControlStateNormal];
        [sizeBtn setBackgroundImage:[UIImage imageNamed:@"shopCart_style_select"] forState:UIControlStateSelected];
        [self addSubview:sizeBtn];
        [sizeBtn addTarget:self action:@selector(sizeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    UIButton *confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.alertViewH - 50.0, self.alertViewW, 50)];
    [confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    confirmBtn.backgroundColor = RGBCOLOR(232, 80, 45);
    [self addSubview:confirmBtn];
    
    [confirmBtn addTarget:self action:@selector(confirmBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)colorBtnAction:(UIButton *)btn {
    btn.selected = !btn.selected;
}

- (void)sizeBtnAction:(UIButton *)btn {
    btn.selected = !btn.selected;
}

- (void)closeAction:(UIButton *)closeBtn {
    [self dismissAlert];
}

- (void)confirmBtnAction:(UIButton *)btn {
    
}

@end
