//
//  ClassDetailCollectionViewCell.m
//  YunFuStore
//
//  Created by apple on 2017/4/11.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ClassDetailCollectionViewCell.h"

@implementation ClassDetailCollectionViewCell
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
    self.imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
    [self.contentView addSubview:self.imageView];
    
    self.titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 80, 80, 20)];
    self.titlelabel.textAlignment=NSTextAlignmentCenter;
    self.titlelabel.font=[UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.titlelabel];
}

-(void)setModel:(ClassDetailModel *)model{
    _model=model;
    self.imageView.image=[UIImage imageNamed:_model.imageStr];
    
    self.titlelabel.text=_model.detailTitle;
}
@end
