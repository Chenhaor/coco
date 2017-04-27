//
//  scrollCollectionViewCell.h
//  YunStoreApp
//
//  Created by apple on 2017/4/27.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface scrollCollectionViewCell : UICollectionViewCell

@property(nonatomic, strong)NSMutableArray *addressArray;
@property(nonatomic, strong)NSIndexPath *cellIndexPath;
@property(nonatomic, strong)void(^choiceAddress)(NSString *addressStr);
@end
