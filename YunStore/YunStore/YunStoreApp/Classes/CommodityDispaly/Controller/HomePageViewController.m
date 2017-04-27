//
//  HomePageViewController.m
//  YunFuStore
//
//  Created by apple on 2017/4/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "HomePageViewController.h"
#import "CommodityModel.h"
#import "DataFalsification.h"

#import "FirstPageFlowLayout.h"
#import "CarouselCollectionViewCell.h"
#import "TagCollectionViewCell.h"
#import "FrontPageCollectionViewCell.h"
#import "ActivityPlateCollectionViewCell.h"
#import "SearchViewController.h"
#import "GWCommodityListViewController.h"

#import "ActivityModel.h"
#import "MJRefresh.h"

static NSString *const carouselCellID=@"carouselCellID";
static NSString *const tagCollectionID=@"tagCollectionID";
static NSString *const frontPageCellID=@"frontPageCellID";
static NSString *const activityCellID=@"activityCellID";
@interface HomePageViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UISearchBarDelegate>

@property(nonatomic, strong)UICollectionView *homePageCollectionView;
@property(nonatomic, strong)NSMutableArray *adsImageArray;
@property(nonatomic, strong)NSMutableArray *frontPageDatas;
@property(nonatomic, strong)NSArray *tagArray;
@property(nonatomic, strong)NSMutableArray *activityModelArray;

@property(nonatomic, strong)UIView *barImageView;


@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=DEFAULT_BACKGROUND_COLOR;
    [self loadData];
    [self createCollectionView];
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

- (void)removeNavigationUI {
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.leftButton removeFromSuperview];
    [self.searchBar removeFromSuperview];
    [self.rightButton removeFromSuperview];
}

-(void)loadNavigationUI{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"homeTabBarBack"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
//    self.navigationController.navigationBar.barStyle=UIBarStyleBlackOpaque;
//        [self.navigationController.navigationBar setBackgroundColor:[UIColor whiteColor]];
    _barImageView = self.navigationController.navigationBar.subviews.firstObject;
    _barImageView.alpha=0.6;
    
    _searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(60, 0, kScreenWidth-120, 30)];
    _searchBar.placeholder=@"新品下单立减100！";
    _searchBar.delegate=self;
    _searchBar.alpha=0.6;
    [self.navigationController.navigationBar addSubview:_searchBar];
    
    UIView *backView=[UIView new];
    backView.frame=_searchBar.bounds;
    [_searchBar addSubview:backView];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
    [backView addGestureRecognizer:tap];
    
    self.leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.leftButton.frame = CGRectMake(15, 0, 30,30);
    [self.leftButton setImage:[UIImage imageNamed:@"2Dbarcode"] forState:UIControlStateNormal];
//    [self.leftButton setTitle:@"扫描" forState:UIControlStateNormal];
//    self.leftButton.titleLabel.font=[UIFont systemFontOfSize:13];
//    self.leftButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.navigationController.navigationBar addSubview:self.leftButton];
    
    self.rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.rightButton.frame = CGRectMake(kScreenWidth - 40, 0, 30, 30);
    [self.rightButton setImage:[UIImage imageNamed:@"yf_message@2x"] forState:UIControlStateNormal];
    //    [self.rightButton setTitle:@"消息" forState:UIControlStateNormal];
    //    self.rightButton.titleLabel.font=[UIFont systemFontOfSize:13];
    //    self.rightButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    [self.navigationController.navigationBar addSubview:self.rightButton];
}

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    
    return NO;
}

-(void)loadData{
    
    DataFalsification *dataFalsification=[[DataFalsification alloc]init];
    _frontPageDatas=[dataFalsification frontPageData];
    _tagArray=[dataFalsification homePageTagImageAndTitle];
    _activityModelArray=[dataFalsification activityPlateData];
    
    _adsImageArray=[NSMutableArray new];
    for (int a=0; a<4; a++) {
        //        NSString *imageStr=[NSString stringWithFormat:@"ADImage%d",a];
        NSString *imageStr=@"YF_adImge";
        [_adsImageArray addObject:imageStr];
    }
    [self.homePageCollectionView.mj_footer endRefreshing];
    [self.homePageCollectionView.mj_header endRefreshing ];
}

-(void)createCollectionView{
    FirstPageFlowLayout *flowlayout=[[FirstPageFlowLayout alloc]init];
    flowlayout.activityModelArray=_activityModelArray;
    self.homePageCollectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, -44, kScreenWidth, kScreenHeight+44) collectionViewLayout:flowlayout];
    self.homePageCollectionView.dataSource=self;
    self.homePageCollectionView.delegate=self;
    self.homePageCollectionView.backgroundColor=DEFAULT_BACKGROUND_COLOR;
    [self registerClass];
    [self.view addSubview:self.homePageCollectionView];
    self.homePageCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData];
    }];
    self.homePageCollectionView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadData];
    }];
}

-(void)registerClass{
    [self.homePageCollectionView registerClass:[CarouselCollectionViewCell class] forCellWithReuseIdentifier:carouselCellID];
    [self.homePageCollectionView registerClass:[TagCollectionViewCell class] forCellWithReuseIdentifier:tagCollectionID];
    [self.homePageCollectionView registerClass:[FrontPageCollectionViewCell class] forCellWithReuseIdentifier:frontPageCellID];
    [self.homePageCollectionView registerClass:[ActivityPlateCollectionViewCell class] forCellWithReuseIdentifier:activityCellID];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"offset---scroll:%f",self.homePageCollectionView.contentOffset.y);
    
    CGFloat minAlphaOffset = -181;
    CGFloat maxAlphaOffset = 370/2-64;
    CGFloat offset = scrollView.contentOffset.y;
    CGFloat alpha = (offset - minAlphaOffset) / (maxAlphaOffset - minAlphaOffset);
    _barImageView.alpha = MAX(alpha, 0.6) ;
}

-(void)tapClick:(UITapGestureRecognizer *)tap{
    
    SearchViewController *searchVC=[[SearchViewController alloc]init];
    searchVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:searchVC animated:YES];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 4;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (section==0) {
        return 1;
    }else if(section==1){
        return 10;
    }else if(section==2){
        return 1;
    }else{
        return _activityModelArray.count;
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        CarouselCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:carouselCellID forIndexPath:indexPath];
        //伪造轮播图图片
        cell.adDataArry=_adsImageArray;
        return cell;
    }else if(indexPath.section==1){
        TagCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:tagCollectionID forIndexPath:indexPath];
        cell.tagImageView.image=[UIImage imageNamed:_tagArray[0][indexPath.row]];
        cell.tagLabel.text=_tagArray[1][indexPath.row];
        return cell;
    }else if(indexPath.section==2){
        FrontPageCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:frontPageCellID forIndexPath:indexPath];
        cell.adDataArry=_frontPageDatas;
        return cell;
    }else{
        ActivityPlateCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:activityCellID forIndexPath:indexPath];
        ActivityModel *model=_activityModelArray[indexPath.row];
        cell.model=model;
        return cell;
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section>2) {
        
    }else if (indexPath.section==1){
        GWCommodityListViewController *commodityListVC=[[GWCommodityListViewController alloc]init];
        commodityListVC.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:commodityListVC animated:NO];
    }
}

@end
