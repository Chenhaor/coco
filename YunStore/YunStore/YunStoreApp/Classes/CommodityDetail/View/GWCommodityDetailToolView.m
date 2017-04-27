//
//  GWCommodityDetailToolView.m
//  YunStoreApp
//
//  Created by apple on 2017/4/25.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import "GWCommodityDetailToolView.h"
#import "GWCustomButton.h"

@implementation GWCommodityDetailToolView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self) {
        [self setUI];
    }
    
    return self;
}

- (void)setUI {
    CGFloat btnW = self.bounds.size.width / 6.0;
    CGFloat btnH = self.bounds.size.height;
    //供应商
    GWCustomButton *supplierBtn = [self createCustomBtnWithFrame:CGRectMake(0, 0, btnW, btnH)
                                                        btnTitle:@"供应商"
                                                   normalImgName:@"commodityDetail_supplier"
                                                 selectedImgName:nil];
    [self addSubview:supplierBtn];
    [supplierBtn addTarget:self action:@selector(supplierBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    //店铺
    GWCustomButton *shopBtn = [self createCustomBtnWithFrame:CGRectMake(btnW, 0, btnW, btnH)
                                                    btnTitle:@"店铺"
                                             normalImgName:@"commodityDetail_shop"
                                           selectedImgName:nil];
    [self addSubview:shopBtn];
    [shopBtn addTarget:self action:@selector(shopBtnAction:) forControlEvents:UIControlEventTouchUpInside];

    //关注
    GWCustomButton *attentionBtn = [self createCustomBtnWithFrame:CGRectMake(0, 0, btnW, btnH)
                                                         btnTitle:@"关注"
                                                    normalImgName:@"commodityDetail_attention_unselect"
                                                  selectedImgName:@"commodityDetail_attention_select"];
    attentionBtn.frame = CGRectMake(2 * btnW, 0, btnW, btnH);
    [self addSubview:attentionBtn];
    [attentionBtn addTarget:self action:@selector(attentionBtnAction:) forControlEvents:UIControlEventTouchUpInside];

    //购物车
    GWCustomButton *shopCartBtn = [self createCustomBtnWithFrame:CGRectMake(3 *btnW, 0, btnW, btnH)
                                                        btnTitle:@"购物车"
                                                   normalImgName:@"commodityDetail_shopCart"
                                                 selectedImgName:nil];
    [self addSubview:shopCartBtn];
    [shopCartBtn addTarget:self action:@selector(shopCartBtnAction:) forControlEvents:UIControlEventTouchUpInside];

    //加入购物车
    UIButton *addShopCartBtn = [[UIButton alloc] init];
    addShopCartBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
    addShopCartBtn.backgroundColor = RGBCOLOR(232, 80, 45);
    [addShopCartBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    [addShopCartBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addShopCartBtn.frame = CGRectMake(4 * btnW, 0, btnW * 2, btnH);
    [self addSubview:addShopCartBtn];
    [addShopCartBtn addTarget:self action:@selector(addShopCartBtnAction:) forControlEvents:UIControlEventTouchUpInside];

}

- (GWCustomButton *)createCustomBtnWithFrame:(CGRect)frame
                                     btnTitle:(NSString *)title
                             normalImgName:(NSString *)normalImgName
                           selectedImgName:(NSString *)selectedImgName
{
    GWCustomButton *btn = [[GWCustomButton alloc] init];
    btn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [btn setTitleColor:RGBCOLOR(120, 120, 120) forState:UIControlStateNormal];
    btn.frame = frame;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:normalImgName] forState:UIControlStateNormal];
    if (selectedImgName && selectedImgName.length > 0) {
        [btn setImage:[UIImage imageNamed:selectedImgName] forState:UIControlStateSelected];
    }
    return btn;
}

#pragma mark btnAction

- (void)supplierBtnAction:(UIButton *)btn {
    
}

- (void)shopBtnAction:(UIButton *)btn {
    
}

- (void)attentionBtnAction:(UIButton *)btn {
    btn.selected = !btn.selected;
}

- (void)shopCartBtnAction:(UIButton *)btn {
    
}

- (void)addShopCartBtnAction:(UIButton *)btn {
    
}

@end
