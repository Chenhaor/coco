//
//  CommodityDetailTableViewCell.m
//  YunStoreApp
//
//  Created by apple on 2017/4/25.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import "CommodityDetailTableViewCell.h"

@interface CommodityDetailTableViewCell ()

@property(nonatomic, strong)UIImageView *commodityImageView;
@property(nonatomic, strong)UILabel *introduceLabel;
@property(nonatomic, strong)UILabel *priceLabel;
@property(nonatomic, strong)UILabel *evaluateLabel;
@end

@implementation CommodityDetailTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
//    110
    self.commodityImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 10, 90, 90)];
    self.commodityImageView.image=[UIImage imageNamed:@"commodity_1"];
    [self.contentView addSubview:self.commodityImageView];
    
    self.introduceLabel=[[UILabel alloc]initWithFrame:CGRectMake(100, 10, kScreenWidth-120, 32)];
    self.introduceLabel.font=[UIFont systemFontOfSize:14];
    self.introduceLabel.numberOfLines=0;
    self.introduceLabel.textColor=RGBCOLOR(100, 100, 100);
    [self.contentView addSubview:self.introduceLabel];
    self.introduceLabel.text=@"Xiaomi/小米4官方旗舰店5寸移动联通电信全网通智能4G手机";
    
    self.priceLabel=[[UILabel alloc]initWithFrame:CGRectMake(100, 60, 120, 15)];
    self.priceLabel.textColor=RGBCOLOR(233, 69, 0);
    self.priceLabel.font=[UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.priceLabel];
    self.priceLabel.text=@"￥968";
    
    self.evaluateLabel=[[UILabel alloc]initWithFrame:CGRectMake(100, CGRectGetMaxY(self.priceLabel.frame)+10, kScreenWidth-150, 12)];
    self.evaluateLabel.font=[UIFont systemFontOfSize:12];
    self.evaluateLabel.textColor=RGBCOLOR(157, 157, 157);
    [self.contentView addSubview:self.evaluateLabel];
    self.evaluateLabel.text=@"23947条评论  99%好评";
    
    CALayer *layer=[CALayer layer];
    layer.frame=CGRectMake(100, 109, kScreenWidth-100, 1);
    layer.backgroundColor=DEFAULT_CUTTINGLINE_COLOR.CGColor;
    [self.contentView.layer addSublayer:layer];
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
