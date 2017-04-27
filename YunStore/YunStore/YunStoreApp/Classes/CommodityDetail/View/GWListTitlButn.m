//
//  GWListTitlButn.m
//  YunStoreApp
//
//  Created by apple on 2017/4/25.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import "GWListTitlButn.h"

@implementation GWListTitlButn

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    NSArray *array=@[@"综合",@"销量",@"价格"];
    NSArray *selectArray=@[@"综合 ▼",@"销量 ▼",@"价格 ▼"];
    for (int a=0; a<array.count; a++) {
        UIButton *butn=[UIButton buttonWithType:UIButtonTypeCustom];
        [butn setTitle:array[a] forState:UIControlStateNormal];
        [butn setTitle:selectArray[a] forState:UIControlStateSelected];
        [butn setTitleColor:SECOND_DEGREE_COLOR forState:UIControlStateNormal];
        [butn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        butn.tag=1200+a;
        butn.titleLabel.font=[UIFont systemFontOfSize:16];
        [butn addTarget:self action:@selector(butnClick:) forControlEvents:UIControlEventTouchUpInside];
        butn.frame=CGRectMake(kScreenWidth/3*a, 0, kScreenWidth/3, 34);
        [self addSubview:butn];
    }
    
    CALayer *topLayer=[CALayer layer];
    topLayer.frame=CGRectMake(0, 0, kScreenWidth, 1);
    topLayer.backgroundColor=DEFAULT_CUTTINGLINE_COLOR.CGColor;
    [self.layer addSublayer:topLayer];
    
    CALayer *bottomLayer=[CALayer layer];
    bottomLayer.frame=CGRectMake(0, 33, kScreenWidth, 1);
    bottomLayer.backgroundColor=DEFAULT_CUTTINGLINE_COLOR.CGColor;
    [self.layer addSublayer:bottomLayer];
    
    CALayer *oneLayer=[CALayer layer];
    oneLayer.frame=CGRectMake(kScreenWidth/3-1, 0, 1, 33);
    oneLayer.backgroundColor=DEFAULT_CUTTINGLINE_COLOR.CGColor;
    [self.layer addSublayer:oneLayer];
    
    CALayer *twoLayer=[CALayer layer];
    twoLayer.frame=CGRectMake(kScreenWidth/3*2-1, 0, 1, 33);
    twoLayer.backgroundColor=DEFAULT_CUTTINGLINE_COLOR.CGColor;
    [self.layer addSublayer:twoLayer];
}

-(void)butnClick:(UIButton *)btn{
    for (int a=0; a<3; a++) {
        UIButton *button=[self viewWithTag:1200+a];
        if (btn.tag-1200==a) {
            button.selected=YES;
        }else{
            button.selected=NO;
        }
    }
    
}

@end
