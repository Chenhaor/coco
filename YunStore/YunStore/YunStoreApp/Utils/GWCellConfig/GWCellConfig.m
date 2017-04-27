//
//  CellConfig.m
//
//  Created by yangye on 15/2/25.
//  Copyright (c) 2015年. All rights reserved.
//

#import "GWCellConfig.h"

@implementation GWCellConfig

#pragma mark - Core
/**
 * @brief 便利构造器
 *
 * @param className:类名
 * @param showInfoMethod:此类cell用来显示数据模型的方法， 如@selector(showInfo:)
 * @param heightOfCell:此类cell的高度
 *
 *
 */
+ (instancetype)cellConfigWithClassName:(Class)className
                            modelToShow:(id)modelToShow
                           heightOfCell:(CGFloat)heightOfCell
{
    return [GWCellConfig cellConfigWithClassName:className
                                     modelToShow:modelToShow
                               modelToShowDetail:nil
                                    heightOfCell:heightOfCell];
}

+ (instancetype)cellConfigWithClassName:(Class)className
                            modelToShow:(id)modelToShow
                      modelToShowDetail:(id)modelToShowDetail
                           heightOfCell:(CGFloat)heightOfCell;
{
    GWCellConfig *cellConfig = [GWCellConfig new];
    
    cellConfig.className = NSStringFromClass(className);
    cellConfig.modelToShow = modelToShow;
    cellConfig.modelToShowDetail = modelToShowDetail;
    cellConfig.heightOfCell = heightOfCell;
    
    //默认配置cell数据的方法
#pragma clang diagnostic push
    
#pragma clang diagnostic ignored"-Wundeclared-selector"
    
    cellConfig.showInfoMethod = modelToShowDetail ? @selector(configCell:detailModel:) : @selector(configCell:);
    
#pragma clang diagnostic pop
    
    return cellConfig;
}

// 根据cellConfig生成cell，重用ID为cell类名
- (UITableViewCell *)cellOfCellConfigWithTableView:(UITableView *)tableView
{
    return [self cellOfCellConfigWithTableView:tableView isNib:NO];
}

// 根据cellConfig生成cell，重用ID为cell类名,可使用Nib
- (UITableViewCell *)cellOfCellConfigWithTableView:(UITableView *)tableView
                                             isNib:(BOOL)isNib
{
    Class cellClass = NSClassFromString(self.className);
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[self cellID]];
    
    if (!cell) {
        
        // 加入使用nib的方法
        if (isNib && self.className.length &&![self.className isEqualToString:@"UITableViewCell"]) {
            NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:self.className owner:nil options:nil];
            
            for (id obj in nibs) {
                if ([obj isKindOfClass: cellClass]) {
                    cell = obj;
                }
            }
            
            if (!cell) {
                DLog(@"Please Check Nib File About %@", cellClass);
            }
            
        } else {
            cell = [[cellClass?:[UITableViewCell class] alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:[self cellID]];
        }
    }
    
    __weak typeof(self) weakSelf = self;
    cell.cellBlockWithParam = ^(id subView,id value) {
        weakSelf.cellSubViewBlockWithParam(subView,value);
    };
    
    cell.cellBlockDefault = ^() {
        weakSelf.cellSubViewBlockDefault();
    };
    
    // 设置cell
    if (self.showInfoMethod && [cell respondsToSelector:self.showInfoMethod]) {
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        if (self.modelToShowDetail)
            [cell performSelector:self.showInfoMethod withObject:self.modelToShow withObject:self.modelToShowDetail];
        else
            [cell performSelector:self.showInfoMethod withObject:self.modelToShow];
#pragma clang diagnostic pop
        
    }
    
    return cell;
}


#pragma mark - Dynamic Height
// 缓存高度
- (CGFloat)heightCachedWithCalculateBlock:(CGFloat (^)(void) )block
{
    if (!self.dynamicHeightOfCell && block) {
        // 没有计算过高度
        // 计算高度并保存
        self.dynamicHeightOfCell = block();
    }
    
    return self.dynamicHeightOfCell;
}

#pragma mark - Assist
// 根据类名，快捷注册cell
- (void)registerForTableView:(UITableView *)tableView
{
    [tableView registerNib:[UINib nibWithNibName:self.className bundle:nil] forCellReuseIdentifier:[self cellID]];
}

- (NSString *)cellID
{
    if (self.reuseID.length) {
        return self.reuseID;
    }
    return self.className;
}

@end
