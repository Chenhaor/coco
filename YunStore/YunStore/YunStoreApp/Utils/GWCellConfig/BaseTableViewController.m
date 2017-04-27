//
//  BaseTableViewController.m
//  GWCellConfigDemo
//
//  Created by yangye on 16/5/11.
//  Copyright © 2016年. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation BaseTableViewController

-(instancetype)init{
    
    if (!(self = [super init]))
        return nil;
    self.mRows = 10;
    self.mStart = 1;
    self.isShowHeaderRefresh = YES;
    self.isShowFooterRefresh = YES;
    return self;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }
    return _tableView;
}

- (NSMutableArray *)itemsArrM {
    if (_itemsArrM == nil) {
        self.itemsArrM = [NSMutableArray array];
    }
    return _itemsArrM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setupRefresh {
    // 1.下拉刷新
    if (self.isShowHeaderRefresh) {
        
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    }
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    if(self.isShowFooterRefresh) {
        
        self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    }
}

- (void)headerEndRereshing {
    
    [self.tableView.mj_header endRefreshing];
}

- (void)footerEndRereshing {
    
    [self.tableView.mj_footer endRefreshing];
}

//MARK :下拉刷新
- (void)headerRereshing {
    _requestMode = Refresh_Mode;
    self.mStart = 1;
}
//MARK:上拉加载更多
- (void)footerRereshing {
    _requestMode = More_Mode;
    self.mStart++;
}

#pragma mark - TableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.itemsArrM.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.itemsArrM[section] count];
}

#pragma mark 设置cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 拿到cellConfig
    GWCellConfig *cellConfig = self.itemsArrM[indexPath.section][indexPath.row];
    // 拿到对应cell并根据模型显示
    UITableViewCell *cell = [cellConfig cellOfCellConfigWithTableView:tableView];
    return cell;
}

#pragma mark - TableView Delegate
#pragma mark 选中cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GWCellConfig *cellConfig = self.itemsArrM[indexPath.section][indexPath.row];

    if (cellConfig.cellSelectedBlock) {
        cellConfig.cellSelectedBlock(indexPath.section,indexPath.row);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GWCellConfig *cellConfig = self.itemsArrM[indexPath.section][indexPath.row];
    
    if (cellConfig.dynamicHeightOfCell > 0.0) {
        return cellConfig.dynamicHeightOfCell;
    }

    return cellConfig.heightOfCell;
}

#pragma mark Header
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
