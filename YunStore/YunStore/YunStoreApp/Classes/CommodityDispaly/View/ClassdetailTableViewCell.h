//
//  ClassdetailTableViewCell.h
//  YunFuStore
//
//  Created by apple on 2017/4/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassDetailModel.h"

@interface ClassdetailTableViewCell : UITableViewCell

@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UILabel *titlelabel;

@property(nonatomic, strong) ClassDetailModel *model;

@property(nonatomic, strong) NSMutableArray *modelArray;

@end
