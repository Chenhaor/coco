//
//  GWOrderChildViewController.m
//  YunStoreApp
//
//  Created by apple on 2017/4/25.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import "GWOrderChildViewController.h"
#import "GWOrderManagerCell.h"

@interface GWOrderChildViewController ()

@end

@implementation GWOrderChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setLayout];
    [self configData];
}

- (void)setLayout
{
    self.tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
}

- (void)configData
{
    for (int i = 0;  i < 3; i ++)
    {
        GWCellConfig *cellConfig = [GWCellConfig cellConfigWithClassName:[GWOrderManagerCell class]
                                                             modelToShow:nil
                                                            heightOfCell:195.0];
        [self.itemsArrM addObject:@[cellConfig]];
    }
    
    [self.tableView reloadData];
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
