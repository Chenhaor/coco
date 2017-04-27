//
//  TagView.h
//  YunStoreApp
//
//  Created by apple on 2017/4/24.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TagModel.h"

@interface TagView : UIView

@property(nonatomic, assign)CGFloat topDistance;

@property(nonatomic, strong)TagModel *model;
@property(nonatomic, strong)UIImageView *tagImageView;
@property(nonatomic, strong)UILabel *tagLabel;
@property(nonatomic, strong)UILabel *numLabel;


@end
