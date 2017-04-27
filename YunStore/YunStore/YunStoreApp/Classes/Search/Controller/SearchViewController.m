//
//  SearchViewController.m
//  YunStoreApp
//
//  Created by apple on 2017/4/21.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchTableViewCell.h"

@interface SearchViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UIView *_searchBack;
    
}

@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UITableView *searchTableView;

@property (nonatomic, strong)NSMutableArray *historyDatas;
@property (nonatomic, strong)NSMutableArray *hotDatas;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self loadDatas];
    [self createtabView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadNavigationUI];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [_searchBack removeFromSuperview];
//    [self removeNavigationUI];
}

- (void)removeNavigationUI {
    
//    [self.leftButton removeFromSuperview];
    [_searchBack removeFromSuperview];
//    [self.searchBar removeFromSuperview];
//    [self.rightButton removeFromSuperview];
}

-(void)loadNavigationUI{
    self.navigationController.navigationBar.barTintColor = DEFAULT_BACKGROUND_COLOR;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    [self creatSearchBar];
    
    _leftButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 250)];
    [_leftButton setImage:[UIImage imageNamed:@"getBack"] forState:UIControlStateNormal];
    [_leftButton addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBaritem=[[UIBarButtonItem alloc]initWithCustomView:_leftButton];
    self.navigationItem.leftBarButtonItem=leftBaritem;
    
}

-(void)creatSearchBar{
    
    _searchBack=[[UIView alloc]initWithFrame:CGRectMake(50.0f, 0, kScreenWidth-50, 44)];
    _searchBack.backgroundColor=[UIColor clearColor];
    
    //导航条的搜索条
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0.0f,0.0f,CGRectGetWidth(_searchBack.frame)-10,44.0f)];
    _searchBar.delegate = self;
    //    _searchBar.tintColor=SECOND_DEGREE_COLOR;
    [_searchBar setImage:[UIImage imageNamed:@"xiaoxinl_icon_search"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    [_searchBar setPlaceholder:@"请输入搜索内容"];
    _searchBar.showsCancelButton=YES;
    
    for (UIView *view in [[_searchBar.subviews lastObject] subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *cancelBtn = (UIButton *)view;
            [cancelBtn setTitle:@"搜索" forState:UIControlStateNormal];
            [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
    _searchBar.backgroundImage=[self imageWithColor:[UIColor clearColor] size:_searchBar.bounds.size];
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
//    [_searchBack removeFromSuperview];
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)loadDatas{
    self.historyDatas=[[NSMutableArray alloc]initWithArray:@[@"华为手机",@"无烟锅",@"OPPO手机",@"洗面奶",@"洗衣机",@"家电"]];
    self.hotDatas=[[NSMutableArray alloc]initWithArray:@[@"茶杯",@"数据线",@"华为手机",@"无烟锅",@"OPPO手机",@"洗面奶",@"洗衣机",@"家电"]];
    [self.searchTableView reloadData];
}
//搜索调用
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{

}
//搜索调用
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
}
-(void)createtabView{
    self.searchTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    self.searchTableView.delegate=self;
    self.searchTableView.dataSource=self;
    self.searchTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.searchTableView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.searchTableView];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [_searchBar endEditing:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"SearchTableViewCellID";
    SearchTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell==nil) {
        cell=[[SearchTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    if (indexPath.section==0) {
        cell.titleArray =_historyDatas;
    }else{
        cell.titleArray=_hotDatas;
    }
    cell.searchButnClick = ^(NSString *searckStr) {
        _searchBar.text=searckStr;
    };
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat spaceheight=15;
    CGFloat butnHeight=25;
    if (indexPath.section==0) {
        return ((_historyDatas.count/4)+1)*(spaceheight+butnHeight);
    }else{
        return ((_hotDatas.count/4)+1)*(spaceheight+butnHeight);
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *sectionView=[UIView new];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(15, 0, 200, 40)];
    if (section==0) {
        label.text=@"历史记录";
    }else{
        label.text=@"热搜";
    }
    [sectionView addSubview:label];
    return sectionView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
