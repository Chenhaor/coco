//
//  HeadPortraitTableViewCell.m
//  YunStoreApp
//
//  Created by apple on 2017/4/26.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import "HeadPortraitTableViewCell.h"
@interface HeadPortraitTableViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *headPortraitImageView;

@end
@implementation HeadPortraitTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.selectionStyle=UITableViewCellSelectionStyleNone;

    self.titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(15, 40, 120, 19)];
    self.titleLabel.font=[UIFont systemFontOfSize:19];
    self.titleLabel.textColor=SECOND_DEGREE_COLOR;
    self.titleLabel.text=@"头像";
    [self.contentView addSubview:self.titleLabel];
    
    
    self.headPortraitImageView=[[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-35-45, 25, 50, 50)];
    self.headPortraitImageView.image=[UIImage imageNamed:@"YF_headPortrait"];
    [self.headPortraitImageView.layer setCornerRadius:5];
    [self.headPortraitImageView.layer setMasksToBounds:YES];
    [self.contentView addSubview:self.headPortraitImageView];

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
