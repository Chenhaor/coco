//
//  AddressTitleTableViewCell.m
//  YunStoreApp
//
//  Created by ChenHao on 2017/4/27.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import "AddressTitleTableViewCell.h"
@interface AddressTitleTableViewCell ()

@end
@implementation AddressTitleTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.addressLabel=[[UILabel alloc]initWithFrame:CGRectMake(15, 5, kScreenWidth-100, 20)];
    self.addressLabel.textColor=RGBCOLOR(225, 225, 225);
    self.addressLabel.font=[UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.addressLabel];
}

-(void)layoutSubviews{
    if (self.selected) {
        self.addressLabel.textColor=[UIColor redColor];
        self.addressLabel.text=[NSString stringWithFormat:@"%@ ∨",self.addressLabel.text];
    }else{
        self.addressLabel.textColor=RGBCOLOR(225, 225, 225);

    }

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
