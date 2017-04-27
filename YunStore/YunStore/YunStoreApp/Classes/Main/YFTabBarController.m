//
//  YFTabBarController.m
//  YunFuStore
//
//  Created by apple on 2017/4/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "YFTabBarController.h"
#import "GWBaseNavigationController.h"
#import "HomePageViewController.h"
#import "ClassifiedViewController.h"
#import "GWShoppingCartViewController.h"
#import "MineViewController.h"

@interface YFTabBarController ()

@end

@implementation YFTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.translucent = NO;
    self.tabBar.tintColor = RGBCOLOR(233, 80, 45);
    
    [self setUpUI];
}

-(void)setUpUI
{
    NSArray *itemsTitles = @[@"首页",@"分类",@"购物车",@"我的"];
    
    NSArray *itemsImagesNomal = @[@"tab_shouye_nomal",@"tab_fenlei_nomal",@"tab_gouwuche_nomal",@"tab_wode_nomal"];
    
    NSArray *itemsImagesSelected = @[@"tab_shouye_selected",@"tab_fenlei_selected",@"tab_gouwuche_selected",@"tab_wode_selected"];
    
    NSArray *viewControllersName = @[@"HomePageViewController",@"ClassifiedViewController",@"GWShoppingCartViewController",@"MineViewController"];
    
    for (NSInteger integer=0; integer<itemsTitles.count; integer++) {
        
        Class viewControllerClass=NSClassFromString(viewControllersName[integer]);
        
        UIViewController *viewController=[[viewControllerClass alloc]init];
        
        viewController.tabBarItem=[[UITabBarItem alloc]initWithTitle:itemsTitles[integer] image:[UIImage imageNamed:itemsImagesNomal[integer]] selectedImage:[self orginalImage:itemsImagesSelected[integer]]];
        viewController.tabBarItem.imageInsets=UIEdgeInsetsMake(0, 0, 0, 0);
        
        GWBaseNavigationController *navigationController=[[GWBaseNavigationController alloc]initWithRootViewController:viewController];
        
        [self addChildViewController:navigationController];
    }
    
}

- (UIImage *)orginalImage:(NSString *)imageName
{
    UIImage *image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return image;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
