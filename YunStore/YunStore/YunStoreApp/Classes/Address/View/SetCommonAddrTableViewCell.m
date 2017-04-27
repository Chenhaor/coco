//
//  SetCommonAddrTableViewCell.m
//  YunStoreApp
//
//  Created by apple on 2017/4/27.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import "SetCommonAddrTableViewCell.h"

@interface SetCommonAddrTableViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UISwitch *addressSwitch;
@end

@implementation SetCommonAddrTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{

    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(15, 17, 130, 16)];
    self.titleLabel.font=[UIFont systemFontOfSize:16];
    self.titleLabel.textColor=SECOND_DEGREE_COLOR;
    self.titleLabel.text=@"设为常用地址";
    [self.contentView addSubview:self.titleLabel];
    
    self.addressSwitch=[[UISwitch alloc]initWithFrame:CGRectMake(kScreenWidth-80, 10, 80, 20)];
    [self.contentView addSubview:self.addressSwitch];
    [self.addressSwitch addTarget:self action:@selector(switchClick:) forControlEvents:UIControlEventValueChanged];
    
//    self.contentLabel=[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-35-130, 18, 130, 14)];
//    self.contentLabel.textAlignment=NSTextAlignmentRight;
//    self.contentLabel.font=[UIFont systemFontOfSize:14];
//    self.contentLabel.textColor=THREE_DEGREE_COLOR;
//    self.contentLabel.text=@"YF_dfin45415";
//    [self.contentView addSubview:self.contentLabel];
    
    CALayer *lineLayer=[CALayer layer];
    lineLayer.frame=CGRectMake(0, 49, kScreenWidth, 1);
    lineLayer.backgroundColor=DEFAULT_CUTTINGLINE_COLOR.CGColor;
    [self.contentView.layer addSublayer:lineLayer];
}
-(void)switchClick:(UISwitch *)switchView{
    if (switchView.isOn) {
        NSLog(@"On");
    }else{
        NSLog(@"Off");
    }
}

-(void)switchFlipped{


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
