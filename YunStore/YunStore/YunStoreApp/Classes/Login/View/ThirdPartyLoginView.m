//
//  ThirdPartyLoginView.m
//  YunStoreApp
//
//  Created by apple on 2017/4/26.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import "ThirdPartyLoginView.h"

@implementation ThirdPartyLoginView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    //165
    UIImageView *titleImageView=[[UIImageView alloc]initWithFrame:CGRectMake(self.center.x-159/2, 0, 159, 9)];
    titleImageView.image=[UIImage imageNamed:@"YF_ThirdloginTitle"];
    [self addSubview:titleImageView];
    

    NSArray *logoImageArray=@[@"YF_WeChatlogin",@"YF_qqLogin"];
    CGFloat butnWidth=50;
    CGFloat spaceWidth=(kScreenWidth-butnWidth*logoImageArray.count)/(logoImageArray.count+1);
    for (int a=0; a<logoImageArray.count; a++) {
        UIButton *logoButn=[[UIButton alloc]initWithFrame:CGRectMake(spaceWidth+(spaceWidth+butnWidth)*a, 55, butnWidth, butnWidth)];
        [logoButn.layer setCornerRadius:5];
        [logoButn.layer setMasksToBounds:YES];
        logoButn.tag=1300+a;
        [logoButn setImage:[UIImage imageNamed:logoImageArray[a]] forState:UIControlStateNormal];
        [logoButn addTarget:self action:@selector(logoButnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:logoButn];
    }
}

-(void)logoButnClick:(UIButton *)butn{


}
@end
