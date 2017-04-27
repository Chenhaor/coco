//
//  PersonalViewController.m
//  YunStoreApp
//
//  Created by apple on 2017/4/26.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import "PersonalViewController.h"
#import "PersonalTableViewCell.h"
#import "HeadPortraitTableViewCell.h"

@interface PersonalViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong)UITableView *personalTableView;
@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"个人信息";
    self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];
    self.view.backgroundColor=DEFAULT_BACKGROUND_COLOR;
    
    [self createBarButtonItem];
    [self createTableView];
}
-(void)createBarButtonItem{
    UIButton *leftButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    [leftButton setImage:[UIImage imageNamed:@"getBack"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBaritem=[[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem=leftBaritem;
}

-(void)createTableView{
    self.personalTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 1, kScreenWidth, kScreenHeight-1) style:UITableViewStyleGrouped];
    self.personalTableView.delegate=self;
    self.personalTableView.dataSource=self;
    self.personalTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.personalTableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else{
        return 4;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        static NSString *HeadPortraitCellID=@"HeadPortraitCellID";
        HeadPortraitTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:HeadPortraitCellID];
        if (cell==nil) {
            cell=[[HeadPortraitTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HeadPortraitCellID];
        }
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }else{
        static NSString *PersonalCellID=@"PersonalCellID";
        PersonalTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:PersonalCellID];
        if (cell==nil) {
            cell=[[PersonalTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PersonalCellID];
        }
        if (indexPath.row>0) {
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
        if (indexPath.row>1) {
            [cell.contentLabel removeFromSuperview];
        }
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 100;
    }else{
        return 50;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

-(void)leftClick{
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
