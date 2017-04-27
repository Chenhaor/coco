//
//  ChoiceAddressBackView.m
//  YunStoreApp
//
//  Created by apple on 2017/4/27.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import "ChoiceAddressBackView.h"
#import "scrollCollectionViewCell.h"
#import "SingleAddress.h"
@interface ChoiceAddressBackView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic, strong)UILabel *locationArealabel;
@property(nonatomic, strong)UIScrollView *titleScrollView;
@property(nonatomic, strong)UICollectionView *scrollCollectionView;

@property(nonatomic, strong)NSMutableArray *butnArray;
@property (nonatomic ,strong)CALayer *scrollLayer;
@end

static NSString *cellId=@"CollectionViewID";
@implementation ChoiceAddressBackView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    //390
    self.backgroundColor=[UIColor whiteColor];
    self.locationArealabel=[[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-80)/2, 19, 80, 16)];
    self.locationArealabel.textAlignment=NSTextAlignmentCenter;
    self.locationArealabel.text=@"所在地区";
    self.locationArealabel.font=[UIFont systemFontOfSize:16];
    [self addSubview:self.locationArealabel];
    
    self.deleteButn=[[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-30-12, 9, 30, 30)];
    self.deleteButn.backgroundColor=[UIColor redColor];
    [self.deleteButn.layer setCornerRadius:15];
    [self.deleteButn.layer setMasksToBounds:YES];
    [self addSubview:self.deleteButn];
    
    CALayer *lineLayer=[CALayer layer];
    lineLayer.frame=CGRectMake(0, 54, kScreenWidth, 1);
    lineLayer.backgroundColor=DEFAULT_CUTTINGLINE_COLOR.CGColor;
    [self.layer addSublayer:lineLayer];
    
    self.titleScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 55, kScreenWidth, 44)];
    [self addSubview:self.titleScrollView];
    
    self.butnArray=[NSMutableArray new];
    for (int a=0; a<4; a++) {
        UIButton *butn=[UIButton buttonWithType:UIButtonTypeCustom];
        [butn setTitleColor:RGBCOLOR(235, 97, 57) forState:UIControlStateSelected];
        [butn setTitleColor:RGBCOLOR(115, 115, 115) forState:UIControlStateNormal];
        butn.tag=1300+a;
        [butn addTarget:self action:@selector(butnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.butnArray addObject:butn];
    }
    
    CALayer *scrollLayer=[CALayer layer];
    lineLayer.frame=CGRectMake(0, 99, kScreenWidth, 1);
    lineLayer.backgroundColor=DEFAULT_CUTTINGLINE_COLOR.CGColor;
    [self.layer addSublayer:scrollLayer];
    
    _scrollLayer=[CALayer layer];
    _scrollLayer.backgroundColor= [UIColor redColor].CGColor;
    _scrollLayer.frame=CGRectMake(0, 99, 0, 1);
    [scrollLayer addSublayer:_scrollLayer];
    
    UICollectionViewFlowLayout *collectionLayout=[[UICollectionViewFlowLayout alloc]init];
    self.scrollCollectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 100, kScreenWidth, 290) collectionViewLayout:collectionLayout];
    [collectionLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    collectionLayout.itemSize = CGSizeMake(kScreenWidth, 290);
    collectionLayout.minimumLineSpacing=0;
    collectionLayout.minimumInteritemSpacing=0;
    collectionLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.scrollCollectionView.delegate=self;
    self.scrollCollectionView.dataSource=self;
    [self.scrollCollectionView registerClass:[scrollCollectionViewCell class] forCellWithReuseIdentifier:cellId];
    self.scrollCollectionView.pagingEnabled=YES;
    self.scrollCollectionView.backgroundColor=[UIColor whiteColor];
    [self addSubview:self.scrollCollectionView];
    
    self.AllAddressArray=[NSMutableArray new];
    [self loadAllAddressArray];
    [self.scrollCollectionView reloadData];
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _AllAddressArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    scrollCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.addressArray=_AllAddressArray[indexPath.row];
    cell.cellIndexPath=indexPath;
    
    cell.choiceAddress = ^(NSString *addressStr) {
        [self loadAllAddressArray];
        [self.scrollCollectionView reloadData];
    };
    return cell;
}

-(void)loadAllAddressArray{
    SingleAddress *singleAddr=[SingleAddress shareAddress];
    if (singleAddr.addressArray.count==0) {
        NSMutableArray *array=[NSMutableArray new];
        for (int a=0; a<arc4random()%5+4; a++) {
            [array addObject:[NSString stringWithFormat:@"第%d省",a]];
        }
        [self.AllAddressArray addObject:array];
    }else if (singleAddr.addressArray.count==1){
        NSMutableArray *array=[NSMutableArray new];
        for (int a=0; a<arc4random()%5+4; a++) {
            [array addObject:[NSString stringWithFormat:@"第%d省",a]];
        }
        NSString *provinceStr=singleAddr.addressArray[0];
        NSMutableArray *cityeArray=[NSMutableArray new];
        for (int a=0; a<arc4random()%5+4; a++) {
            [cityeArray addObject:[NSString stringWithFormat:@"%@第%d市",provinceStr,a]];
        }
        [self.AllAddressArray removeAllObjects];
        [self.AllAddressArray addObjectsFromArray:@[array,cityeArray]];
    }else if(singleAddr.addressArray.count==2){
        
        NSMutableArray *array=[NSMutableArray new];
        for (int a=0; a<arc4random()%5+4; a++) {
            [array addObject:[NSString stringWithFormat:@"第%d省",a]];
        }
        
        NSString *provinceStr=singleAddr.addressArray[0];
        NSMutableArray *cityeArray=[NSMutableArray new];
        for (int a=0; a<arc4random()%5+4; a++) {
            [cityeArray addObject:[NSString stringWithFormat:@"%@第%d市",provinceStr,a]];
        }
        
        NSString *cityStr=singleAddr.addressArray[1];
        NSMutableArray *areaArray=[NSMutableArray new];
        for (int a=0; a<arc4random()%5+4; a++) {
            [areaArray addObject:[NSString stringWithFormat:@"%@第%d区",cityStr,a]];
        }
        [self.AllAddressArray removeAllObjects];
        [self.AllAddressArray addObjectsFromArray:@[array,cityeArray,areaArray]];
    }else{
        NSMutableArray *array=[NSMutableArray new];
        for (int a=0; a<arc4random()%5+4; a++) {
            [array addObject:[NSString stringWithFormat:@"第%d省",a]];
        }
        NSString *provinceStr=singleAddr.addressArray[0];
        NSMutableArray *cityeArray=[NSMutableArray new];
        for (int a=0; a<arc4random()%5+4; a++) {
            [cityeArray addObject:[NSString stringWithFormat:@"%@第%d市",provinceStr,a]];
        }
        
        NSString *cityStr=singleAddr.addressArray[1];
        NSMutableArray *areaArray=[NSMutableArray new];
        for (int a=0; a<arc4random()%5+4; a++) {
            [areaArray addObject:[NSString stringWithFormat:@"%@第%d区",cityStr,a]];
        }
        
        NSString *areaStr=singleAddr.addressArray[2];
        NSMutableArray *streetArray=[NSMutableArray new];
        for (int a=0; a<arc4random()%5+4; a++) {
            [streetArray addObject:[NSString stringWithFormat:@"%@第%d街",areaStr,a]];
        }
        [self.AllAddressArray removeAllObjects];
        [self.AllAddressArray addObjectsFromArray:@[array,cityeArray,areaArray,streetArray]];
    }
    
    [self createTitleScrollView];
    
    [self Scroll];
}

-(void)createTitleScrollView{
    SingleAddress *singleAddr=[SingleAddress shareAddress];
    NSMutableArray *array=singleAddr.addressArray;
    
    for (UIButton *butn in self.butnArray) {
        [butn removeFromSuperview];
    }
    for (int a=0; a<MIN(array.count+1, 4); a++) {
        if (a<array.count) {
            UIButton *butn=self.butnArray[a];
            [butn setTitle:array[a] forState:UIControlStateNormal];
            butn.frame=CGRectMake(60*a, 0, 60, 44);
            [_titleScrollView addSubview:butn];
        }else{
            UIButton *butn=self.butnArray[a];
            [butn setTitle:@"请选择" forState:UIControlStateNormal];
            butn.frame=CGRectMake(array.count*60, 0, 60, 44);
            [_titleScrollView addSubview:butn];
        }
    }
}

-(void)butnClick:(UIButton *)butn{
    [self butnSelected:(butn.tag-1300)];
    self.scrollCollectionView.contentOffset=CGPointMake((butn.tag-1300)*kScreenWidth, 0);
}

-(void)Scroll{
    SingleAddress *singleAddr=[SingleAddress shareAddress];
    NSMutableArray *array=singleAddr.addressArray;
    self.scrollCollectionView.contentOffset=CGPointMake(MIN(array.count, 3)*kScreenWidth, 0);
    [self butnSelected:MIN(array.count+1,4)];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSInteger a = scrollView.contentOffset.y/kScreenWidth;
    [self butnSelected:a];
}

-(void)butnSelected:(NSInteger)butnTag{
    for (NSInteger a=0; a<4; a++) {
        UIButton *allButn=[self viewWithTag:1300+a];
        if (butnTag==a) {
            allButn.selected=YES;
            _scrollLayer.frame=CGRectMake((a-1)*60, 99, 60, 1);
        }else{
            allButn.selected=NO;
        }
    }
}
@end
