//
//  ChoiceAddressBackView.h
//  YunStoreApp
//
//  Created by apple on 2017/4/27.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChoiceAddressBackView : UIView

@property(nonatomic, strong)NSMutableArray *provinceArray;
@property(nonatomic, strong)NSMutableArray *cityeArray;
@property(nonatomic, strong)NSMutableArray *areaArray;
@property(nonatomic, strong)NSMutableArray *streetArray;
@property(nonatomic, strong)NSMutableArray *AllAddressArray;

@property(nonatomic, strong)UIButton *deleteButn;


@end
