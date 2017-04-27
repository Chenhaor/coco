//
//  ShoppingCartViewController.m
//  YunFuStore
//
//  Created by apple on 2017/4/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "GWShoppingCartViewController.h"
#import "GWShoppingGoodsCell.h"
#import "GWShopCell.h"
#import "GWRecommendCell.h"
#import "GWReceiptView.h"
#import "GWCouponShowView.h"
#import "GWShopGoodsStyleView.h"
#import "GWShopCartGoodsModel.h"
#import "GWCommodityDetailViewController.h"

@interface GWShoppingCartViewController ()

@property (nonatomic,assign)ShopCartGoodsStyle goodsStyle;

@property (nonatomic,weak)GWReceiptView *recepiptView;

@property (nonatomic,strong)NSMutableArray *allSelectedBtnStateArrM;

@property (nonatomic,strong)NSArray *totoalGoodsArr;

@end

@implementation GWShoppingCartViewController

- (instancetype)init{
    self = [super init];
    
    if (self) {
        [self initData];
    }
    
    return self;
}

- (void)initData
{
    self.title = @"购物车";
    self.isShowFooterRefresh = NO;
    self.goodsStyle = GoodsBuy;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setLayout];
    
    [self setupRefresh];
    
    [self loadData];
}

- (void)setLayout
{
    [self createNavBarItems];
    
    self.tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 113.0 - 52.0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    [self createRecepiptView];
}

- (void)createNavBarItems
{
    UIButton *editBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    editBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [editBtn setTitle:@"完成" forState:UIControlStateSelected];
    [editBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [editBtn addTarget:self action:@selector(editBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *mesBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [mesBtn setImage:[UIImage imageNamed:@"msg_noMsg"] forState:UIControlStateNormal];
    [mesBtn addTarget:self action:@selector(mesBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *editBarItem = [[UIBarButtonItem alloc] initWithCustomView:editBtn];
    UIBarButtonItem *mesBarItem = [[UIBarButtonItem alloc] initWithCustomView:mesBtn];
    self.navigationItem.rightBarButtonItems = @[mesBarItem,editBarItem];
}

- (void)loadData
{
    GWShopCartGoodsModel *model1 = [[GWShopCartGoodsModel alloc] init];
    model1.goodsUrl = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1493032914113&di=9f59dc69a0538186d76f81659a609140&imgtype=0&src=http%3A%2F%2Fpic24.nipic.com%2F20121006%2F10719994_133236451000_2.jpg";
    model1.goodsTitle = @"keds旗舰店 帆布鞋 低帮鞋女 帆布鞋 低帮鞋女 帆布鞋";
    model1.descTitle = @"颜色: 红色 尺寸: 36";
    model1.goodsNum = 5;
    model1.price = 90;
    
    GWShopCartGoodsModel *model2 = [[GWShopCartGoodsModel alloc] init];
    model2.goodsUrl = @"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1493022894&di=abc9ae7409de26e0d584aa4c4ee781c4&src=http://www.ycmhz.com.cn/shenghuo/UploadFiles_7688/201203/20120325102433352.jpg";
    model2.goodsTitle = @"keds旗舰店 帆布鞋 低帮鞋女 帆布鞋 低帮鞋女 帆布鞋";
    model2.descTitle = @"颜色: 红色 尺寸: 36";
    model2.goodsNum = 1;
    model2.price = 60;
    
    GWShopCartGoodsModel *model3 = [[GWShopCartGoodsModel alloc] init];
    model3.goodsUrl = @"http://www.3158.cn/data/i10/20160225/23039452927217180.jpg";
    model3.goodsTitle = @"keds旗舰店 帆布鞋 低帮鞋女 帆布鞋 低帮鞋女 帆布鞋";
    model3.descTitle = @"颜色: 红色 尺寸: 36";
    model3.goodsNum = 2;
    model3.price = 80;
    
    self.totoalGoodsArr = @[@[model1,model2],@[model3]];
    
    for (int i = 0; i < _totoalGoodsArr.count; i ++) {
        
        NSMutableArray *sectionArrM = [NSMutableArray array];
        
        [sectionArrM addObject:@(0)];
        
        for (int j = 0; j < [_totoalGoodsArr[i] count]; j ++) {
            [sectionArrM addObject:@(0)];
        }
        [self.allSelectedBtnStateArrM addObject:sectionArrM];
    }
    
    [self headerEndRereshing];
    [self configData];
}

    //MARK :下拉刷新
- (void)headerRereshing {
    [super headerRereshing];
    [self loadData];
}
    
- (void)configData
{
    if (self.itemsArrM.count > 0) {
        [self.itemsArrM removeAllObjects];
    }
    
    NSIndexPath *indexPath = nil;
    
    for (int i = 0; i < self.totoalGoodsArr.count; i ++)
    {
        indexPath = [NSIndexPath indexPathForRow:0 inSection:i];
        
        NSArray *selectBtnStateArr = [self.allSelectedBtnStateArrM[i] copy];
        
        NSMutableArray *sectionArrM = [NSMutableArray array];
        
        GWCellConfig *shopCellConfig = [GWCellConfig cellConfigWithClassName:[GWShopCell class]
                                                                 modelToShow:nil
                                                           modelToShowDetail:selectBtnStateArr[0]
                                                                heightOfCell:30.0];
        [sectionArrM addObject:shopCellConfig];
        
        WS(ws);
        shopCellConfig.cellSubViewBlockWithParam = ^(UIButton *subView, id value) {
            
            if (subView.tag == 100) {
                [ws selectBtnActionOfShopGoodsCell:indexPath btnSelected:[value integerValue]];
            }else if (subView.tag == 101) {
                
                [ws showCouponView];
            }
        };
        
        NSArray *contentArr = self.totoalGoodsArr[i];
        
        for (int j = 0; j < [contentArr count]; j ++)
        {
            GWShopGoodsCellUIStyle *shopGoodsCellUIStyle = [[GWShopGoodsCellUIStyle alloc] init];

            shopGoodsCellUIStyle.goodsStyle = self.goodsStyle;
            
            shopGoodsCellUIStyle.selectBtnIsSelected = [selectBtnStateArr[j + 1] intValue];
            
            indexPath = [NSIndexPath indexPathForRow:(j + 1) inSection:i];
            
            GWCellConfig *shopGoodsCellConfig = [GWCellConfig cellConfigWithClassName:[GWShoppingGoodsCell class]
                                                                          modelToShow:contentArr[j]
                                                                    modelToShowDetail:shopGoodsCellUIStyle
                                                                         heightOfCell:104];
            [sectionArrM addObject:shopGoodsCellConfig];
            
            shopGoodsCellConfig.cellSelectedBlock = ^(NSInteger section, NSInteger row) {
                [ws pushToCommodityDetailVc];
            };
            shopGoodsCellConfig.cellSubViewBlockWithParam = ^(UIButton *subView, id value) {
                if (subView.tag == 100) {
                    [ws selectBtnActionOfShopGoodsCell:indexPath btnSelected:[value integerValue]];

                }else if (subView.tag == 101) {
                    [ws showShopGoodsStyleView];
                }
            };
            
        }
        
        [self.itemsArrM addObject:[sectionArrM copy]];
    }
    
    if (self.goodsStyle == GoodsBuy) {
        //recommend
        NSMutableArray *sectionArrM = [NSMutableArray array];
        GWCellConfig *shopCellConfig = [GWCellConfig cellConfigWithClassName:[GWRecommendCell class]
                                                                 modelToShow:nil
                                                                heightOfCell:880.0];
        [sectionArrM addObject:shopCellConfig];
        [self.itemsArrM addObject:[sectionArrM copy]];
    }
    
    [self.tableView reloadData];
}

- (void)pushToCommodityDetailVc {
    GWCommodityDetailViewController *vc = [[GWCommodityDetailViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark RecepiptView

- (void)createRecepiptView
{
    GWReceiptView *recepiptView = [[GWReceiptView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 113.0 - 52.0, kScreenWidth, 52.0)];
    recepiptView.goodsStyle = GoodsBuy;
    self.recepiptView = recepiptView;
    [self.view addSubview:recepiptView];
    
    WS(ws);
    [recepiptView setSelectBtnActionBlock:^(BOOL isSelected) {
        [ws selectBtnActionOfReceiptView:isSelected];
    }];
    
    [recepiptView setShareBtnActionBlock:^{
        [ws shareBtnAction];
    }];
    
    [recepiptView setAttentionBtnActionBlock:^{
        [ws attentionBtnAction];
    }];
    
    [recepiptView setDeleteBtnActionBlock:^{
        [ws deleteShopGoodsAction];
    }];
}

- (void)setRecepiptViewSelectBtnState
{
    BOOL flag = false;
    for (int i = 0; i < self.allSelectedBtnStateArrM.count; i ++)
    {
        NSMutableArray *sectionStateArrM = self.allSelectedBtnStateArrM[i];
        
        for (int j = 1;  j < sectionStateArrM.count; j ++) {
            if ([sectionStateArrM[j] intValue] == 0) {
                flag = true;
                break;
            }
        }
    }
    
    if (flag) {
        self.recepiptView.selectedBtnIsSelect = NO;
    }else {
        self.recepiptView.selectedBtnIsSelect = YES;
    }
}

#pragma mark btnAction
- (void)selectBtnActionOfShopGoodsCell:(NSIndexPath *)indexPath btnSelected:(BOOL)isSelected
{
    NSMutableArray *sectionStateArrM = self.allSelectedBtnStateArrM[indexPath.section];
    
    [sectionStateArrM replaceObjectAtIndex:indexPath.row withObject:@(isSelected ? 1 : 0)];

    if (indexPath.row == 0)
    {
        for (int i = 1;  i < sectionStateArrM.count; i ++)
            [sectionStateArrM replaceObjectAtIndex:i withObject:@([sectionStateArrM[0] intValue])];
    }
    else
    {
        int flag = 1;
        for (int i = 1;  i < sectionStateArrM.count; i ++) {
            if ([sectionStateArrM[i] integerValue] == 0) {
                flag = 0;
                break;
            }
        }
        [sectionStateArrM replaceObjectAtIndex:0 withObject:@(flag)];
    }
    
    [self setRecepiptViewSelectBtnState];
    
    [self configData];
}

- (void)selectBtnActionOfReceiptView:(BOOL)isSelected {
    
    for (int i = 0; i < self.allSelectedBtnStateArrM.count; i ++) {
        
        NSMutableArray *sectionArrM = self.allSelectedBtnStateArrM[i];
        for (int j = 0; j < sectionArrM.count; j ++) {
            [sectionArrM replaceObjectAtIndex:j withObject:@(isSelected ? 1 : 0)];
        }
    }
    
    [self configData];
}

- (void)shareBtnAction {
    
}

- (void)attentionBtnAction {
    
}

- (void)deleteShopGoodsAction {
    
}

- (void)editBtnAction:(UIButton *)editBtn {
    editBtn.selected = !editBtn.selected;
    
    if (editBtn.selected)
        self.goodsStyle = GoodsEdit;
    else
        self.goodsStyle = GoodsBuy;
    
    self.recepiptView.goodsStyle = self.goodsStyle;
    
    [self configData];
}

- (void)mesBtnAction:(UIButton *)mesBtn {
    
}

//展示优惠券界面
- (void)showCouponView {
    GWCouponShowView *couponView = [[GWCouponShowView alloc]
                                    initWithFrame:CGRectMake(0, 0, kScreenWidth, 380)];
    [couponView show];
}

//展示商品样式界面
- (void)showShopGoodsStyleView {
    GWShopGoodsStyleView *shopGoodsStyleView = [[GWShopGoodsStyleView alloc]
                                                initWithFrame:CGRectMake(0, 0, kScreenWidth, 380)];
    [shopGoodsStyleView show];
}

#pragma mark getter && setter

- (NSMutableArray *)allSelectedBtnStateArrM
{
    if (!_allSelectedBtnStateArrM) {
        _allSelectedBtnStateArrM = [NSMutableArray array];
    }
    return _allSelectedBtnStateArrM;
}

@end
