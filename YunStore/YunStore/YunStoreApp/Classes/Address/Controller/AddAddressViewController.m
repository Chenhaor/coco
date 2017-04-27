//
//  AddAddressViewController.m
//  YunStoreApp
//
//  Created by apple on 2017/4/27.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import "AddAddressViewController.h"
#import "PersonalTableViewCell.h"
#import "SetCommonAddrTableViewCell.h"
#import "ChoiceAddressBackView.h"

#import "AboutUsViewController.h"


@interface AddAddressViewController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>

@property(nonatomic, strong)UITableView *addressTableView;
@property(nonatomic, strong)ChoiceAddressBackView *choiceBackView;

@property(nonatomic, strong)UIView *backView;
@end

@implementation AddAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"新增收货地址";
    
    [self createTabView];
}
-(ChoiceAddressBackView *)choiceBackView{
    if (_choiceBackView==nil) {
        _choiceBackView=[ChoiceAddressBackView new];
        [_choiceBackView.deleteButn addTarget:self action:@selector(backViewRemove) forControlEvents:UIControlEventTouchUpInside];
        _choiceBackView.backgroundColor=[UIColor whiteColor];
        _choiceBackView.alpha=1.0;
    }
    return _choiceBackView;
}

-(UIView *)backView{
    if (_backView==nil) {
        _backView=[UIView new];
        _backView.backgroundColor=RGBCOLOR(178, 178, 178);
        _backView.alpha=0.5;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backViewRemove)];
        tap.delegate=self;
        [_backView addGestureRecognizer:tap];
    }
    return _backView;
}

-(void)createTabView{
    self.addressTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
    self.addressTableView.dataSource=self;
    self.addressTableView.delegate=self;
    self.addressTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.addressTableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 4;
    }else{
        return 1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        static NSString *cellID=@"PersonalCellID";
        PersonalTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell==nil) {
            cell=[[PersonalTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        NSArray *array=@[@"收货人姓名",@"区域选择",@"详细地址",@"联系方式"];
        cell.titleLabel.text=array[indexPath.row];
        cell.contentLabel.text=nil;
        if (indexPath.row==1) {
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
        return cell;
    }else{
        static NSString *SetCommonAddrCellID=@"SetCommonAddrCellID";
        
        SetCommonAddrTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:SetCommonAddrCellID];
        if (cell==nil) {
            cell=[[SetCommonAddrTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SetCommonAddrCellID];
        }
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0&&indexPath.row==1) {
        self.backView.frame=CGRectMake(0,0, kScreenWidth, kScreenHeight);
        [self.view addSubview:self.backView];
        
        self.choiceBackView.frame=CGRectMake(0, kScreenHeight, kScreenWidth, 390);
        self.choiceBackView.userInteractionEnabled=YES;
        [self.backView addSubview:self.choiceBackView];
        [UIView animateWithDuration:1.0f animations:^{
            self.choiceBackView.center=CGPointMake(kScreenWidth/2, kScreenHeight-(390+64)/2);
        }];
    }else if (indexPath.section==0&&indexPath.row==0){
        AboutUsViewController *aboutUsVC=[[AboutUsViewController alloc]init];
        [self.navigationController pushViewController:aboutUsVC animated:YES];
    }
}

-(void)backViewRemove{
    
    [UIView animateWithDuration:1.0f animations:^{
        self.choiceBackView.center=CGPointMake(kScreenWidth/2, kScreenHeight+(390+64)/2);
    } completion:^(BOOL finished) {
        [self.choiceBackView removeFromSuperview];
        [self.backView removeFromSuperview];
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 5;
    }else{
        return CGFLOAT_MIN;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return NO;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceivePress:(UIPress *)press {
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
