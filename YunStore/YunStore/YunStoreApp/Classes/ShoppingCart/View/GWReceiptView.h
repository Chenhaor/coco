//
//  GWReceiptView.h
//  YunStoreApp
//
//  Created by apple on 2017/4/21.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectBtnActionBlock)(BOOL isSelected);

typedef void(^ShareBtnActionBlock)();

typedef void(^AttentionBtnActionBlock)();

typedef void(^DeleteBtnActionBlock)();

@interface GWReceiptView : UIView

@property (nonatomic,assign)ShopCartGoodsStyle goodsStyle;

@property (nonatomic,assign)BOOL selectedBtnIsSelect;

- (void)setSelectBtnActionBlock:(SelectBtnActionBlock)selectBtnActionBlock;

- (void)setShareBtnActionBlock:(ShareBtnActionBlock)shareBtnActionBlock;

- (void)setAttentionBtnActionBlock:(AttentionBtnActionBlock)attentionBtnActionBlock;

- (void)setDeleteBtnActionBlock:(DeleteBtnActionBlock)deleteBtnActionBlock;

@end
