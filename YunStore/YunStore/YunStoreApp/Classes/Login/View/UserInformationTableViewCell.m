//
//  UserInformationTableViewCell.m
//  YunStoreApp
//
//  Created by apple on 2017/4/26.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import "UserInformationTableViewCell.h"
@interface UserInformationTableViewCell ()

@property (nonatomic, strong) UIImageView *headPortraitImageView;
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UILabel *nameDetailsLabel;

@end

@implementation UserInformationTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.selectionStyle=UITableViewCellSelectionStyleNone;

    self.headPortraitImageView=[[UIImageView alloc]initWithFrame:CGRectMake(15, 25, 50, 50)];
    self.headPortraitImageView.image=[UIImage imageNamed:@"YF_headPortrait"];
    [self.headPortraitImageView.layer setCornerRadius:5];
    [self.headPortraitImageView.layer setMasksToBounds:YES];
    [self.contentView addSubview:self.headPortraitImageView];

    self.userNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.headPortraitImageView.frame)+10, CGRectGetMinY(self.headPortraitImageView.frame), 180, 18)];
    self.userNameLabel.font=[UIFont systemFontOfSize:18];
    self.userNameLabel.text=@"YF-shangzh123";
    self.userNameLabel.textColor=FIRST_DEGREE_COLOR;
    [self.contentView addSubview:self.userNameLabel];

    self.nameDetailsLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.headPortraitImageView.frame)+10, CGRectGetMaxY(self.userNameLabel.frame)+10, 130, 16)];
    self.nameDetailsLabel.font=[UIFont systemFontOfSize:16];
    self.nameDetailsLabel.textColor=FIRST_DEGREE_COLOR;
    [self.contentView addSubview:self.nameDetailsLabel];
    self.nameDetailsLabel.text=@"用户名：YF-shangzh123";
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
