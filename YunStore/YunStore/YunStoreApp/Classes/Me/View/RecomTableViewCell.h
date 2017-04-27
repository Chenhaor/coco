//
//  RecomTableViewCell.h
//  YunStoreApp
//
//  Created by apple on 2017/4/24.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommodityModel.h"

@interface RecomTableViewCell : UITableViewCell

@property(nonatomic, strong)CommodityModel *leftmodel;
@property(nonatomic, strong)CommodityModel *rightmodel;

@end
