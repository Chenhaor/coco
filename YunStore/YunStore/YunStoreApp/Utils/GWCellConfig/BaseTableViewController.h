//
//  BaseTableViewController.h
//
//  Created by yangye on 16/5/11.
//  Copyright © 2016年. All rights reserved.
//

typedef NS_ENUM(NSInteger, REQUEST_MODE) {
    Refresh_Mode = 0,//更新
    More_Mode = 1,   //更多
    Other_Mode
};

#import "GWBaseViewController.h"
#import "GWCellConfig.h"
#import "MJRefresh.h"

@interface BaseTableViewController : GWBaseViewController

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic,assign)BOOL isShowFooterRefresh;//下拉更多,默认为YES
@property (nonatomic,assign)BOOL isShowHeaderRefresh; //是否有下拉刷新 一般搜索不带有下拉刷新

@property(nonatomic,assign)NSInteger  mStart;
@property(nonatomic,assign)NSUInteger  mRows; //本地请求每次获取的长度(自定义的限制,默认10)
@property(nonatomic,assign)NSInteger  sum; //服务器返回的总长度

@property(nonatomic,assign)REQUEST_MODE requestMode;

- (void)setupRefresh;

- (void)headerRereshing;
- (void)footerRereshing;

- (void)headerEndRereshing;
- (void)footerEndRereshing;

/// cellConfig数据源
@property (nonatomic, strong) NSMutableArray *itemsArrM;

@end
