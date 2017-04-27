//
//  FrontPageView.m
//  YunFuStore
//
//  Created by apple on 2017/4/19.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "FrontPageView.h"
@interface FrontPageView ()

@property(nonatomic, strong)UILabel *upTitleLabel;
@property(nonatomic, strong)UILabel *upDetailabel;

@property(nonatomic, strong)UILabel *downTitleLabel;
@property(nonatomic, strong)UILabel *downDetailabel;
@end
@implementation FrontPageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{

    self.upTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(7, 15, 40, 12)];
    [self.upTitleLabel.layer setCornerRadius:3];
    [self.upTitleLabel.layer setMasksToBounds:YES];
    self.upTitleLabel.textAlignment=NSTextAlignmentCenter;
    self.upTitleLabel.backgroundColor=UIColorFromHexValue(0xea4a73);
    self.upTitleLabel.text=@"限时抢";
    self.upTitleLabel.textColor=[UIColor whiteColor];
    self.upTitleLabel.font=[UIFont systemFontOfSize:12];
    [self addSubview:self.upTitleLabel];
    
    self.downTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(7, 27+6, 40, 12)];
    [self.downTitleLabel.layer setCornerRadius:3];
    [self.downTitleLabel.layer setMasksToBounds:YES];
    self.downTitleLabel.textAlignment=NSTextAlignmentCenter;
    self.downTitleLabel.backgroundColor=UIColorFromHexValue(0xea4a73);
    self.downTitleLabel.textColor=[UIColor whiteColor];
    self.downTitleLabel.font=[UIFont systemFontOfSize:12];
    self.downTitleLabel.text=@"爆 款";
    [self addSubview:self.downTitleLabel];
    
    
    self.upDetailabel=[[UILabel alloc]initWithFrame:CGRectMake(50, 14, self.frame.size.width-100, 14)];
    self.upDetailabel.font=[UIFont systemFontOfSize:14];
    self.upDetailabel.text=@"华润电脑品牌日，买100送10";
    [self addSubview:self.upDetailabel];
    
    self.upDetailabel=[[UILabel alloc]initWithFrame:CGRectMake(50, 28+4, self.frame.size.width-100, 14)];
    self.upDetailabel.font=[UIFont systemFontOfSize:14];
    self.upDetailabel.text=@"爆款华润电脑品牌日，买100送10";
    [self addSubview:self.upDetailabel];
}


-(void)setModel:(FrontPageModel *)model{
    _model=model;
    
    self.upTitleLabel.text=_model.upTitleStr;
    self.downDetailabel.text=_model.downDetailStr;
    self.upDetailabel.text=_model.upDetailStr;
    self.downTitleLabel.text=_model.downTitleStr;
}

@end
