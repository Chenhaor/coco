//
//  GWShopCell.m
//  YunStoreApp
//
//  Created by apple on 2017/4/20.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import "GWShopCell.h"
#import "UITableViewCell+Help.h"
#import "UIButton+EnlargeEdge.h"

@interface GWShopCell()

@property (nonatomic,weak)UIButton *selectbtn;

@end

@implementation GWShopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
    
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        //cell 30.0
        UIButton *selectbtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 8.5, 13, 13)];
        selectbtn.tag = 100;
        self.selectbtn = selectbtn;
        [selectbtn setEnlargeEdgeWithTop:8.5 right:10 bottom:8.5 left:10];
        [selectbtn setImage:[UIImage imageNamed:@"shopCart_radioUnSelect"] forState:UIControlStateNormal];
        [selectbtn setImage:[UIImage imageNamed:@"shopCart_radioSelect"] forState:UIControlStateSelected];
        [self.contentView addSubview:selectbtn];
        [selectbtn addTarget:self action:@selector(selectBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *shopNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(28, 7, 90, 16)];
        shopNameLabel.textColor = UIColorFromHexValue(0x333333);
        shopNameLabel.font = [UIFont systemFontOfSize:16.0];
        shopNameLabel.text = @"男装旗舰店";
        [self.contentView addSubview:shopNameLabel];
        
        UIImageView *pushImgView = [[UIImageView alloc] initWithFrame:CGRectMake(120, 10.75, 4.5, 8.5)];
        pushImgView.image = [UIImage imageNamed:@"shopCart_pushArrow"];
        [self.contentView addSubview:pushImgView];
        
        UIButton *couponBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 50.0, 8, 38.0, 14)];
        couponBtn.tag = 101;
        [couponBtn setEnlargeEdgeWithTop:8 right:10 bottom:8 left:10];
        couponBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [couponBtn setTitle:@"优惠券" forState:UIControlStateNormal];
        [couponBtn setTitleColor:RGBCOLOR(237, 114, 74) forState:UIControlStateNormal];
        [self.contentView addSubview:couponBtn];
        [couponBtn addTarget:self action:@selector(couponBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

- (void)configCell:(id)model detailModel:(NSNumber *)detailModel
{
    self.selectbtn.selected = ([detailModel integerValue] == 0) ? NO : YES;
}

- (void)selectBtnAction:(UIButton *)btn {
    btn.selected = !btn.selected;
    if (self.cellBlockWithParam) {
        self.cellBlockWithParam(btn, @(btn.selected));
    }
}

- (void)couponBtnAction:(UIButton *)btn {
    
    if (self.cellBlockWithParam) {
        self.cellBlockWithParam(btn, nil);
    }
}
    
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
