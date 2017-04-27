//
//  GWReceiptView.m
//  YunStoreApp
//
//  Created by apple on 2017/4/21.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import "GWReceiptView.h"
#import "UIButton+EnlargeEdge.h"

@interface GWReceiptView()

@property (nonatomic,weak)UILabel *shopGoodsPricesLabel;
@property (nonatomic,weak)UILabel *totoalPricelabel;
@property (nonatomic,weak)UIButton *receiptBtn;
@property (nonatomic,weak)UIButton *shareBtn;
@property (nonatomic,weak)UIButton *attentionBtn;
@property (nonatomic,weak)UIButton *deleteBtn;
@property (nonatomic,weak)UIButton *selectbtn;

@property (nonatomic,copy)SelectBtnActionBlock selectBtnActionBlock;

@property (nonatomic,copy)ShareBtnActionBlock shareBtnActionBlock;

@property (nonatomic,copy)AttentionBtnActionBlock attentionBtnActionBlock;

@property (nonatomic,copy)DeleteBtnActionBlock deleteBtnActionBlock;

@end

@implementation GWReceiptView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self setCommonUI];
        [self setGoodsBuyUI];
        [self setGoodsEditUI];
    }
    
    return self;
}

- (void)setCommonUI
{
    UIButton *selectbtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 20, 13, 13)];
    [selectbtn setEnlargeEdgeWithTop:15 right:10 bottom:20 left:20];
    self.selectbtn = selectbtn;
    [selectbtn setImage:[UIImage imageNamed:@"shopCart_radioUnSelect"] forState:UIControlStateNormal];
    [selectbtn setImage:[UIImage imageNamed:@"shopCart_radioSelect"] forState:UIControlStateSelected];
    [self addSubview:selectbtn];
    [selectbtn addTarget:self action:@selector(selectBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *shopGoodslabel = [[UILabel alloc] initWithFrame:CGRectMake(34, 20, 30, 14)];
    shopGoodslabel.font = [UIFont systemFontOfSize:14.0f];
    shopGoodslabel.textColor = RGBCOLOR(5, 5, 5);
    shopGoodslabel.text = @"全选";
    [self addSubview:shopGoodslabel];
}

- (void)setSelectedBtnIsSelect:(BOOL)selectedBtnIsSelect
{
    _selectedBtnIsSelect = selectedBtnIsSelect;
    self.selectbtn.selected = selectedBtnIsSelect;
}

- (void)selectBtnAction:(UIButton*)selectBtn
{
    selectBtn.selected = !selectBtn.selected;
    
    if (self.selectBtnActionBlock) {
        self.selectBtnActionBlock(selectBtn.selected);
    }
}

- (void)setSelectBtnActionBlock:(SelectBtnActionBlock)selectBtnActionBlock
{
    _selectBtnActionBlock = selectBtnActionBlock;
}

- (void)setShareBtnActionBlock:(ShareBtnActionBlock)shareBtnActionBlock
{
    _shareBtnActionBlock = shareBtnActionBlock;
}

- (void)setAttentionBtnActionBlock:(AttentionBtnActionBlock)attentionBtnActionBlock
{
    _attentionBtnActionBlock = attentionBtnActionBlock;
}

- (void)setDeleteBtnActionBlock:(DeleteBtnActionBlock)deleteBtnActionBlock
{
    _deleteBtnActionBlock = deleteBtnActionBlock;
}

- (void)setGoodsStyle:(ShopCartGoodsStyle)goodsStyle
{
    _goodsStyle = goodsStyle;
    
    if (_goodsStyle == GoodsBuy) {
        
        [self showGoodsBuyUI];
        [self hiddenGoodsEditUI];
    }
    else if (_goodsStyle == GoodsEdit) {
        [self showGoodsEditUI];
        [self hiddenGoodsBuyUI];
    }
}

- (void)setGoodsBuyUI
{
    UILabel *shopGoodsPricesLabel = [[UILabel alloc] initWithFrame:CGRectMake(175, 9, 90, 16)];
    self.shopGoodsPricesLabel = shopGoodsPricesLabel;
    shopGoodsPricesLabel.font = [UIFont systemFontOfSize:16.0f];
    shopGoodsPricesLabel.textColor = RGBCOLOR(5, 5, 5);
    shopGoodsPricesLabel.text = @"合计：¥968";
    [self addSubview:shopGoodsPricesLabel];
    
    UILabel *totoalPricelabel = [[UILabel alloc] initWithFrame:CGRectMake(175, 32, 90, 14)];
    self.totoalPricelabel = totoalPricelabel;
    totoalPricelabel.font = [UIFont systemFontOfSize:14.0f];
    totoalPricelabel.textColor = UIColorFromHexValue(0x666666);
    totoalPricelabel.text = @"总额：¥968";
    [self addSubview:totoalPricelabel];
    
    UIButton *receiptBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 105, 0, 105, self.bounds.size.height)];
    self.receiptBtn = receiptBtn;
    receiptBtn.titleLabel.font = [UIFont systemFontOfSize:18.0];
    [receiptBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    receiptBtn.backgroundColor = UIColorFromHexValue(0xeb4f21);
    [receiptBtn setTitle:@"去结算(0)" forState:UIControlStateNormal];
    [self addSubview:receiptBtn];
}

- (void)setGoodsEditUI
{
    UIButton *shareBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 215, 12, 50, 28)];
    shareBtn.layer.cornerRadius = 5.0;
    shareBtn.layer.borderWidth = 1.0;
    shareBtn.layer.borderColor = RGBCOLOR(187, 187, 187).CGColor;
    self.shareBtn = shareBtn;
    shareBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [shareBtn setTitleColor:RGBCOLOR(187, 187, 187) forState:UIControlStateNormal];
    [shareBtn setTitle:@"分享" forState:UIControlStateNormal];
    [self addSubview:shareBtn];
    [shareBtn addTarget:self action:@selector(shareBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *attentionBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 153, 12, 80, 28)];
    attentionBtn.layer.cornerRadius = 5.0;
    attentionBtn.layer.borderWidth = 1.0;
    attentionBtn.layer.borderColor = RGBCOLOR(187, 187, 187).CGColor;
    self.attentionBtn = attentionBtn;
    attentionBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [attentionBtn setTitleColor:RGBCOLOR(187, 187, 187) forState:UIControlStateNormal];
    [attentionBtn setTitle:@"移入关注" forState:UIControlStateNormal];
    [self addSubview:attentionBtn];
    [attentionBtn addTarget:self action:@selector(attentionBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 62, 12, 50, 28)];
    deleteBtn.layer.cornerRadius = 5.0;
    deleteBtn.layer.borderWidth = 1.0;
    deleteBtn.layer.borderColor = UIColorFromHexValue(0xeb4f21).CGColor;
    self.deleteBtn = deleteBtn;
    deleteBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [deleteBtn setTitleColor:UIColorFromHexValue(0xeb4f21) forState:UIControlStateNormal];
    [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [self addSubview:deleteBtn];
    [deleteBtn addTarget:self action:@selector(deleteBtnAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)showGoodsEditUI
{
    self.shareBtn.hidden = NO;
    self.attentionBtn.hidden = NO;
    self.deleteBtn.hidden = NO;
}

- (void)hiddenGoodsEditUI
{
    self.shareBtn.hidden = YES;
    self.attentionBtn.hidden = YES;
    self.deleteBtn.hidden = YES;
}

- (void)showGoodsBuyUI
{
    self.shopGoodsPricesLabel.hidden = NO;
    self.totoalPricelabel.hidden = NO;
    self.receiptBtn.hidden = NO;
}

- (void)hiddenGoodsBuyUI
{
    self.shopGoodsPricesLabel.hidden = YES;
    self.totoalPricelabel.hidden = YES;
    self.receiptBtn.hidden = YES;
}

#pragma mark btnAction

- (void)shareBtnAction:(UIButton *)shareBtn
{
    if (self.shareBtnActionBlock) {
        self.shareBtnActionBlock();
    }
}

- (void)attentionBtnAction:(UIButton *)attentionBtn
{
    if (self.attentionBtnActionBlock) {
        self.attentionBtnActionBlock();
    }
}

- (void)deleteBtnAction:(UIButton *)deleteBtn
{
    if (self.deleteBtnActionBlock) {
        self.deleteBtnActionBlock();
    }
}

@end
