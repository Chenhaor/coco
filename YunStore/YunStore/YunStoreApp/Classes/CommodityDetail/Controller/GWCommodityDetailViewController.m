//
//  GWViewController.m
//  YunStoreApp
//
//  Created by apple on 2017/4/25.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import "GWCommodityDetailViewController.h"
#import "GWSwitchView.h"
#import "GWCommodityViewController.h"
#import "GWGoodsDetailViewController.h"
#import "GWRatedViewController.h"
#import "GWCommodityDetailToolView.h"

@interface GWCommodityDetailViewController ()<GWSwitchViewDelegate>

@property (nonatomic,weak)GWSwitchView *switchView;

@end

@implementation GWCommodityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setLayout];
}

- (void)setLayout
{
    GWSwitchView *switchView = [[GWSwitchView alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    self.switchView = switchView;
    switchView.backgroundColor = [UIColor clearColor];
    switchView.selectedTitleColor = RGBCOLOR(231, 57, 0);
    switchView.unSelectedTitleColor = RGBCOLOR(0, 0, 0);
    switchView.lineViewColor = RGBCOLOR(231, 57, 0);
    switchView.conditions = @[@"商品",@"详情",@"评价"];
    switchView.delegate = self;
    self.navigationItem.titleView = switchView;
    
    [self createNavBarItems];
    
    self.pageContentFrame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 53.0);
    
    GWCommodityViewController *commodityVc = [[GWCommodityViewController alloc] init];
    
    GWGoodsDetailViewController *detailVc = [[GWGoodsDetailViewController alloc] init];
    
    GWRatedViewController *ratedVc = [[GWRatedViewController alloc] init];
    
    self.contentControllers = (NSArray<GWPageContentViewControllerDelegate> *)@[commodityVc,detailVc,ratedVc];
    
    GWCommodityDetailToolView *toolView = [[GWCommodityDetailToolView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 117, kScreenWidth, 53)];
    [self.view addSubview:toolView];
}

- (void)createNavBarItems
{
    UIButton *menuBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    menuBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [menuBtn setImage:[UIImage imageNamed:@"commodityDetail_menu"] forState:UIControlStateNormal];

    [menuBtn addTarget:self action:@selector(menuBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *shareBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [shareBtn setImage:[UIImage imageNamed:@"commodityDetail_share"] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(shareBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *menuBarItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
    UIBarButtonItem *shareBarItem = [[UIBarButtonItem alloc] initWithCustomView:shareBtn];
    self.navigationItem.rightBarButtonItems = @[menuBarItem,shareBarItem];
}

- (void)didShowControllerAtIndex:(NSInteger)idx
{
    self.switchView.currentIndex = idx;
}

#pragma mark btnAction
- (void)menuBtnAction:(UIButton *)btn {
    
}

- (void)shareBtnAction:(UIButton *)btn {
    
}

#pragma mark GWSwitchViewDelegate
- (void)switchView:(GWSwitchView *)switchView didselectTab:(NSInteger)num
{
    self.currentIdx = num;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
