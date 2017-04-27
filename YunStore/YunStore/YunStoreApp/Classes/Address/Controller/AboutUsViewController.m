//
//  AboutUsViewController.m
//  YunStoreApp
//
//  Created by apple on 2017/4/27.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import "AboutUsViewController.h"
#import "PersonalTableViewCell.h"

@interface AboutUsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong)UITableView *aboutUsTableView;
@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"关于我们";
    [self createTableView];
}
-(void)createTableView{
    self.aboutUsTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    self.aboutUsTableView.dataSource=self;
    self.aboutUsTableView.delegate=self;
    self.aboutUsTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.aboutUsTableView];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID=@"PersonalCellID";
    PersonalTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[PersonalTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    NSArray *array=@[@"版本更新",@"服务协议",@"使用帮助"];
    cell.titleLabel.text=array[indexPath.row];
    cell.contentLabel.text=nil;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
