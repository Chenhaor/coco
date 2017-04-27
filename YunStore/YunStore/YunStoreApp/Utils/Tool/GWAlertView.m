//
//  GWAlertView.m
//  Holoera
//
//  Created by gowild on 16/11/3.
//  Copyright © 2016年 gowild. All rights reserved.
//

#import "GWAlertView.h"

@interface GWAlertView()

@property (nonatomic,strong)UILabel *alertTitleLabel;
@property (nonatomic,copy)NSString *title;

@property (nonatomic,strong)UILabel *alertContentLabel;
@property (nonatomic,copy)NSString *message;

@property (nonatomic,strong)UIButton *leftBtn;
@property (nonatomic,copy)NSString *leftTitle;

@property (nonatomic,strong)UIButton *rightBtn;
@property (nonatomic,copy)NSString *rightTitle;

@end

@implementation GWAlertView

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
                    leftTitle:(NSString *)leftTitle
                   rightTitle:(NSString *)rightTitle
{
    if (self = [super init])
    {
        NSAssert((!IsNilOrNull(title) || !IsNilOrNull(message)), @"GWAlertView中title和message必需传其中一个");
        
        [self initData:title message:message leftTitle:leftTitle rightTitle:rightTitle];
        
        [self setLayout];
    }
    return self;
}

- (void)initData:(NSString *)title
         message:(NSString *)messsage
     leftTitle:(NSString *)leftTitle
         rightTitle:(NSString *)rightTitle
{
    self.alertViewW = 300.0;
    
    CGFloat originY = 20.0;
    CGFloat totoalPadding = 0.0;

    //title height 30
    CGFloat titleH = 0.0;
    if (!IsNilOrNull(title))
    {
        self.title = title;

        titleH = 30.0;
        totoalPadding += 15.0;
    }
    
    //contentH 最大限制为400
    CGRect contentRect = CGRectZero;
    if (!IsNilOrNull(messsage))
    {
        self.message = messsage;
        contentRect = [self caculateMessageRect];
        totoalPadding += 28.0;
    }
    
    self.leftTitle = leftTitle;
    self.rightTitle = rightTitle;
    
    //122 41.5 btn
    CGFloat checkBtnH = 41.5;
    
    totoalPadding += 8.0;
    
    self.alertViewH = originY + titleH + contentRect.size.height + checkBtnH + totoalPadding;
}

- (CGRect)caculateMessageRect
{
    return [self.message boundingRectWithSize:CGSizeMake(self.alertViewW - 20, 400.0)
                               options:NSStringDrawingUsesLineFragmentOrigin
                            attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0]}
                               context:NULL];
}

- (void)setLayout
{
    UIImageView *alertViewBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.alertViewW, self.alertViewH)];
    alertViewBg.userInteractionEnabled = YES;
    alertViewBg.image = [UIImage imageNamed:@"Alert_Bg"];
    [self addSubview:alertViewBg];
    
    CGFloat contentLabelY = 20.0;
    
    CGFloat btnY = 20.0;

    if (!IsNilOrNull(self.title))
    {
        self.alertTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 20.0, self.alertViewW - 20.0, 25.0)];
        self.alertTitleLabel.text = self.title;
        self.alertTitleLabel.textAlignment = NSTextAlignmentCenter;
        self.alertTitleLabel.textColor = [UIColor whiteColor];
        self.alertTitleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
        [alertViewBg addSubview:self.alertTitleLabel];
        
        contentLabelY = CGRectGetMaxY(self.alertTitleLabel.frame) + 15.0;
        btnY = CGRectGetMaxY(self.alertContentLabel.frame) + 15.0;
    }
    
    if (!IsNilOrNull(self.message))
    {
        CGFloat alertContentLabelH = [self caculateMessageRect].size.height;
        self.alertContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, contentLabelY, self.alertViewW - 20, alertContentLabelH)];
        self.alertContentLabel.textAlignment = NSTextAlignmentCenter;
        self.alertContentLabel.text = self.message;
        self.alertContentLabel.numberOfLines = 0;
        self.alertContentLabel.textColor = [UIColor whiteColor];
        self.alertContentLabel.font = [UIFont systemFontOfSize:16.0];
        [alertViewBg addSubview:self.alertContentLabel];
        
        btnY = CGRectGetMaxY(self.alertContentLabel.frame) + 28.0;
    }
    
    if ((self.leftTitle && self.rightTitle) || (!self.leftTitle && !self.rightTitle))
    {
        self.leftTitle = self.leftTitle? self.leftTitle : @"取消";
        self.rightTitle = self.rightTitle? self.rightTitle : @"确定";
        
        CGRect leftBtnFrame = CGRectMake(14.0, btnY, 122.0, 41.5);
        CGRect rightBtnFrame = CGRectMake(164.0, btnY, 122.0, 41.5);
        
        self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        self.leftBtn.frame = leftBtnFrame;
        self.rightBtn.frame = rightBtnFrame;
        
        [self.leftBtn setTitle:self.leftTitle forState:UIControlStateNormal];
        [self.leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.rightBtn setTitle:self.rightTitle forState:UIControlStateNormal];
        [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [self.rightBtn setBackgroundImage:[UIImage imageNamed:@"Alert_confirmBtn"] forState:UIControlStateNormal];
        [self.leftBtn setBackgroundImage:[UIImage imageNamed:@"Alert_cancleBtn"] forState:UIControlStateNormal];
        
        [self.leftBtn addTarget:self action:@selector(leftBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.rightBtn addTarget:self action:@selector(rightBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [alertViewBg addSubview:self.leftBtn];
        [alertViewBg addSubview:self.rightBtn];

    }
    else if (self.leftTitle || self.rightTitle)
    {
        CGFloat btnX = (self.alertViewW - 122.0)/2.0;
        CGRect centerBtnFrame = CGRectMake(btnX, btnY, 122.0, 41.5);
        UIButton *centerBtn = nil;
        NSString *btnTitle = @"";
        if (self.leftTitle) {
            self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.leftBtn.frame = centerBtnFrame;
            centerBtn = self.leftBtn;
            btnTitle = self.leftTitle;
            [centerBtn addTarget:self action:@selector(leftBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        }
        else if (self.rightTitle){
            self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.rightBtn.frame = centerBtnFrame;
            centerBtn = self.rightBtn;
            btnTitle = self.rightTitle;
            [centerBtn addTarget:self action:@selector(rightBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        [centerBtn setTitle:btnTitle forState:UIControlStateNormal];
        [centerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [centerBtn setBackgroundImage:[UIImage imageNamed:@"Alert_Btn"] forState:UIControlStateNormal];
        [alertViewBg addSubview:centerBtn];
    }
}

- (void)leftBtnClicked:(UIButton *)leftBtn
{
    __weak typeof(self) weakSelf = self;
    
    [self dismissAlert:^{
        if (weakSelf.leftBlock) {
            weakSelf.leftBlock();
        }
    }];
}

- (void)rightBtnClicked:(UIButton *)rightBtn
{
    __weak typeof(self) weakSelf = self;

    [self dismissAlert:^{
        if (weakSelf.rightBlock) {
            weakSelf.rightBlock();
        }
    }];
}

@end
