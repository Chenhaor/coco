//
//  MeFunctionTableViewCell.h
//  YunStoreApp
//
//  Created by apple on 2017/4/24.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SubViewClickBlock)(NSString *subViewName);

@interface MeFunctionTableViewCell : UITableViewCell

@property(nonatomic, strong) NSMutableArray *TagModelArray;

@property (nonatomic,copy) SubViewClickBlock subViewClickBlock;

@end
