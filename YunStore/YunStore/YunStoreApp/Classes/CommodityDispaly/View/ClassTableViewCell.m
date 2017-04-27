//
//  ClassTableViewCell.m
//  YunFuStore
//
//  Created by apple on 2017/4/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ClassTableViewCell.h"
#import "ClassTableViewCell.h"
//#import "ClassdetailTableViewCell.h"
@interface ClassTableViewCell (){
    CALayer *lineLayer;
}


@end
@implementation ClassTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
 
    lineLayer=[CALayer layer];
    lineLayer.frame=CGRectMake(0, 0, 2, self.frame.size.height);
    lineLayer.backgroundColor=[UIColor clearColor].CGColor;
    [self.contentView.layer addSublayer:lineLayer];

    self.classLabel=[UILabel new];
    self.classLabel.textAlignment=NSTextAlignmentCenter;
    self.classLabel.font=[UIFont systemFontOfSize:15];
    self.classLabel.textColor=RGBCOLOR(137, 137, 137);
    [self.contentView addSubview:self.classLabel];
    
    [self.classLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(UIEdgeInsetsMake(0, 2, 0, -1));
    }];
    
    CALayer *layer=[CALayer layer];
    layer.frame=CGRectMake(0, CGRectGetMaxY(self.frame)-1, CGRectGetMaxX(self.frame), 1);
    layer.backgroundColor=RGBCOLOR(240, 244, 246).CGColor;
    [self.contentView.layer addSublayer:layer];
}

-(void)setModel:(ClassModel *)model{
    _model=model;
    self.classLabel.text=_model.titleStr;
    
}

-(void)layoutSubviews{
        if (self.selected==YES) {
            lineLayer.backgroundColor=[UIColor redColor].CGColor;
            self.classLabel.textColor=[UIColor redColor];

        }else{
            lineLayer.backgroundColor=[UIColor clearColor].CGColor;
            self.classLabel.textColor=RGBCOLOR(137, 137, 137);
        }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end
