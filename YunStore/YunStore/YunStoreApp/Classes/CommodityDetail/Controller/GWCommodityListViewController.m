//
//  GWCommodityListViewController.m
//  YunStoreApp
//
//  Created by apple on 2017/4/25.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import "GWCommodityListViewController.h"
#import "GWListTitlButn.h"
#import "CommodityDetailTableViewCell.h"
#import "CommondityGridTableViewCell.h"

@interface GWCommodityListViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>{
    UIView *_searchBack;
}

@property(nonatomic, strong)UITableView *listTableView;

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;

@end
CGFloat titleButnHeight=34;
@implementation GWCommodityListViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self loadNavigationUI];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [_searchBack removeFromSuperview];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self createUI];
}

-(void)loadNavigationUI{
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    [self creatSearchBar];
    
    _leftButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    [_leftButton setImage:[UIImage imageNamed:@"getBack"] forState:UIControlStateNormal];
    [_leftButton addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBaritem=[[UIBarButtonItem alloc]initWithCustomView:_leftButton];
    self.navigationItem.leftBarButtonItem=leftBaritem;
    
    _rightButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    [_rightButton setImage:[UIImage imageNamed:@"CommondityGrid"] forState:UIControlStateNormal];
    [_rightButton setImage:[UIImage imageNamed:@"CommondityList"] forState:UIControlStateSelected];
    [_rightButton addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBaritem=[[UIBarButtonItem alloc]initWithCustomView:_rightButton];
    self.navigationItem.rightBarButtonItem=rightBaritem;
}

-(void)creatSearchBar{
    
    _searchBack=[[UIView alloc]initWithFrame:CGRectMake(50.0f, 0, kScreenWidth-100, 44)];
    _searchBack.backgroundColor=[UIColor clearColor];
    
    //导航条的搜索条
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0.0f,0.0f,CGRectGetWidth(_searchBack.frame)-10,36.0f)];
    _searchBar.delegate = self;
    //    _searchBar.tintColor=SECOND_DEGREE_COLOR;
    //    [_searchBar setImage:[UIImage imageNamed:@"xiaoxinl_icon_search"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    [_searchBar setPlaceholder:@"请输入搜索内容"];

    UIView *searchTextField = [[[_searchBar.subviews firstObject] subviews]lastObject];
    searchTextField.backgroundColor = DEFAULT_BACKGROUND_COLOR;
    _searchBar.backgroundImage=[self imageWithColor:DEFAULT_BACKGROUND_COLOR size:_searchBar.bounds.size];
    [_searchBar.layer setCornerRadius:18];
    [_searchBar.layer setMasksToBounds:YES];
    [_searchBack addSubview:_searchBar];
    
    [self.navigationController.navigationBar addSubview:_searchBack];
}

//取消searchbar背景色
- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
-(void)leftClick{
    
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)rightClick{
    _rightButton.selected=!_rightButton.selected;
    [self.listTableView reloadData];
}

-(void)createUI{
    GWListTitlButn *butnView=[[GWListTitlButn alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, titleButnHeight)];
    [self.view addSubview:butnView];
    
    _listTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, titleButnHeight, kScreenWidth, kScreenHeight-titleButnHeight)];
    _listTableView.delegate=self;
    _listTableView.dataSource=self;
    _listTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_listTableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_rightButton.selected) {
        return 5;
    }else{
        return 10;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_rightButton.selected) {
        static NSString *GridCellID=@"CommondityGridID";
        CommondityGridTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:GridCellID];
        if (cell==nil) {
            cell=[[CommondityGridTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:GridCellID];
        }
        return cell;
    }else{
        static NSString *cellID=@"CommodityDetailID";
        CommodityDetailTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell==nil) {
            cell=[[CommodityDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_rightButton.selected) {
        return 230;
    }else{
        return 110;
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [_searchBar endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
