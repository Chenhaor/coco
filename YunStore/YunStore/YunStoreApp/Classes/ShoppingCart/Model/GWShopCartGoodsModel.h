//
//  GWShopCartGoodsModel.h
//  YunStoreApp
//
//  Created by apple on 2017/4/24.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GWShopCartGoodsModel : NSObject

@property (nonatomic,copy)NSString *goodsUrl;

@property (nonatomic,copy)NSString *goodsTitle;

@property (nonatomic,copy)NSString *descTitle;

@property (nonatomic,assign)int price;

@property (nonatomic,assign)int goodsNum;

@end
