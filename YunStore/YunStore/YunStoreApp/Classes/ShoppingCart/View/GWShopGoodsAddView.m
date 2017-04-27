//
//  GWShopGoodsAddView.m
//  YunStoreApp
//
//  Created by apple on 2017/4/21.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import "GWShopGoodsAddView.h"
#import "UIButton+EnlargeEdge.h"

@interface GWShopGoodsAddView()

@property (nonatomic,weak)UILabel *numLabel;

@property (nonatomic,weak)UIButton *minusBtn;

@property (nonatomic,weak)UIButton *addBtn;

@property (nonatomic,assign)NSInteger currentNum;

@property (nonatomic,assign)NSInteger totoalNum;

@end

@implementation GWShopGoodsAddView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initData];
        
        [self setUI];
    }
    
    return self;
}

- (void)initData {
    self.currentNum = 1;
    self.totoalNum = 200;
}

- (void)setUI {
    //54 16.5
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:self.bounds];
    bgImgView.image = [UIImage imageNamed:@"shopCard_addViewBg"];
    [self addSubview:bgImgView];
    
    CGFloat addViewH = self.bounds.size.height;
//    34.0/33.0
    UIButton *minusBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, addViewH)];
    self.minusBtn = minusBtn;
    [self addSubview:minusBtn];
    [minusBtn addTarget:self action:@selector(minusBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self minusBtnNotEnable];
    
    UILabel *numLabel = [[UILabel alloc] initWithFrame:CGRectMake(24, 0, 30.0, addViewH)];
    self.numLabel = numLabel;
    numLabel.textAlignment = NSTextAlignmentCenter;
    numLabel.font = [UIFont systemFontOfSize:12.0];
    numLabel.text = @"1";
    [self addSubview:numLabel];
    
    UIButton *addBtn = [[UIButton alloc] initWithFrame:CGRectMake(54, 0, 24, addViewH)];
    self.addBtn = addBtn;
    [self addSubview:addBtn];
    [addBtn addTarget:self action:@selector(addBtnAction:) forControlEvents:UIControlEventTouchUpInside];

}

- (void)setCurrentNum:(NSInteger)currentNum andTotoalNum:(NSInteger)totoalNum {
    _currentNum = currentNum;
    _totoalNum = totoalNum;

    if (_currentNum == 1) {
        [self minusBtnNotEnable];
    }else {
        [self minusBtnEnable];
    }
    
    if (_currentNum >= totoalNum) {
        [self addBtnNotEnable];
    }else {
        [self addBtnEnable];
    }
    [self updateNumLabelValue];
}

- (void)minusBtnNotEnable
{
    self.minusBtn.enabled = NO;
    [self.minusBtn setBackgroundImage:[UIImage imageNamed:@"shopCard_minus_0"] forState:UIControlStateNormal];
}

- (void)minusBtnEnable
{
    self.minusBtn.enabled = YES;
    [self.minusBtn setBackgroundImage:[UIImage imageNamed:@"shopCard_minus_1"] forState:UIControlStateNormal];
}

- (void)addBtnNotEnable
{
    self.addBtn.enabled = NO;
    [self.addBtn setBackgroundImage:[UIImage imageNamed:@"shopCard_add_0"] forState:UIControlStateNormal];
}

- (void)addBtnEnable
{
    self.addBtn.enabled = YES;
    [self.addBtn setBackgroundImage:[UIImage imageNamed:@"shopCard_add_1"] forState:UIControlStateNormal];
}

- (void)updateNumLabelValue {
    self.numLabel.text = [NSString stringWithFormat:@"%zd",self.currentNum];
}

- (void)minusBtnAction:(UIButton *)minusBtn {
    if (self.currentNum == self.totoalNum) {
        [self addBtnEnable];
    }
    
    self.currentNum --;
    
    if (self.currentNum == 1) {
        [self minusBtnNotEnable];
    }
    
    [self updateNumLabelValue];
}

- (void)addBtnAction:(UIButton *)addBtn {
    if (self.currentNum == 1) {
        [self minusBtnEnable];
    }
    self.currentNum ++;
    
    if (self.currentNum == self.totoalNum) {
        [self addBtnNotEnable];
    }
    
    [self updateNumLabelValue];
}

@end
