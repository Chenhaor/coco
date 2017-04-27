//
//  AddressListViewController.m
//  YunStoreApp
//
//  Created by apple on 2017/4/27.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import "AddressListViewController.h"
#import "AddressTableViewCell.h"
#import "AddAddressViewController.h"

@interface AddressListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong)UITableView *addressTableView;
@property(nonatomic, strong)UIButton *addAddressButn;

@end

@implementation AddressListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"地址管理";
    

    if (self.addressList.count>0) {
        
        [self createTableView];

        self.addAddressButn.backgroundColor=RGBCOLOR(232, 80, 45);
        self.addAddressButn.frame=CGRectMake(15, kScreenHeight-150, kScreenWidth-30, 50);
        
    }else{
        self.addAddressButn.backgroundColor=RGBCOLOR(221, 221, 221);
        self.addAddressButn.frame=CGRectMake(50,( kScreenHeight-50)/2, kScreenWidth-100, 50);
    }

    [self.view addSubview:self.addAddressButn];
    [self.view insertSubview:self.addAddressButn atIndex:0];
}

-(UIButton *)addAddressButn{
    if (_addAddressButn) {
        _addAddressButn=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.addAddressButn setTitle:@"+新建地址" forState:UIControlStateNormal];
    [self.addAddressButn addTarget:self action:@selector(addAddressClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addAddressButn;
}

-(void)createTableView{
    self.addressTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    self.addressTableView.dataSource=self;
    self.addressTableView.delegate=self;
    self.addressTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.addressTableView];
}
-(void)addAddressClick:(UIButton *)butn{
                AddAddressViewController *addAddressVC=[[AddAddressViewController alloc]init];
                [self.navigationController pushViewController:addAddressVC animated:YES];

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID=@"AddressCellID";
    AddressTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[AddressTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
