//
//  ClassDetailFlowLayout.m
//  YunFuStore
//
//  Created by apple on 2017/4/11.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ClassDetailFlowLayout.h"

static const CGFloat ItemMaigin = 0;
@implementation ClassDetailFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
    [self setScrollDirection:UICollectionViewScrollDirectionVertical];
//    self.itemSize = CGSizeMake((kScreenWidth-110)/3, (kScreenWidth-110)/3+20);
    self.minimumLineSpacing=0;
    self.minimumInteritemSpacing=0;
    self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.headerReferenceSize=CGSizeMake(kScreenWidth-110, 30);
    
    self.minimumLineSpacing = ItemMaigin;
}


@end
