//
//  ClassHeadView.m
//  YunStoreApp
//
//  Created by apple on 2017/4/21.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import "ClassHeadView.h"

@implementation ClassHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    
    UIView *backView=[UIView new];
    [self addSubview:backView];
    backView.backgroundColor=DEFAULT_BACKGROUND_COLOR;
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    _headImageView=[UIImageView new];
    _headImageView.backgroundColor=[UIColor yellowColor];
    _headImageView.image=[UIImage imageNamed:@"classifiedHeadImage"];
    [self addSubview:_headImageView];
    _headImageView.frame=CGRectMake(0, 0, kScreenWidth-110, 100);

    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_headImageView.bounds byRoundingCorners:UIRectCornerBottomLeft cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = _headImageView.bounds;
    maskLayer.path = maskPath.CGPath;
    _headImageView.layer.mask = maskLayer;
}

@end
