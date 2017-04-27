//
//  UITableViewCell+Help.h
//
//  Created by yangye on 16/9/30.
//  Copyright © 2016年. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CellSubViewActionBlock)(id subView,id value);

@interface UITableViewCell (Help)

@property (nonatomic,copy)CellSubViewActionBlock cellBlockWithParam;

@property (nonatomic,copy)dispatch_block_t cellBlockDefault;

@end
