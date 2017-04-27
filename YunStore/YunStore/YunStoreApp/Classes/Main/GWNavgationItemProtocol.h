//
//  GWNavgationItemProtocol.h
//  YunStoreApp
//
//  Created by apple on 2017/4/20.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol GWNavgationItemProtocol <NSObject>

@optional
    
- (UIBarButtonItem *)setNavigationItemLeftBarButtomImageWithName:(NSString *)imageName;

- (UIBarButtonItem *)setNavigationItemLeftBarButtomWithTitle:(NSString *)title
                               titleNormalColor:(UIColor *)normalColor
                               titleSelectColor:(UIColor *)selectColor;
    
- (UIBarButtonItem *)setNavigationItemRightBarButtomImageWithName:(NSString *)imageName;

- (UIBarButtonItem *)setNavigationItemRightBarButtomWithTitle:(NSString *)title
                                titleNormalColor:(UIColor *)normalColor
                                titleSelectColor:(UIColor *)selectColor;
    
- (void)navigationItemRightBarButtomEvent:(id)sender;
- (void)navigationItemLeftBarButtomEvent:(id)sender;

@end

