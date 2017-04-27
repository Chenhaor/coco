//
//  GWCommodityViewController.m
//  YunStoreApp
//
//  Created by apple on 2017/4/25.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import "GWCommodityViewController.h"
#import "GWCommodityDetailInfoCell.h"
#import "GWPageContentViewControllerDelegate.h"
#import "GWSelectCommodityStyleCell.h"
#import "GWRecommendAndRankCell.h"
#import "GWStoreTableViewCell.h"
#import "GWEvaluateTableViewCell.h"
#import "GWEvaluateDetailTableViewCell.h"
#import "GWLookAllTableViewCell.h"

@interface GWCommodityViewController ()<GWPageContentViewControllerDelegate>

@end

@implementation GWCommodityViewController

@synthesize pageContentFrame = _pageContentFrame;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setLayout];
    
    [self configData];
}

- (void)setLayout {
    self.tableView.frame = CGRectMake(0, 0, _pageContentFrame.size.width, _pageContentFrame.size.height - 64.0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

- (void)configData
{
    GWCellConfig *detailInfoCellConfig = [GWCellConfig cellConfigWithClassName:[GWCommodityDetailInfoCell class]
                                                                   modelToShow:nil
                                                                  heightOfCell:480.0];
    [self.itemsArrM addObject:@[detailInfoCellConfig]];
    
    
    
    GWCellConfig *commodityStyleCellConfig = [GWCellConfig cellConfigWithClassName:[GWSelectCommodityStyleCell class]
                                                                   modelToShow:nil
                                                                  heightOfCell:70.0];
    [self.itemsArrM addObject:@[commodityStyleCellConfig]];
    
    GWCellConfig *shopCellConfig = [GWCellConfig cellConfigWithClassName:[GWStoreTableViewCell class]
                                                             modelToShow:nil
                                                            heightOfCell:50.0];
    [self.itemsArrM addObject:@[shopCellConfig]];
    
    //评论
    GWCellConfig *evaluateCellConfig = [GWCellConfig cellConfigWithClassName:[GWEvaluateTableViewCell class]
                                                                 modelToShow:nil
                                                                heightOfCell:28.0];
    
    GWCellConfig *evaluateDetailCellConfig = [GWCellConfig cellConfigWithClassName:[GWEvaluateDetailTableViewCell class]
                                                                 modelToShow:nil
                                                                heightOfCell:150.0];
    
    GWCellConfig *lookAllCellConfig = [GWCellConfig cellConfigWithClassName:[GWLookAllTableViewCell class]
                                                                 modelToShow:nil
                                                                heightOfCell:39.0];
    [self.itemsArrM addObject:@[evaluateCellConfig,evaluateDetailCellConfig,lookAllCellConfig]];


    //推荐
    GWCellConfig *recommendAndRankCellConfig = [GWCellConfig cellConfigWithClassName:[GWRecommendAndRankCell class]
                                                                         modelToShow:nil
                                                                        heightOfCell:470.0];
    [self.itemsArrM addObject:@[recommendAndRankCellConfig]];
    
    [self.tableView reloadData];
}

#pragma mark talbeViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.01f;
    }
    return 5.0f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
