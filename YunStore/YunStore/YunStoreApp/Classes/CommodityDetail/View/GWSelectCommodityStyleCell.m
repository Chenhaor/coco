//
//  GWSelectCommodityStyleCell.m
//  YunStoreApp
//
//  Created by apple on 2017/4/25.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import "GWSelectCommodityStyleCell.h"

@implementation GWSelectCommodityStyleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUI];
    }
    
    return self;
}

- (void)setUI {
    UILabel *noteLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 30, 14)];
    noteLabel.font = [UIFont systemFontOfSize:12.0];
    noteLabel.text = @"已选";
    noteLabel.textColor = RGBCOLOR(164, 164, 164);
    [self.contentView addSubview:noteLabel];
    
    UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(42,19, kScreenWidth - 76, 36.0)];
    descLabel.numberOfLines = 2.0;
    descLabel.font = [UIFont systemFontOfSize:14.0];
    descLabel.text = @"颜色：白 型号：iphone 6 颜色：白 型号：iphone 6 颜色：白 型号：iphone 6";
    descLabel.textColor = RGBCOLOR(164, 164, 164);
    [self.contentView addSubview:descLabel];
    
    UIButton *menuImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 33, 30, 17, 3)];
    [menuImgBtn setImage:[UIImage imageNamed:@"commodityDetail_menu"] forState:UIControlStateNormal];
    [self.contentView addSubview:menuImgBtn];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
