//
//  GWMenuAction.h
//  GWMenuTableViewDemo
//
//  Created by yangye on 15/3/27.
//  Copyright (c) 2015年 yangye. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIColor;
@class GWMenuTableViewCell;

typedef void (^GWActionBlock)(GWMenuTableViewCell *cell,NSIndexPath *indexPath);

@interface GWMenuAction : NSObject

@property (nonatomic, strong) UIColor  *backgroundColor;
@property (nonatomic, copy) GWActionBlock actionBlock;

@end
