//
//  TagCollectionViewCell.m
//  YunFuStore
//
//  Created by apple on 2017/4/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "TagCollectionViewCell.h"
@interface TagCollectionViewCell ()


@end

@implementation TagCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.backgroundColor=[UIColor whiteColor];
    self.tagImageView=[UIImageView new];
    [self.contentView addSubview:self.tagImageView];
    [self.tagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.size.mas_equalTo(CGSizeMake(38, 38));
    }];
    
    self.tagLabel=[UILabel new];
    self.tagLabel.textColor=UIColorFromHexValue(0x333333);
    self.tagLabel.font=[UIFont systemFontOfSize:12];
    self.tagLabel.textAlignment=NSTextAlignmentCenter;
    [self.contentView addSubview:self.tagLabel];
    [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.tagImageView.mas_bottom).offset(3);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth/5-10, 14));
    }];
}
@end
