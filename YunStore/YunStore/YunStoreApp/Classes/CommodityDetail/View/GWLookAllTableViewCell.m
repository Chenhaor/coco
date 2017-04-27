//
//  GWLookAllTableViewCell.m
//  YunStoreApp
//
//  Created by apple on 2017/4/25.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import "GWLookAllTableViewCell.h"
@interface GWLookAllTableViewCell ()

@property(nonatomic, strong)UILabel *titlelabel;


@end

@implementation GWLookAllTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    
    CALayer *layer=[CALayer layer];
    layer.frame=CGRectMake(10, 0, kScreenWidth-20, 1);
    layer.backgroundColor=RGBCOLOR(243, 243, 243).CGColor;
    [self.contentView.layer addSublayer:layer];
    
    self.titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 8, kScreenWidth-20, 24)];
    [self.titlelabel.layer setBorderColor:RGBCOLOR(232, 232, 232).CGColor];
    [self.titlelabel.layer setBorderWidth:1.0f];
    [self.titlelabel.layer setMasksToBounds:YES];
    self.titlelabel.textColor=RGBCOLOR(137, 137, 137);
    self.titlelabel.font=[UIFont systemFontOfSize:15];
    self.titlelabel.textAlignment=NSTextAlignmentCenter;
    [self.contentView addSubview:self.titlelabel];
    self.titlelabel.text=@"查看全部评价";
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
