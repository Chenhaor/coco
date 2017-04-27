//
//  GWShoppingGoodsCell.m
//  YunStoreApp
//
//  Created by apple on 2017/4/20.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import "GWShoppingGoodsCell.h"
#import "GWShopGoodsStyleView.h"
#import "UITableViewCell+Help.h"
#import "GWShopGoodsAddView.h"
#import "UIButton+EnlargeEdge.h"
#import "UIImageView+WebCache.h"

@implementation GWShopGoodsCellUIStyle


@end

@interface GWShoppingGoodsCell()

@property (nonatomic,weak)UIButton *selectBtn;

@property (nonatomic,weak)UIButton *shopGoodsBgDropDownBtn;

@property (nonatomic,weak)UILabel *shopGoodsDescLabel;

@property (nonatomic,weak)UIImageView *shopImgView;

@property (nonatomic,weak)UILabel *shopGoodslabel;

@property (nonatomic,weak)UILabel *priceLabel;

@property (nonatomic,weak)GWShopGoodsAddView *addView;

@end

@implementation GWShoppingGoodsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
    
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        CALayer *lineView = [[CALayer alloc] init];
        lineView.frame = CGRectMake(0, 0, kScreenWidth, 0.5);
        lineView.backgroundColor = RGBCOLOR(239, 239, 239).CGColor;
        [self.contentView.layer addSublayer:lineView];
        
        //104
        UIButton *selectbtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 45.0, 13, 13)];
        [selectbtn setEnlargeEdgeWithTop:20.0 right:10 bottom:20.0 left:10];
        selectbtn.tag = 100;
        self.selectBtn = selectbtn;
        [selectbtn setImage:[UIImage imageNamed:@"shopCart_radioUnSelect"] forState:UIControlStateNormal];
        [selectbtn setImage:[UIImage imageNamed:@"shopCart_radioSelect"] forState:UIControlStateSelected];
        [self.contentView addSubview:selectbtn];
        [selectbtn addTarget:self action:@selector(selectBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *shopImgView = [[UIImageView alloc] initWithFrame:CGRectMake(32, 7, 75, 90.0)];
        self.shopImgView = shopImgView;
        shopImgView.clipsToBounds = YES;
        shopImgView.layer.cornerRadius = 5.0;
        shopImgView.image = [UIImage imageNamed:@"commodity_2"];
        [self.contentView addSubview:shopImgView];
        
        CGFloat shopGoodsLabelX = CGRectGetMaxX(shopImgView.frame) + 6;
        CGFloat shopGoodsLabelW = kScreenWidth - shopGoodsLabelX - 20;
        UILabel *shopGoodslabel = [[UILabel alloc] initWithFrame:CGRectMake(shopGoodsLabelX, 5, shopGoodsLabelW, 36)];
        self.shopGoodslabel = shopGoodslabel;
        shopGoodslabel.numberOfLines = 2.0;
        shopGoodslabel.font = [UIFont systemFontOfSize:14.0f];
        shopGoodslabel.textColor = RGBCOLOR(5, 5, 5);
        shopGoodslabel.text = @"keds旗舰店女鞋 帆布鞋 低帮鞋女 帆布鞋 低帮鞋女 帆布鞋 低帮鞋女";
        [self.contentView addSubview:shopGoodslabel];
        
        CGFloat shopGoodsBgX = shopGoodsLabelX;
        UIButton *shopGoodsBgDropDownBtn = [[UIButton alloc] initWithFrame:CGRectMake(shopGoodsBgX, CGRectGetMaxY(shopGoodslabel.frame) + 6, kScreenWidth - shopGoodsLabelX - 30, 16)];
        self.shopGoodsBgDropDownBtn = shopGoodsBgDropDownBtn;
        shopGoodsBgDropDownBtn.tag = 101;
        [shopGoodsBgDropDownBtn setBackgroundImage:[UIImage imageNamed:@"shopCart_descBg"] forState:UIControlStateNormal];
        [self.contentView addSubview:shopGoodsBgDropDownBtn];
        [shopGoodsBgDropDownBtn addTarget:self action:@selector(dropDownBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat shopGoodsDescLabelX = shopGoodsLabelX + 6;
        UILabel *shopGoodsDescLabel = [[UILabel alloc] initWithFrame:CGRectMake(shopGoodsDescLabelX, CGRectGetMaxY(shopGoodslabel.frame) + 6, kScreenWidth - shopGoodsLabelX - 36, 16)];
        self.shopGoodsDescLabel = shopGoodsDescLabel;
        shopGoodsDescLabel.font = [UIFont systemFontOfSize:12.0];
        shopGoodsDescLabel.textColor = UIColorFromHexValue(0x999999);
        shopGoodsDescLabel.text = @"颜色：红色   尺寸：35码";
        [self.contentView addSubview:shopGoodsDescLabel];
        
        UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(shopImgView.frame) + 6, 75, 50, 17)];
        self.priceLabel = priceLabel;
        priceLabel.font = [UIFont systemFontOfSize:16.0];
        priceLabel.textColor = UIColorFromHexValue(0xeb4f21);
        priceLabel.text = @"¥968";
        [self.contentView addSubview:priceLabel];
        
        GWShopGoodsAddView *addView = [[GWShopGoodsAddView alloc] initWithFrame:CGRectMake(kScreenWidth - 88.0, 70.0, 78, 24 * 34.0/33.0)];
        self.addView = addView;
        [self addSubview:addView];
        [addView setCurrentNum:2 andTotoalNum:10];
    }
    
    return self;
}

- (void)configCell:(GWShopCartGoodsModel *)model detailModel:(GWShopGoodsCellUIStyle *)shopGoodsCellUIStyle
{
    self.selectBtn.selected = shopGoodsCellUIStyle.selectBtnIsSelected ? YES : NO;
    
    if (shopGoodsCellUIStyle.goodsStyle == GoodsBuy) {
        
        self.shopGoodsBgDropDownBtn.hidden = YES;
        self.shopGoodsDescLabel.textColor = UIColorFromHexValue(0x999999);
        
    }else if (shopGoodsCellUIStyle.goodsStyle == GoodsEdit) {
        self.shopGoodsBgDropDownBtn.hidden = NO;
        self.shopGoodsDescLabel.textColor = [UIColor whiteColor];
    }
    
    [self.shopImgView sd_setImageWithURL:[NSURL URLWithString:model.goodsUrl]];
    self.shopGoodslabel.text =  model.goodsTitle;
    self.shopGoodsDescLabel.text = model.descTitle;
    self.priceLabel.text = [NSString stringWithFormat:@"¥%d",model.price];
    [self.addView setCurrentNum:model.goodsNum andTotoalNum:10];
}

- (void)selectBtnAction:(UIButton *)btn {
    btn.selected = !btn.selected;
    if (self.cellBlockWithParam) {
        self.cellBlockWithParam(btn, @(btn.selected));
    }
}

- (void)dropDownBtnAction:(UIButton *)btn {
    if (self.cellBlockWithParam) {
        self.cellBlockWithParam(btn, @(btn.selected));
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
