//
//  UITableViewCell+Help.m
//
//  Created by yangye on 16/9/30.
//  Copyright © 2016年. All rights reserved.
//

#import "UITableViewCell+Help.h"
#import <objc/runtime.h>

static const char *UITableViewCell_CellBlock = "UITableViewCell_CellBlock";
static const char *UITableViewCell_CellBlockDefault = "UITableViewCell_CellBlockDefault";

@implementation UITableViewCell (Help)

- (void)setCellBlockWithParam:(CellSubViewActionBlock)cellBlockWithParam
{

    objc_setAssociatedObject(self, UITableViewCell_CellBlock, cellBlockWithParam, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CellSubViewActionBlock)cellBlockWithParam
{
    return objc_getAssociatedObject(self, UITableViewCell_CellBlock);
}

- (void)setCellBlockDefault:(dispatch_block_t)cellBlockDefault
{
    objc_setAssociatedObject(self, UITableViewCell_CellBlockDefault, cellBlockDefault, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (dispatch_block_t)cellBlockDefault
{
    return objc_getAssociatedObject(self, UITableViewCell_CellBlockDefault);
}

@end
