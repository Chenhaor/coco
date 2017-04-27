//
//  GWEvaluateTableViewCell.m
//  YunStoreApp
//
//  Created by apple on 2017/4/25.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import "GWEvaluateTableViewCell.h"
@interface GWEvaluateTableViewCell ()

@property(nonatomic, strong)UILabel *evaluateLabel;
@property(nonatomic, strong)UILabel *numLabel;
@property(nonatomic, strong)UILabel *reputablyNumLabel;
@property(nonatomic, strong)UILabel *reputablyLabel;
@property(nonatomic, strong)UIButton *moreButn;
@end

@implementation GWEvaluateTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.selectionStyle=UITableViewCellSelectionStyleNone;

    self.evaluateLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 58, 14)];
    self.evaluateLabel.font=[UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.evaluateLabel];
    self.evaluateLabel.text=@"商品评价";
    
    self.numLabel=[[UILabel alloc]initWithFrame:CGRectMake(72, 12, 150, 12)];
    self.numLabel.font=[UIFont systemFontOfSize:12];
    self.numLabel.textColor=RGBCOLOR(159, 159, 159);
    [self.contentView addSubview:self.numLabel];
    self.numLabel.text=@"(456)";
    
    self.moreButn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.moreButn.frame=CGRectMake(kScreenWidth-20-15, 13, 17, 3);
    [self.moreButn setImage:[UIImage imageNamed:@"yf_more"] forState:UIControlStateNormal];
//    [self.moreButn addTarget:self action:@selector(moreButnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.moreButn];
    
    self.reputablyLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMidX(self.moreButn.frame)-28-10, 12, 28, 12)];
    self.reputablyLabel.font=[UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.reputablyLabel];
    self.reputablyLabel.text=@"好评";
    
    self.reputablyNumLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMidX(self.reputablyLabel.frame)-60-2, 12, 60, 12)];
    self.reputablyNumLabel.font=[UIFont systemFontOfSize:12];
    self.reputablyNumLabel.textColor=RGBCOLOR(233, 60, 0);
    self.reputablyNumLabel.textAlignment=NSTextAlignmentCenter;
    [self.contentView addSubview:self.reputablyNumLabel];
    self.reputablyNumLabel.text=@"99%";
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
