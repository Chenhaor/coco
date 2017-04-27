//
//  GWDetailViewController.m
//  YunStoreApp
//
//  Created by apple on 2017/4/25.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import "GWGoodsDetailViewController.h"

@interface GWGoodsDetailViewController ()

@property (nonatomic,assign)NSInteger lastBtnIndex;

@end

@implementation GWGoodsDetailViewController

@synthesize pageContentFrame = _pageContentFrame;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setLayout];
}

- (void)setLayout {
    //title 为你推荐
    UIView *titleBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 32.0)];
    titleBgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:titleBgView];
    
    UIButton *commodityBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth / 3.0 - 0.5, 32)];
    commodityBtn.selected = YES;
    commodityBtn.tag = 100;
    _lastBtnIndex = 100;
    commodityBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [commodityBtn setTitle:@"商品介绍" forState:UIControlStateNormal];
    [commodityBtn setTitleColor:RGBCOLOR(0, 0, 0) forState:UIControlStateSelected];
    [commodityBtn setTitleColor:RGBCOLOR(163, 163, 163) forState:UIControlStateNormal];
    [titleBgView addSubview:commodityBtn];
    [commodityBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];

    UIView *middleLine1 = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth / 3.0 - 0.5, 6, 0.5, 20)];
    middleLine1.backgroundColor = RGBCOLOR(239, 239, 239);
    [titleBgView addSubview:middleLine1];
    
    UIButton *specBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth / 3.0, 0, kScreenWidth / 3.0, 32)];
    specBtn.tag = 101;
    specBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [specBtn setTitleColor:RGBCOLOR(0, 0, 0) forState:UIControlStateSelected];
    [specBtn setTitleColor:RGBCOLOR(163, 163, 163) forState:UIControlStateNormal];
    [specBtn setTitle:@"规格参数" forState:UIControlStateNormal];
    [titleBgView addSubview:specBtn];
    [specBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *middleLine2 = [[UIView alloc] initWithFrame:CGRectMake(2 * kScreenWidth / 3.0 - 0.5, 6, 0.5, 20)];
    middleLine2.backgroundColor = RGBCOLOR(239, 239, 239);
    [titleBgView addSubview:middleLine2];
    
    UIButton *aftermarketRepairBtn = [[UIButton alloc] initWithFrame:CGRectMake(2 * kScreenWidth / 3.0, 0, kScreenWidth / 3.0, 32)];
    aftermarketRepairBtn.tag = 102;
    aftermarketRepairBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [aftermarketRepairBtn setTitleColor:RGBCOLOR(0, 0, 0) forState:UIControlStateSelected];
    [aftermarketRepairBtn setTitleColor:RGBCOLOR(163, 163, 163) forState:UIControlStateNormal];
    [aftermarketRepairBtn setTitle:@"报装售后" forState:UIControlStateNormal];
    [titleBgView addSubview:aftermarketRepairBtn];
    [aftermarketRepairBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnAction:(UIButton *)btn
{
    btn.selected = YES;
    
    if (btn.tag != _lastBtnIndex) {
        UIButton *lastBtn = [self.view viewWithTag:_lastBtnIndex];
        lastBtn.selected = NO;
        _lastBtnIndex = btn.tag;
    }
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
