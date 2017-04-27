//
//  CellConfig.h
//
//  Created by yangye on 15/2/25.
//  Copyright (c) 2015年. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "UITableViewCell+Help.h"

typedef void(^CellSelectedBlock)(NSInteger section,NSInteger row);

@interface GWCellConfig : NSObject

/// cell类名
@property (nonatomic, copy) NSString *className;

/// 显示数据模型的方法
@property (nonatomic, assign) SEL showInfoMethod;

///
@property (nonatomic, strong)id modelToShow;

///
@property (nonatomic, strong)id modelToShowDetail;

/// cell高度(固定高度)
@property (nonatomic, assign) CGFloat heightOfCell;


/// 指定重用ID，不赋值则使用类名
@property (nonatomic, copy) NSString *reuseID;


#pragma mark - cell subview clicked

@property (nonatomic,copy)CellSubViewActionBlock cellSubViewBlockWithParam; //cell上subView的点击传递参数

@property (nonatomic,copy)dispatch_block_t cellSubViewBlockDefault; //cell上subView的点击不传递参数


#pragma mark - cell selected

@property (nonatomic,copy)CellSelectedBlock cellSelectedBlock; //cell选中

#pragma mark - Core
/**
 * @brief 便利构造器
 *
 * @param className: 类名
 * @param heightOfCell: 此类cell的高度
 *
 */
+ (instancetype)cellConfigWithClassName:(Class)className
                            modelToShow:(id)modelToShow
                           heightOfCell:(CGFloat)heightOfCell;

+ (instancetype)cellConfigWithClassName:(Class)className
                            modelToShow:(id)modelToShow
                      modelToShowDetail:(id)modelToShowDetail
                           heightOfCell:(CGFloat)heightOfCell;


// 根据cellConfig生成cell，重用ID为cell类名
- (UITableViewCell *)cellOfCellConfigWithTableView:(UITableView *)tableView;

// 根据cellConfig生成cell，重用ID为cell类名,可使用Nib
- (UITableViewCell *)cellOfCellConfigWithTableView:(UITableView *)tableView
                                             isNib:(BOOL)isNib;

#pragma mark - Dynamic Height
// cell动态高度(计算后缓存到这个字段,避免重复计算,损耗性能)
@property (nonatomic, assign) CGFloat dynamicHeightOfCell;

// 动态计算高度，外部调用这个方法计算cell的高度
- (CGFloat)heightCachedWithCalculateBlock:(CGFloat (^)(void) )block;

#pragma mark - Assist
// 根据类名，快捷注册cell
- (void)registerForTableView:(UITableView *)tableView;

@end
