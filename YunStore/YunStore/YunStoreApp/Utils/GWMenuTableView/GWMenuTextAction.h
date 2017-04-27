//
//  GWMenuTextAction.h
//  JHMenuTableViewDemo
//
//  Created by gowild on 16/10/22.
//  Copyright © 2016年 Jiahai. All rights reserved.
//

#import "GWMenuAction.h"

@interface GWMenuTextAction : GWMenuAction

//文字
@property (nonatomic, copy)   NSString *title;
@property (nonatomic, strong) UIColor  *titleColor;

@end
