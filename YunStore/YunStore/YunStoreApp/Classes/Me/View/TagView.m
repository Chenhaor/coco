//
//  TagView.m
//  YunStoreApp
//
//  Created by apple on 2017/4/24.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import "TagView.h"

@implementation TagView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.tagImageView=[UIImageView new];
    self.tagImageView.image=[UIImage imageNamed:_model.tagImageStr];
    [self addSubview:self.tagImageView];
    
    self.numLabel=[UILabel new];
    self.numLabel.font=[UIFont systemFontOfSize:14];
    self.numLabel.textAlignment=NSTextAlignmentCenter;
    self.numLabel.textColor=RGBCOLOR(69, 69, 68);
    self.numLabel.text=_model.tagNumStr;
    [self addSubview:self.numLabel];
    
    self.tagLabel=[UILabel new];
    self.tagLabel.font=[UIFont systemFontOfSize:15];
    self.tagLabel.textAlignment=NSTextAlignmentCenter;
    self.tagLabel.textColor=RGBCOLOR(89, 89, 89);
    [self addSubview:self.tagLabel];
    
    

}
-(void)setModel:(TagModel *)model{
    _model=model;
    __weak __typeof(self)weakSelf = self;
    self.tagLabel.text=_model.tagNameStr;

    if (_model.isImage) {
        [self.numLabel removeFromSuperview];
        self.tagImageView.image=[UIImage imageNamed:_model.tagImageStr];
        [self.tagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.mas_top).offset(weakSelf.topDistance);
            make.size.mas_offset(CGSizeMake(24, 24));
        }];
        
        [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.tagImageView.mas_bottom).offset(9);
            make.centerX.equalTo(self);
            make.size.mas_offset(CGSizeMake(kScreenWidth/5, 20));
        }];
    }else{
        self.numLabel.text=_model.tagNumStr;
        [self.tagImageView removeFromSuperview];
        [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.mas_top).offset(weakSelf.topDistance);
            make.size.mas_offset(CGSizeMake(kScreenWidth/5, 20));
        }];
        
        [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.numLabel.mas_bottom).offset(9);
            make.centerX.equalTo(self);
            make.size.mas_offset(CGSizeMake(kScreenWidth/5, 20));
        }];
    }
}

//-(void)setIsImage:(BOOL)isImage{
//    _isImage=isImage;
//    __weak __typeof(self)weakSelf = self;
//    if (_isImage) {
//        self.tagImageView=[UIImageView new];
//        [self addSubview:self.tagImageView];
//        [self.tagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.equalTo(self);
//            make.top.equalTo(self.mas_top).offset(weakSelf.topDistance);
//            make.size.mas_offset(CGSizeMake(25, 25));
//        }];
//        
//        [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.tagImageView.mas_bottom).offset(5);
//            make.top.centerX.equalTo(self);
//            make.size.mas_offset(CGSizeMake(kScreenWidth/5, 20));
//        }];
//    }else{
//        self.numLabel=[UILabel new];
//        self.numLabel.font=[UIFont systemFontOfSize:19];
//        self.numLabel.textAlignment=NSTextAlignmentCenter;
//        self.numLabel.textColor=RGBCOLOR(69, 69, 68);
//        [self addSubview:self.numLabel];
//        [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.equalTo(self);
//            make.top.equalTo(self.mas_top).offset(weakSelf.topDistance);
//            make.size.mas_offset(CGSizeMake(20, kScreenWidth/5));
//        }];
//        
//        [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.numLabel.mas_bottom).offset(5);
//            make.top.centerX.equalTo(self);
//            make.size.mas_offset(CGSizeMake(kScreenWidth/5, 20));
//        }];
//    }
//
//}

@end
