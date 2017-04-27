//
//  GWBaseViewController.m
//  YunStoreApp
//
//  Created by apple on 2017/4/20.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import "GWBaseViewController.h"

#import "UIButton+EnlargeEdge.h"

@interface GWBaseViewController ()

@end

@implementation GWBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.navigationController.viewControllers.count > 1) 
        [self setNavBackBtn];
    
    self.view.backgroundColor = DEFAULT_BACKGROUND_COLOR;
}

    
- (void)navBackBtnAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark private methods

- (void)setNavBackBtn
{
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 40)];
    [backBtn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateHighlighted];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    [backBtn addTarget:self action:@selector(navBackBtnAction) forControlEvents:UIControlEventTouchUpInside];
}
    
- (UIBarButtonItem *)getItemBarWithImagName:(NSString *)imageName
                                   selector:(SEL)selector
{
    UIBarButtonItem *barBtnItem = nil;
    if (imageName && selector)
    {
        UIImage *img = [UIImage imageNamed:imageName];
            
        UIButton *barBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        barBtn.frame = CGRectMake(0, 0, 40, 40);
        [barBtn setImage:img forState:UIControlStateNormal];
        [barBtn addTarget:self
                   action:selector
        forControlEvents:UIControlEventTouchUpInside];
        [barBtn setEnlargeEdgeWithTop:15 right:15 bottom:15 left:15];
        barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:barBtn];
    }
        
    return barBtnItem;
}
    
- (UIBarButtonItem *)getItemBarWithTitle:(NSString *)title
                                selector:(SEL)selector
                        titleNormalColor:(UIColor *)normalColor
                        titleSelectColor:(UIColor *)selectColor;
{
    UIBarButtonItem *barBtnItem = nil;
    if (title && selector)
    {
        UIButton *barBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        barBtn.frame = CGRectMake(0, 0, 48, 30);
        [barBtn setTitle:title
                forState:UIControlStateNormal];
        [barBtn setTitleColor:normalColor
                     forState:UIControlStateNormal];
        [barBtn setTitleColor:selectColor
                     forState:UIControlStateSelected];
        [barBtn.titleLabel setFont:[UIFont systemFontOfSize:17]];
        [barBtn addTarget:self
                action:selector
             forControlEvents:UIControlEventTouchUpInside];
        barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:barBtn];
    }
        
    return barBtnItem;
}
    
#pragma mark GWNavgationItem
- (UIBarButtonItem *)setNavigationItemLeftBarButtomImageWithName:(NSString *)imageName
{
    if (imageName)
    {
        SEL selector = @selector(navigationItemLeftBarButtomEvent:);
        return self.navigationItem.leftBarButtonItem = [self getItemBarWithImagName:imageName
                                                                    selector:selector];
    }
    return nil;
}
    
- (UIBarButtonItem *)setNavigationItemLeftBarButtomWithTitle:(NSString *)title
                               titleNormalColor:(UIColor *)normalColor
                               titleSelectColor:(UIColor *)selectColor
{
    if (title)
    {
        SEL selector = @selector(navigationItemRightBarButtomEvent:);
        return self.navigationItem.leftBarButtonItem = [self getItemBarWithTitle:title
                                                                 selector:selector
                                                         titleNormalColor:normalColor
                                                         titleSelectColor:selectColor];
    }
    return nil;
}
    
- (UIBarButtonItem *)setNavigationItemRightBarButtomImageWithName:(NSString *)imageName
{
    if (imageName)
    {
        SEL selector = @selector(navigationItemRightBarButtomEvent:);
        return self.navigationItem.rightBarButtonItem = [self getItemBarWithImagName:imageName
                                                                     selector:selector];
    }
    return nil;
}
    
- (UIBarButtonItem *)setNavigationItemRightBarButtomWithTitle:(NSString *)title
                                titleNormalColor:(UIColor *)normalColor
                                titleSelectColor:(UIColor *)selectColor
{
    if (title)
    {
        SEL selector = @selector(navigationItemRightBarButtomEvent:);
        return self.navigationItem.rightBarButtonItem = [self getItemBarWithTitle:title
                                                                  selector:selector
                                                          titleNormalColor:normalColor
                                                          titleSelectColor:selectColor];
    }
    return nil;
}
    
- (void)navigationItemRightBarButtomEvent:(id)sender
{
        
}
    
- (void)navigationItemLeftBarButtomEvent:(id)sender
{
        
}

@end
