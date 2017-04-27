//
//  MineHeadView.m
//  YunFuStore
//
//  Created by apple on 2017/4/12.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "MineHeadView.h"
#import "LoginViewController.h"
#import "PersonalViewController.h"

@interface MineHeadView ()

@property(nonatomic, strong) UIImageView *userImageView;
@property(nonatomic, strong) UILabel *userNameLabel;

@end
@implementation MineHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createHeadViewUI];
    }
    return self;
}

-(void)createHeadViewUI{
    
    UIImageView *backgroundView=[[UIImageView alloc]initWithFrame:self.bounds];
    backgroundView.image=[UIImage imageNamed:@"me_headBack"];
    backgroundView.backgroundColor=[UIColor whiteColor];
    [self addSubview:backgroundView];
    
    self.userImageView=[[UIImageView alloc]init];
    self.userImageView.backgroundColor=[UIColor whiteColor];
    [self addSubview:self.userImageView];
    [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self).offset(20);
        make.left.equalTo(self.mas_left).offset(15);
        make.size.mas_offset(CGSizeMake(60, 60));
    }];
    [self.userImageView.layer setCornerRadius:8];
    self.userImageView.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
    [self.userImageView addGestureRecognizer:tap];
    
    
    self.userNameLabel=[[UILabel alloc]init];
    self.userNameLabel.text=@"YF_6177216";
    [self addSubview:self.userNameLabel];
    self.userNameLabel.font=[UIFont systemFontOfSize:17];
    self.userNameLabel.textColor=RGBCOLOR(225, 225, 225);
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userImageView.mas_right).offset(10);
        make.top.equalTo(self.userImageView.mas_top).offset(5);
        make.size.mas_offset(CGSizeMake(kScreenWidth/3, 20));
    }];
    
    self.registerButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.registerButton setTitle:@"会员注册" forState:UIControlStateNormal];
    self.registerButton.titleLabel.font=[UIFont systemFontOfSize:14];
    self.registerButton.titleLabel.textColor=RGBCOLOR(225, 225, 225);
    [self.registerButton setBackgroundImage:[UIImage imageNamed:@"me_hyzc"] forState:UIControlStateNormal];
    [self.registerButton addTarget:self action:@selector(registerButnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.registerButton];
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userImageView.mas_right).offset(10);
        make.top.equalTo(self.userNameLabel.mas_bottom).offset(5);
        make.size.mas_offset(CGSizeMake(85, 18));
    }];
}

-(void)registerButnClick{
    LoginViewController *loginVC=[[LoginViewController alloc]init];
    loginVC.hidesBottomBarWhenPushed=YES;
    [self.controller.navigationController pushViewController:loginVC animated:YES];
}

-(void)tapClick{
    PersonalViewController *personalVC=[[PersonalViewController alloc]init];
    personalVC.hidesBottomBarWhenPushed=YES;
    [self.controller.navigationController pushViewController:personalVC animated:YES];
}

@end
