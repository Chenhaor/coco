//
//  scrollCollectionViewCell.m
//  YunStoreApp
//
//  Created by apple on 2017/4/27.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import "scrollCollectionViewCell.h"
#import "SingleAddress.h"
#import "AddressTitleTableViewCell.h"

@interface scrollCollectionViewCell ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UITableView *tableView;
@end

@implementation scrollCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.backgroundColor=[UIColor redColor];
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.frame.size.height) style:UITableViewStylePlain];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    [self.contentView addSubview:self.tableView];
}
-(void)setAddressArray:(NSMutableArray *)addressArray{
    _addressArray=addressArray;
    [self.tableView reloadData];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.addressArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID=@"cellIdentifier";
    AddressTitleTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[AddressTitleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.addressLabel.text=self.addressArray[indexPath.row];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SingleAddress *sinAddress=[SingleAddress shareAddress];
    NSMutableArray *mArray=[NSMutableArray new];
    for (int a=0; a<self.cellIndexPath.row; a++) {
        [mArray addObject:sinAddress.addressArray[a]];
    }
    [mArray addObject:self.addressArray[indexPath.row]];
    [sinAddress.addressArray removeAllObjects];
    [sinAddress.addressArray addObjectsFromArray:mArray];
    
    if (self.choiceAddress) {
        _choiceAddress(self.addressArray[indexPath.row]);
    }
    [self.tableView reloadData];
}
@end
