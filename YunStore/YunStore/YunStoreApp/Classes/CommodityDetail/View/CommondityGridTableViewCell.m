//
//  CommondityGridTableViewCell.m
//  YunStoreApp
//
//  Created by apple on 2017/4/26.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import "CommondityGridTableViewCell.h"
#import "GWCommodityGridView.h"

@interface CommondityGridTableViewCell ()

@property(nonatomic, strong)GWCommodityGridView *leftView;
@property(nonatomic, strong)GWCommodityGridView *rightView;

@end
@implementation CommondityGridTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    //    230
    self.contentView.backgroundColor=DEFAULT_CUTTINGLINE_COLOR;
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.leftView=[[GWCommodityGridView alloc]initWithFrame:CGRectMake(0, 2, kScreenWidth/2-1, 230-2)];
    [self.contentView addSubview:self.leftView];
    
    self.rightView=[[GWCommodityGridView alloc]initWithFrame:CGRectMake(kScreenWidth/2+1, 2, kScreenWidth/2-1, 230-2)];
    [self.contentView addSubview:self.rightView];
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
