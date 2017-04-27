//
//  ClassifiedViewController.m
//  YunFuStore
//
//  Created by apple on 2017/4/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ClassifiedViewController.h"
#import "DataFalsification.h"
#import "ClassDetailFlowLayout.h"

#import "ClassTableViewCell.h"
//#import "ClassDetailCollectionViewCell.h"

#import "ClassModel.h"
#import "ClassDetailModel.h"
//#import "ClassScrollCollectionViewCell.h"

#import "ClassdetailTableViewCell.h"
#import "ClassScrollTableViewCell.h"
#import "ClassHeadView.h"
#import "MJRefresh.h"


@interface ClassifiedViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>{
    ClassDetailFlowLayout *_classDetailFlowLayout;
}

@property(nonatomic, strong) UITableView *classTableView;
@property(nonatomic, strong) UITableView *detailsTableView;
//@property(nonatomic,strong) UICollectionView *detailsCollectionView;
@property(nonatomic, strong) NSMutableArray *classDataArray;
@property(nonatomic, strong) NSMutableArray *detailDataArray;

@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UIButton *searchButton;

@end

static NSString * const tabViewCellID=@"tabViewCellID";
//static NSString * const identifier = @"collectionViewcell";
//static NSString * const scrollCellID=@"scrollCellID";
@implementation ClassifiedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=DEFAULT_BACKGROUND_COLOR;
    
    [self createsearchBar];
    [self loadDataFromServer];
    [self loadDetailData];
    
    [self createTableView];
    //    [self createdetailsCollectionView];
}


-(void)createsearchBar{
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"homeTabBarBack"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    UISearchBar *searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(60, 0, kScreenWidth-120, 30)];
    searchBar.placeholder=@"新品下单立减100！";
    [self.navigationController.navigationBar addSubview:searchBar];
    
    self.leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.leftButton.frame = CGRectMake(15, 0, 30, 30);
    [self.leftButton setImage:[UIImage imageNamed:@"2Dbarcode"] forState:UIControlStateNormal];
    //    [self.leftButton setTitle:@"扫描" forState:UIControlStateNormal];
    //    self.leftButton.titleLabel.font=[UIFont systemFontOfSize:13];
    self.leftButton.userInteractionEnabled = YES;
    //    self.leftButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.navigationController.navigationBar addSubview:self.leftButton];
    
    self.rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.rightButton.frame = CGRectMake(kScreenWidth - 40, 0, 30, 30);
    [self.rightButton setImage:[UIImage imageNamed:@"yf_message@2x"] forState:UIControlStateNormal];
    //    [self.rightButton setTitle:@"消息" forState:UIControlStateNormal];
    //    self.rightButton.titleLabel.font=[UIFont systemFontOfSize:13];
    self.rightButton.userInteractionEnabled = YES;
    //    self.rightButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    [self.navigationController.navigationBar addSubview:self.rightButton];
    
}

-(void)loadDataFromServer{
    
    DataFalsification *dataFalsification=[[DataFalsification alloc]init];
    
    _classDataArray=[dataFalsification createClassData];
    [_classTableView reloadData];
    
    NSIndexPath * selIndex = [NSIndexPath indexPathForRow:1 inSection:0];
    [_classTableView selectRowAtIndexPath:selIndex animated:YES scrollPosition:UITableViewScrollPositionTop];
    NSIndexPath * path = [NSIndexPath indexPathForItem:0 inSection:0];
    [self tableView:_classTableView didSelectRowAtIndexPath:path];
    
}

-(void)loadDetailData{
    DataFalsification *dataFalsification=[[DataFalsification alloc]init];
    _detailDataArray=[dataFalsification creatDetailDataArray];
    
    [_detailsTableView reloadData];
    //    [_detailsCollectionView reloadData];
    [_detailsTableView.mj_header endRefreshing];
    [_detailsTableView.mj_footer endRefreshing];
}


-(void)createTableView{
    
    _classTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 100, kScreenHeight-kNaviHeight-kTabbarHeight)];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
    [_classTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    _classTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _classTableView.dataSource=self;
    _classTableView.delegate=self;
    [self.view addSubview:_classTableView];
    
    
    _detailsTableView=[[UITableView alloc]initWithFrame:CGRectMake(110, 0, kScreenWidth-110, kScreenHeight-kNaviHeight-kTabbarHeight) style:UITableViewStyleGrouped];
                       
    _detailsTableView.backgroundColor=DEFAULT_BACKGROUND_COLOR;
    _detailsTableView.dataSource=self;
    _detailsTableView.delegate=self;
    
    ClassHeadView *headView=[[ClassHeadView alloc]initWithFrame:CGRectMake(0, 0, _detailsTableView.frame.size.width, 110)];
    _detailsTableView.tableHeaderView=headView;
    [self.view addSubview:_detailsTableView];
    
    _detailsTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadDetailData];
        
    }];
    _detailsTableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadDetailData];
    }];
}

/*
 -(void)createdetailsCollectionView{
 _classDetailFlowLayout=[ClassDetailFlowLayout new];
 _detailsCollectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(110, 0, kScreenWidth-110, kScreenHeight-kNaviHeight-kTabbarHeight) collectionViewLayout:_classDetailFlowLayout];
 _detailsCollectionView.backgroundColor=[UIColor whiteColor];
 [_detailsCollectionView registerClass:[ClassDetailCollectionViewCell class] forCellWithReuseIdentifier:identifier];
 [_detailsCollectionView registerClass:[ClassScrollCollectionViewCell class] forCellWithReuseIdentifier:scrollCellID];
 [_detailsCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
 _detailsCollectionView.delegate=self;
 _detailsCollectionView.dataSource=self;
 [self.view addSubview:_detailsCollectionView];
 }
 */

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if([tableView isEqual:_classTableView]){
        return 1;
    }else{
        return _detailDataArray.count;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if([tableView isEqual:_classTableView]){
        return _classDataArray.count;
    }else{
        //            NSArray *array=_detailDataArray[section];
        //            return array.count;
        return 1;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:_classTableView]) {
        ClassTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:tabViewCellID];
        if (cell==nil) {
            cell=[[ClassTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tabViewCellID];
        }
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = DEFAULT_BACKGROUND_COLOR;
        ClassModel *model=_classDataArray[indexPath.row];
        cell.model=model;
        return cell;
    }else{
        if (indexPath.section==0) {
            static NSString * const detailsScrollCellID=@"detailsScrollCellID";
            ClassScrollTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:detailsScrollCellID];
            if (cell==nil) {
                cell=[[ClassScrollTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detailsScrollCellID];
            }
            NSMutableArray *array=_detailDataArray[indexPath.section];
            cell.scrollCellDatas=array;
            return cell;

        }else{
            static NSString * const detailsTableCellID=@"detailsTableCellID";
            
            ClassdetailTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:detailsTableCellID];
            if (cell==nil) {
                cell=[[ClassdetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detailsTableCellID];
            }
            NSMutableArray *array=_detailDataArray[indexPath.section];
            cell.modelArray=array;
            return cell;
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if ([tableView isEqual:_classTableView]) {
        return 40;
    }else{
        if (indexPath.section==0) {
            return 100;
        }else{
            NSMutableArray *array=_detailDataArray[indexPath.section];
            CGFloat viewHeighth=(kScreenWidth-110)/3+20;
            return viewHeighth*((array.count-1)/3+1);
        }

    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self loadDetailData];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
   
    if ([tableView isEqual:_detailsTableView]) {
        
        UIView *sectionView=[[UIView  alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth-110, 30)];;
        
        sectionView.backgroundColor=[UIColor whiteColor];
        UIImageView *imageViewe=[[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 20, 20)];
        imageViewe.backgroundColor=[UIColor redColor];
        imageViewe.image=[UIImage imageNamed:@"classifiedHeadImage"];
        [sectionView addSubview:imageViewe];
        
        UILabel *titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(40, 5, 100, 20)];
        titlelabel.font=[UIFont systemFontOfSize:14];
        titlelabel.textColor=RGBCOLOR(184, 184, 184);
        titlelabel.text=[NSString stringWithFormat:@"第%ld组商品",section];
        [sectionView addSubview:titlelabel];
        
        CALayer *layer=[CALayer layer];
        layer.frame=CGRectMake(0, 29, kScreenWidth-110, 1);
        layer.backgroundColor=DEFAULT_BACKGROUND_COLOR.CGColor;
        [sectionView.layer addSublayer:layer];
        
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:sectionView.bounds byRoundingCorners:UIRectCornerTopLeft cornerRadii:CGSizeMake(10, 10)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = sectionView.bounds;
        maskLayer.path = maskPath.CGPath;
        sectionView.layer.mask = maskLayer;
        return sectionView;
        
        
    }else{
    
        return nil;
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if ([tableView isEqual:_detailsTableView]) {
        return 30;

    }else{
        return CGFLOAT_MIN;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if ([tableView isEqual:_detailsTableView]) {
        return 10;
    }else{
        return CGFLOAT_MIN;
    }
}
//#pragma UICollectionViewDelegate
//-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
//    return _detailDataArray.count;
//}
//
//-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    NSArray *array=_detailDataArray[section];
//    return array.count;
//}
//
//-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section==0) {
//        ClassScrollCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:scrollCellID forIndexPath:indexPath];
//        _classDetailFlowLayout.itemSize=CGSizeMake(kScreenWidth-110, 100);
//        return cell;
//    }else{
//        ClassDetailCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
//        _classDetailFlowLayout.itemSize=CGSizeMake((kScreenWidth-110)/3, (kScreenWidth-110)/3+20);
//
//        NSArray *array=_detailDataArray[indexPath.section];
//        ClassDetailModel *model=array[indexPath.row];
//        cell.model=model;
//        return cell;
//    }
//
//}
//
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
//
//            UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
//            CALayer *headerlayer=[CALayer layer];
//            headerlayer.backgroundColor=DEFAULT_BACKGROUND_COLOR.CGColor;
//            headerlayer.frame=CGRectMake(0, 0, kScreenWidth-110, 10);
//            [header.layer addSublayer:headerlayer];
//
//        for (UIView *view in header.subviews) {
//            [view removeFromSuperview];
//        } // 防止复用分区头
//
//        UILabel *headerLabel=[UILabel new];
//        if (indexPath.section==0) {
//            UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 10,  kScreenWidth-110, 90)];
//            imageView.image=[UIImage imageNamed:@"classifiedHeadImage"];
//            [header addSubview:imageView];
//            headerLabel.frame=CGRectMake(0, 100, kScreenWidth-110, 30);
//        }else{
//            headerLabel.frame=CGRectMake(0, 10, kScreenWidth-110, 30);
//        }
//
//        headerLabel.textColor=RGBCOLOR(0, 0, 0);
//        headerLabel.font=[UIFont systemFontOfSize:20];
//            headerLabel.text=[NSString stringWithFormat:@" 第%ld款商品",indexPath.section];
//
//            [header addSubview:headerLabel];
//            header.backgroundColor=DEFAULT_BACKGROUND_COLOR;
//            return header;
//
//
//    } else {
//        return nil;
//    }
//}
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//    if (section==0) {
//        return CGSizeMake(kScreenWidth, 130);
//    }else{
//    return CGSizeMake(kScreenWidth, 40);
//    }
//
//}





@end
