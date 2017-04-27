//
//  GWOrderManagerCell.m
//  YunStoreApp
//
//  Created by apple on 2017/4/25.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import "GWOrderManagerCell.h"
#import "UIButton+EnlargeEdge.h"

@interface GWOrderManagerCell()

@property (nonatomic,weak)UIImageView *shopImgView;

@property (nonatomic,weak)UILabel *shopGoodslabel;

@property (nonatomic,weak)UILabel *shopGoodsDescLabel;

@property (nonatomic,weak)UILabel *currentPriceLabel;

@property (nonatomic,weak)UILabel *originPriceLabel;

@property (nonatomic,weak)UILabel *shopGoodNumLabel;

@property (nonatomic,weak)UILabel *summaryLabel;

@end

@implementation GWOrderManagerCell

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
    //cell 30.0
    UILabel *shopNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 7, 90, 16)];
    shopNameLabel.textColor = UIColorFromHexValue(0x333333);
    shopNameLabel.font = [UIFont systemFontOfSize:16.0];
    shopNameLabel.text = @"男装旗舰店";
    [self.contentView addSubview:shopNameLabel];
    
    UIImageView *pushImgView = [[UIImageView alloc] initWithFrame:CGRectMake(120, 10.75, 4.5, 8.5)];
    pushImgView.image = [UIImage imageNamed:@"shopCart_pushArrow"];
    [self.contentView addSubview:pushImgView];
    
    //state trade
    UILabel *tradeStateLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 80, 8, 68, 14)];
    tradeStateLabel.textAlignment = NSTextAlignmentRight;
    tradeStateLabel.font = [UIFont systemFontOfSize:12.0f];
    tradeStateLabel.text = @"交易成功";
    tradeStateLabel.textColor = RGBCOLOR(237, 114, 74);
    [self.contentView addSubview:tradeStateLabel];
    
    CALayer *lineView1 = [[CALayer alloc] init];
    lineView1.frame = CGRectMake(0, 29.5, kScreenWidth, 0.5);
    lineView1.backgroundColor = RGBCOLOR(239, 239, 239).CGColor;
    [self.contentView.layer addSublayer:lineView1];
    
    CGFloat shopImgViewY = CGRectGetMaxY(lineView1.frame) + 6;
    UIImageView *shopImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, shopImgViewY, 75, 70.0)];
    self.shopImgView = shopImgView;
    shopImgView.image = [UIImage imageNamed:@"commodity_2"];
    [self.contentView addSubview:shopImgView];
    
    CGFloat shopGoodsLabelX = CGRectGetMaxX(shopImgView.frame) + 6;
    CGFloat shopGoodsLabelY = shopImgViewY;
    CGFloat shopGoodsLabelW = kScreenWidth - shopGoodsLabelX - 80;
    UILabel *shopGoodslabel = [[UILabel alloc] initWithFrame:CGRectMake(shopGoodsLabelX, shopGoodsLabelY, shopGoodsLabelW, 36)];
    self.shopGoodslabel = shopGoodslabel;
    shopGoodslabel.numberOfLines = 2.0;
    shopGoodslabel.font = [UIFont systemFontOfSize:14.0f];
    shopGoodslabel.textColor = RGBCOLOR(5, 5, 5);
    shopGoodslabel.text = @"keds旗舰店女鞋 帆布鞋 低帮鞋女 帆布鞋 低帮鞋女 帆布鞋 低帮鞋女";
    [self.contentView addSubview:shopGoodslabel];
    
    CGFloat shopGoodsDescLabelX = shopGoodsLabelX;
    UILabel *shopGoodsDescLabel = [[UILabel alloc] initWithFrame:CGRectMake(shopGoodsDescLabelX, CGRectGetMaxY(shopGoodslabel.frame) + 6, kScreenWidth - shopGoodsLabelX - 36, 16)];
    self.shopGoodsDescLabel = shopGoodsDescLabel;
    shopGoodsDescLabel.font = [UIFont systemFontOfSize:12.0];
    shopGoodsDescLabel.textColor = UIColorFromHexValue(0x999999);
    shopGoodsDescLabel.text = @"颜色：红色   尺寸：35码";
    [self.contentView addSubview:shopGoodsDescLabel];
    
    CGFloat currentPriceLabelY = CGRectGetMaxY(lineView1.frame) + 10;
    UILabel *currentPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 60, currentPriceLabelY, 50, 17)];
    self.currentPriceLabel = currentPriceLabel;
    currentPriceLabel.font = [UIFont systemFontOfSize:14.0];
    currentPriceLabel.textColor = RGBCOLOR(5, 5, 5);
    currentPriceLabel.text = @"¥968";
    [self.contentView addSubview:currentPriceLabel];
    
    CGFloat originPriceLabelY = CGRectGetMaxY(currentPriceLabel.frame) + 10;
    UILabel *originPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 60, originPriceLabelY, 50, 17)];
    self.originPriceLabel = originPriceLabel;
    originPriceLabel.font = [UIFont systemFontOfSize:14.0];
    originPriceLabel.textColor = RGBCOLOR(153, 153, 153);
    originPriceLabel.text = @"¥968";
    [self.contentView addSubview:originPriceLabel];
    
    UILabel *shopGoodNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 60, CGRectGetMaxY(shopGoodsDescLabel.frame), 50, 16)];
    self.shopGoodNumLabel = shopGoodNumLabel;
    shopGoodNumLabel.font = [UIFont systemFontOfSize:14.0];
    shopGoodNumLabel.textColor = RGBCOLOR(5, 5, 5);
    shopGoodNumLabel.text = @"x 1";
    [self.contentView addSubview:shopGoodNumLabel];
    
    UILabel *summaryLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 240, CGRectGetMaxY(shopGoodNumLabel.frame) + 20, 220, 17)];
    self.summaryLabel = summaryLabel;
    summaryLabel.font = [UIFont systemFontOfSize:14.0];
    summaryLabel.textColor = RGBCOLOR(5, 5, 5);
    summaryLabel.text = @"共一件商品 合计：¥968（含运费#0.00）";
    [self.contentView addSubview:summaryLabel];
    
    CALayer *lineView2 = [[CALayer alloc] init];
    lineView2.frame = CGRectMake(0, 150.0, kScreenWidth, 0.5);
    lineView2.backgroundColor = RGBCOLOR(239, 239, 239).CGColor;
    [self.contentView.layer addSublayer:lineView2];
    
    //删除订单
    CGFloat deleteOrderBtnX = kScreenWidth - 84 * 3 - 18 - 15;
    CGFloat btnY = CGRectGetMaxY(lineView2.frame) + 6;
    UIButton *deleteOrderBtn = [self createCustomBtnWithFrame:CGRectMake(deleteOrderBtnX, btnY, 84, 30)
                                                     btnTitle:@"删除订单"];
    [self.contentView addSubview:deleteOrderBtn];
    [deleteOrderBtn addTarget:self action:@selector(deleteBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //查看物流
    CGFloat lookLogisticBtnX = CGRectGetMaxX(deleteOrderBtn.frame) + 9;
    UIButton *lookLogisticBtn = [self createCustomBtnWithFrame:CGRectMake(lookLogisticBtnX, btnY, 84, 30)
                                                     btnTitle:@"查看物流"];
    [self.contentView addSubview:lookLogisticBtn];
    [lookLogisticBtn addTarget:self action:@selector(deleteBtnAction:) forControlEvents:UIControlEventTouchUpInside];

   
    //评价
    CGFloat evaluateBtnX = CGRectGetMaxX(lookLogisticBtn.frame) + 9;
    UIButton *evaluateBtn = [self createCustomBtnWithFrame:CGRectMake(evaluateBtnX, btnY, 84, 30)
                                                     btnTitle:@"评价"];
    [self.contentView addSubview:evaluateBtn];
    [evaluateBtn addTarget:self action:@selector(deleteBtnAction:) forControlEvents:UIControlEventTouchUpInside];

}

- (void)deleteBtnAction:(UIButton *)deleteBtn {
    deleteBtn.selected = !deleteBtn.selected;
}

- (void)lookLogisticBtnAction:(UIButton *)lookLogisticBtn {
    lookLogisticBtn.selected = !lookLogisticBtn.selected;
}

- (void)evaluateBtnAction:(UIButton *)evaluateBtn {
    evaluateBtn.selected = !evaluateBtn.selected;
}

- (UIButton *)createCustomBtnWithFrame:(CGRect)frame
                              btnTitle:(NSString *)btnTitle
{
    UIButton *customBtn = [[UIButton alloc] initWithFrame:frame];
    customBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [customBtn setBackgroundImage:[UIImage imageNamed:@"orderManager_unSelectRect"] forState:UIControlStateNormal];
    [customBtn setBackgroundImage:[UIImage imageNamed:@"orderManager_selectRect"] forState:UIControlStateSelected];
    [customBtn setTitle:btnTitle forState:UIControlStateNormal];
    [customBtn setTitleColor:RGBCOLOR(65, 65, 65) forState:UIControlStateNormal];
    [customBtn setTitleColor:RGBCOLOR(255, 255, 255) forState:UIControlStateSelected];
    return customBtn;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
