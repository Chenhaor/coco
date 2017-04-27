//
//  shopCommodityModel.h
//  YunFuStore
//
//  Created by apple on 2017/4/12.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ArchiveModel.h"

@interface shopCommodityModel : ArchiveModel

@property(nonatomic ,strong) NSString *cargoImageStr;
@property(nonatomic ,strong) NSString *cargoName;
@property(nonatomic ,assign) float cargoPrice;
@property(nonatomic ,strong) NSString *cargoStandard;//货物规格
@property(nonatomic ,assign) float cargoTotalprices;
@property(nonatomic ,assign) NSInteger cargoNum;

@property(nonatomic ,assign) BOOL isCheck;
@end
