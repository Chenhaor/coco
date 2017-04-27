//
//  MineViewController.m
//  YunFuStore
//
//  Created by apple on 2017/4/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "MineViewController.h"
#import "DataFalsification.h"
#import "CommodityModel.h"
#import "MineHeadView.h"
#import "GWBaseNavigationController.h"
#import "MeFunctionTableViewCell.h"
#import "RecomTableViewCell.h"
#import "GWOrderManagerViewController.h"
#import "AccountSettingViewController.h"

@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property(nonatomic, strong)NSMutableArray *mineIconArray;
@property(nonatomic, strong)NSMutableArray *modelArray;

@property(nonatomic, strong)UIView *barImageView;

@property(nonatomic, strong)UITableView *meTableView;
@property(nonatomic, strong)MineHeadView *mineHeadView;
@end

@implementation MineViewController

-(MineHeadView *)mineHeadView{
    if (_mineHeadView==nil) {
        _mineHeadView=[[MineHeadView alloc]initWithFrame:CGRectMake(0,0,kScreenWidth, 175)];
        _mineHeadView.controller=self;
        [self.view addSubview:_mineHeadView];
    }
    return _mineHeadView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DataFalsification *dataFalsification=[DataFalsification new];
    _mineIconArray=[dataFalsification createMineTagDataArray];
    _modelArray=[dataFalsification createHomePageCommodityData];
    
    [self createTabView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self loadNavigationUI];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.subviews.firstObject.alpha = 1.0;
    [self removeNavigationUI];
}

-(void)loadNavigationUI{
    //   [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
    //    self.navigationController.navigationBar.barTintColor = DEFAULT_NAVIGATIONBAR_COLOR;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"me_NavBar"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    _barImageView = self.navigationController.navigationBar.subviews.firstObject;
    _barImageView.alpha=0;
    
    self.navigationController.navigationBar.barStyle=UIBarStyleBlackOpaque;
    //    [self.navigationController.navigationBar setBackgroundColor:[UIColor whiteColor]];
    UIBarButtonItem *setButnItem=[[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"me_setting"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(setBarButtonClick)];
    
    UIBarButtonItem *messageButnItem=[[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"me_message"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(messageBarButtonClick)];
    [self.navigationItem setRightBarButtonItems:@[messageButnItem,setButnItem]];
}

- (void)removeNavigationUI {
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}


-(void)createTabView{
    self.meTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, -64, kScreenWidth, kScreenHeight-49) style:UITableViewStyleGrouped];
    self.meTableView.contentOffset=CGPointMake(1, 0);
    self.meTableView.dataSource=self;
    self.meTableView.delegate=self;
    self.meTableView.backgroundColor=RGBCOLOR(238, 238, 238);
    self.meTableView.tableHeaderView=self.mineHeadView;
    [self.view addSubview:self.meTableView];
}

-(void)setBarButtonClick{
    AccountSettingViewController *accountSetVC=[[AccountSettingViewController alloc]init];
    accountSetVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:accountSetVC animated:YES];
}

-(void)messageBarButtonClick{
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat minAlphaOffset = 0;
    CGFloat maxAlphaOffset = 175-64;
    CGFloat offset = scrollView.contentOffset.y;
    CGFloat alpha = (offset - minAlphaOffset) / (maxAlphaOffset - minAlphaOffset);
    _barImageView.alpha = alpha;
}

#pragma mark btnAction
- (void)meFuntionCellSubViewAction:(NSString *)subViewName
{
    if ([subViewName isEqualToString:@"我的订单"]) {
        GWOrderManagerViewController *vc = [[GWOrderManagerViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

#pragma UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else if(section==1){
        return 1;
    }else if (section==2){
        return 2;
    }else{
        return _modelArray.count/2+(_modelArray.count%2==1?1:0);
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section<3) {
        static NSString *functionTableCell=@"FunctionTableCell";
        MeFunctionTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:functionTableCell];
        if (cell==nil) {
            cell=[[MeFunctionTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:functionTableCell];
        }
        if (indexPath.section==0) {
            NSMutableArray *array=_mineIconArray[0];
            cell.TagModelArray=array;
        }else if (indexPath.section==1){
            NSMutableArray *array=_mineIconArray[1];
            cell.TagModelArray=array;
        }else if (indexPath.section==2){
            NSMutableArray *array=_mineIconArray[indexPath.row+2];
            cell.TagModelArray=array;
        }
        WS(ws);
        cell.subViewClickBlock = ^(NSString *subViewName) {
            [ws meFuntionCellSubViewAction:subViewName];
        };
        
        return cell;
    }else{
        static NSString *recomTableCellID=@"recomTableCellID";
        
        RecomTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:recomTableCellID];
        if (cell==nil) {
            cell=[[RecomTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:recomTableCellID];
        }
        if (_modelArray.count>indexPath.row*2) {
            CommodityModel *leftmodel=_modelArray[indexPath.row*2];
            cell.leftmodel=leftmodel;
        }
        if (_modelArray.count>indexPath.row*2+1) {
            CommodityModel *rightmodel=_modelArray[indexPath.row*2+1];
            cell.rightmodel=rightmodel;
        }
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section<3) {
        return 85;
    }else{
        return 220;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==3) {
        UIView *view=[UIView new];
        view.backgroundColor=[UIColor whiteColor];
        UIImageView *imageView=[UIImageView new];
        imageView.image=[UIImage imageNamed:@"shopCart_recommendTitle"];
        [view addSubview:imageView];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(view);
            make.size.mas_offset(CGSizeMake(76, 16));
        }];
        return view;
    }else{
        return nil;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==3) {
        return 23;
    }else{
        return CGFLOAT_MIN;
    };
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}


@end
