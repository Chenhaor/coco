//
//  SearchTableViewCell.h
//  YunStoreApp
//
//  Created by apple on 2017/4/21.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchTableViewCell : UITableViewCell

@property(nonatomic, strong)void(^searchButnClick)(NSString *searckStr);
@property(nonatomic, strong)NSMutableArray *titleArray;
@end
