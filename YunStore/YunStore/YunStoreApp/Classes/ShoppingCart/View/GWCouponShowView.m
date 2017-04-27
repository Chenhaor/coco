//
//  GWCouponShowView.m
//  YunStoreApp
//
//  Created by apple on 2017/4/21.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import "GWCouponShowView.h"

@implementation GWCouponShowView

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
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.alertViewW - 60)/2.0, 22, 60, 20)];
    titleLabel.font = [UIFont systemFontOfSize:18.0];
    titleLabel.text = @"优惠券";
    titleLabel.textColor = RGBCOLOR(172, 172, 172);
    [self addSubview:titleLabel];
    
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.alertViewW - 40, 10, 28.5, 28.5)];
    [closeBtn setImage:[UIImage imageNamed:@"shopCart_coupon_close"] forState:UIControlStateNormal];
    [self addSubview:closeBtn];
    [closeBtn addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 66, self.alertViewW, 0.5)];
    lineView.backgroundColor = RGBCOLOR(239, 239, 239);
    [self addSubview:lineView];
    
    UILabel *noteLabel = [[UILabel alloc] initWithFrame:CGRectMake(14, CGRectGetMaxY(lineView.frame) + 10, 60, 16)];
    noteLabel.font = [UIFont systemFontOfSize:14.0];
    noteLabel.text = @"可领取";
    noteLabel.textColor = RGBCOLOR(5, 5, 5);
    [self addSubview:noteLabel];
    
    UIImageView *couponImgView_10 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, self.alertViewW, 103)];
    couponImgView_10.image = [UIImage imageNamed:@"shopCart_coupon_10"];
    [self addSubview:couponImgView_10];
    
    UIImageView *couponImgView_20 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 213, self.alertViewW, 103)];
    couponImgView_20.image = [UIImage imageNamed:@"shopCart_coupon_20"];
    [self addSubview:couponImgView_20];
    
    
    UIButton *confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.alertViewH - 50.0, self.alertViewW, 50)];
    [confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    confirmBtn.backgroundColor = RGBCOLOR(232, 80, 45);
    [self addSubview:confirmBtn];
    
    [confirmBtn addTarget:self action:@selector(confirmBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)closeAction:(UIButton *)closeBtn {
    [self dismissAlert];
}

- (void)confirmBtnAction:(UIButton *)btn {
    
}


@end
