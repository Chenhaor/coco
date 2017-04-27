//
//  AddressTableViewCell.m
//  YunStoreApp
//
//  Created by apple on 2017/4/27.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import "AddressTableViewCell.h"
@interface AddressTableViewCell ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UILabel *setAddressLabel;
@property (nonatomic, strong) UIButton *defaultButn;
@property (nonatomic, strong) UIButton *deleteButn;
@property (nonatomic, strong) UIButton *editButn;

@property (nonatomic, strong) UISwitch *addressSwitch;
@end

@implementation AddressTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
//    120  75
    self.nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 20, 60, 16)];
    self.nameLabel.textColor=RGBCOLOR(225, 225, 225);
    self.nameLabel.font=[UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.nameLabel];
    self.nameLabel.text=@"张某某";
    
    self.phoneLabel=[[UILabel alloc]initWithFrame:CGRectMake(75, 20, 120, 15)];
    self.phoneLabel.textColor=RGBCOLOR(31, 31, 31);
    self.phoneLabel.font=[UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.phoneLabel];
    self.phoneLabel.text=@"13745566666";
    
    self.addressLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 45, kScreenWidth-30, 15)];
    self.addressLabel.textColor=RGBCOLOR(152, 152, 152);
    self.addressLabel.font=[UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.addressLabel];
    self.addressLabel.text=@"广东省规格规格工商富";
    
    CALayer *layer=[CALayer layer];
    layer.frame=CGRectMake(0, 74, kScreenWidth, 1);
    layer.backgroundColor=DEFAULT_CUTTINGLINE_COLOR.CGColor;
    [self.contentView.layer addSublayer:layer];
    
    self.deleteButn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.deleteButn.frame=CGRectMake(kScreenWidth-52-10, 75+12, 52, 20);
    [self.deleteButn setTitle:@" 删除" forState:UIControlStateNormal];
    [self.deleteButn setTitleColor:SECOND_DEGREE_COLOR forState:UIControlStateNormal];
    self.deleteButn.titleLabel.font=[UIFont systemFontOfSize:15];
    [self.deleteButn setImage:[UIImage imageNamed:@"YF_deleteButn"] forState:UIControlStateNormal];
    self.deleteButn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.contentView addSubview:self.deleteButn];
    
    self.editButn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.editButn.frame=CGRectMake(CGRectGetMinX(self.deleteButn.frame)-52-10, 75+12, 52, 20);
    [self.editButn setTitle:@" 编辑" forState:UIControlStateNormal];
    [self.editButn setTitleColor:SECOND_DEGREE_COLOR forState:UIControlStateNormal];
    self.editButn.titleLabel.font=[UIFont systemFontOfSize:15];
    [self.editButn setImage:[UIImage imageNamed:@"YF_editButn"] forState:UIControlStateNormal];
    self.editButn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.contentView addSubview:self.editButn];
    
    
    self.defaultButn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.defaultButn.frame=CGRectMake(10, 75+2, 85, 40);
    [self.defaultButn setTitle:@" 设为默认" forState:UIControlStateNormal];
    [self.defaultButn setTitleColor:SECOND_DEGREE_COLOR forState:UIControlStateNormal];
    self.defaultButn.titleLabel.font=[UIFont systemFontOfSize:15];
    [self.defaultButn setImage:[UIImage imageNamed:@"YF_setting"] forState:UIControlStateNormal];
        [self.defaultButn setImage:[UIImage imageNamed:@"YF_settingSelect"] forState:UIControlStateSelected];
    self.defaultButn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.defaultButn addTarget:self action:@selector(defaultButnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.defaultButn];

    
    CALayer *bottomLayer=[CALayer layer];
    bottomLayer.frame=CGRectMake(0, 119, kScreenWidth, 1);
    bottomLayer.backgroundColor=DEFAULT_CUTTINGLINE_COLOR.CGColor;
    [self.contentView.layer addSublayer:bottomLayer];
}

-(void)defaultButnClick:(UIButton *)butn{
    butn.selected=!butn.selected;

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
