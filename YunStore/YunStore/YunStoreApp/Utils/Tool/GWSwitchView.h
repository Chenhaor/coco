//
//  GWSwitchView.h
//  Holoera
//
//  Created by yangye on 16/10/19.
//  Copyright © 2016年. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SelectedStyle) {
    LineView_Style = 0,//底部线条样式 默认样式
    SelectBox_Style = 1,   //选择框样式
};

@class GWSwitchView;

@protocol GWSwitchViewDelegate <NSObject>

- (void)switchView:(GWSwitchView *)switchView didselectTab:(NSInteger)num;

@end

@interface GWSwitchView : UIControl

@property (nonatomic, strong) NSArray *conditions;
@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, assign) SelectedStyle selectedStyle;

@property (nonatomic, strong) UIColor *lineViewColor;

@property (nonatomic, strong) UIImage *selectCheckedImg;
@property (nonatomic, strong) UIImage *swithchViewBgImg;

@property (nonatomic, strong) UIFont *titleFont;

@property (nonatomic, strong) UIColor *selectedTitleColor;

@property (nonatomic, strong) UIColor *unSelectedTitleColor;


@property (nonatomic, weak) id<GWSwitchViewDelegate> delegate;

@end
