//
//  YFNavigationController.m
//  YunFuStore
//
//  Created by apple on 2017/4/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "GWBaseNavigationController.h"

@interface GWBaseNavigationController ()

@end

@implementation GWBaseNavigationController

+ (void)initialize
{
    [self setupNavBarTheme];
}
    
/**
* 设置导航栏主题
*/
+ (void)setupNavBarTheme
{
    // 取出appearance对象
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    navBar.backgroundColor = [UIColor whiteColor];
    
    navBar.translucent = NO;
    
    [navBar setShadowImage:[UIImage new]];
    // 设置标题属性
    [navBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor blackColor]}];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {

        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
