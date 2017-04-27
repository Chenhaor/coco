//
//  GWOrderManagerViewController.m
//  YunStoreApp
//
//  Created by apple on 2017/4/25.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import "GWOrderManagerViewController.h"
#import "GWSlideSwitchView.h"
#import "GWOrderChildViewController.h"

@interface GWOrderManagerViewController ()<SlideSwitchViewDelegate>

@property (nonatomic,strong)GWSlideSwitchView *slideView;

@property (nonatomic,strong)NSMutableArray *dataVcArrM;


@end

@implementation GWOrderManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的订单";
    [self initData];
    
    [self setLayout];
}

- (void)setLayout
{
    [self createNavBarItems];
    
    _slideView = [[GWSlideSwitchView alloc] initWithFrame:CGRectMake(0, 1, self.view.bounds.size.width, self.view.bounds.size.height - 65)];
    _slideView.backgroundColor = [UIColor whiteColor];
    _slideView.heightOfTopScrollView = 33;
    _slideView.tabItemNormalColor = RGBCOLOR(102, 102, 102);
    _slideView.tabItemSelectedColor = RGBCOLOR(232, 60, 0);
    _slideView.shadowImg = [UIImage imageNamed:@"orderManager_slideView"];
    _slideView.slideSwitchViewDelegate = self;
    [self.view addSubview:_slideView];
    [_slideView buildUI];
}

- (void)initData
{
    NSArray *dataArr = @[@"全部",@"待付款",@"代发货",@"待收货",@"待评价"];
    
    for (NSString *title in dataArr) {
        GWOrderChildViewController *vc = [[GWOrderChildViewController alloc] init];
        vc.title = title;
        [self.dataVcArrM addObject:vc];
    }
}

- (void)createNavBarItems
{
    UIButton *findBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    findBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [findBtn setImage:[UIImage imageNamed:@"orderManager_find"] forState:UIControlStateNormal];
    [findBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [findBtn addTarget:self action:@selector(findBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *mesBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [mesBtn setImage:[UIImage imageNamed:@"msg_noMsg"] forState:UIControlStateNormal];
    [mesBtn addTarget:self action:@selector(mesBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *findBarItem = [[UIBarButtonItem alloc] initWithCustomView:findBtn];
    UIBarButtonItem *mesBarItem = [[UIBarButtonItem alloc] initWithCustomView:mesBtn];
    self.navigationItem.rightBarButtonItems = @[mesBarItem,findBarItem];
}

- (void)findBtnAction:(UIButton *)findBtn {
    
}

- (void)mesBtnAction:(UIButton *)mesBtn {
    
}

#pragma mark SlideSwitchViewDelegate
/*
 * @method 共有多少子控制器
 */
- (NSArray *)childsVcOfSlideSwitchView
{
    return self.dataVcArrM;
}

#pragma mark getter && setter

- (NSMutableArray *)dataVcArrM {
    if (!_dataVcArrM) {
        _dataVcArrM = [NSMutableArray array];
    }
    return _dataVcArrM;
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
