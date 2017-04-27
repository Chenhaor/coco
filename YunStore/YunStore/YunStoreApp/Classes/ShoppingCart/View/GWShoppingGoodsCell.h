//
//  GWShoppingGoodsCell.h
//  YunStoreApp
//
//  Created by apple on 2017/4/20.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GWShopCartGoodsModel.h"

@interface GWShopGoodsCellUIStyle : NSObject

@property (nonatomic,assign)BOOL selectBtnIsSelected;

@property (nonatomic,assign)ShopCartGoodsStyle goodsStyle;

@end

@interface GWShoppingGoodsCell : UITableViewCell

- (void)configCell:(GWShopCartGoodsModel *)model detailModel:(GWShopGoodsCellUIStyle *)shopGoodsCellUIStyle;

@end
