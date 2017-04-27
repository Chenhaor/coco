//
//  GWShopGoodsAddView.h
//  YunStoreApp
//
//  Created by apple on 2017/4/21.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GWShopGoodsAddView : UIView

@property (nonatomic,assign,readonly)NSInteger currentNum;

@property (nonatomic,assign,readonly)NSInteger totoalNum;


- (void)setCurrentNum:(NSInteger)currentNum andTotoalNum:(NSInteger)totoalNum;

@end
