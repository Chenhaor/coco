//
//  AccountSettingViewController.m
//  YunStoreApp
//
//  Created by apple on 2017/4/26.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import "AccountSettingViewController.h"
#import "UserInformationTableViewCell.h"
#import "PersonalTableViewCell.h"
#import "AddressListViewController.h"

@interface AccountSettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong)UITableView *accountSettingTableView;

@end

@implementation AccountSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"账户设置";
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
    self.accountSettingTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    self.accountSettingTableView.delegate=self;
    self.accountSettingTableView.dataSource=self;
    self.accountSettingTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.accountSettingTableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else if(section==1){
        return 3;
    }else{
        return 1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        static NSString *UserInformationCellID=@"UserInformationCellID";
        UserInformationTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:UserInformationCellID];
        if (cell==nil) {
            cell=[[UserInformationTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:UserInformationCellID];
        }
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }else{
        static NSString *PersonalCellID=@"PersonalCellID";
        PersonalTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:PersonalCellID];
        if (cell==nil) {
            cell=[[PersonalTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PersonalCellID];
        }
        [cell.contentLabel removeFromSuperview];
        if (indexPath.section==1) {
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
        
        if (indexPath.section==1) {
            NSArray *titleArray=@[@"账户安全",@"实名认证",@"清除本地缓存"];
            cell.titleLabel.text=titleArray[indexPath.row];
        } else {
            cell.titleLabel.text=@"退出登录";
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            AddressListViewController *addressListVC=[[AddressListViewController alloc]init];
            [self.navigationController pushViewController:addressListVC animated:YES];
//            AddAddressViewController *addAddressVC=[[AddAddressViewController alloc]init];
//            [self.navigationController pushViewController:addAddressVC animated:YES];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
