//
//  ClassTableViewCell.h
//  YunFuStore
//
//  Created by apple on 2017/4/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassModel.h"

@interface ClassTableViewCell : UITableViewCell

@property(nonatomic, strong)UILabel *classLabel;
@property(nonatomic, strong)ClassModel *model;
@end
