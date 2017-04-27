//
//  PersonalTableViewCell.m
//  YunStoreApp
//
//  Created by apple on 2017/4/26.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import "PersonalTableViewCell.h"
@interface PersonalTableViewCell ()


@end
@implementation PersonalTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    //50
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(15, 17, 130, 16)];
    self.titleLabel.font=[UIFont systemFontOfSize:16];
    self.titleLabel.textColor=SECOND_DEGREE_COLOR;
    self.titleLabel.text=@"用户名";
    [self.contentView addSubview:self.titleLabel];
    
    self.contentLabel=[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-35-130, 18, 130, 14)];
    self.contentLabel.textAlignment=NSTextAlignmentRight;
    self.contentLabel.font=[UIFont systemFontOfSize:14];
    self.contentLabel.textColor=THREE_DEGREE_COLOR;
    self.contentLabel.text=@"YF_dfin45415";
    [self.contentView addSubview:self.contentLabel];
    
    CALayer *lineLayer=[CALayer layer];
    lineLayer.frame=CGRectMake(0, 49, kScreenWidth, 1);
    lineLayer.backgroundColor=DEFAULT_CUTTINGLINE_COLOR.CGColor;
    [self.contentView.layer addSublayer:lineLayer];
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
