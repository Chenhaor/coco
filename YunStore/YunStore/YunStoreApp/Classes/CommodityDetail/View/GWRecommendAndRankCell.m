//
//  GWRecommendAndRankCell.m
//  YunStoreApp
//
//  Created by apple on 2017/4/25.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import "GWRecommendAndRankCell.h"
#import "GWRecommendProductView.h"

@implementation GWRecommendAndRankCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self setUI];
    }
    
    return self;
}

- (void)setUI {
    
    //title 为你推荐
    UIView *titleBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 32.0)];
    titleBgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:titleBgView];
    
    UIButton *recommendBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth / 2.0 - 0.5, 32)];
    [recommendBtn setImage:[UIImage imageNamed:@"shopCart_recommendTitle"] forState:UIControlStateNormal];
    [titleBgView addSubview:recommendBtn];
    
    UIView *middleLine = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth / 2.0 - 0.5, 6, 0.5, 20)];
    middleLine.backgroundColor = RGBCOLOR(239, 239, 239);
    [titleBgView addSubview:middleLine];
    
    UIButton *rankBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth / 2.0, 0, kScreenWidth / 2.0, 32)];
    [rankBtn setImage:[UIImage imageNamed:@"shopCart_recommendTitle"] forState:UIControlStateNormal];
    [titleBgView addSubview:rankBtn];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 31.5, kScreenWidth, 0.5)];
    lineView.backgroundColor = RGBCOLOR(239, 239, 239);
    [titleBgView addSubview:lineView];
    
    //product show
    CGFloat padding = 2.0;
    CGFloat productImgX = 0.0;
    CGFloat productImgY = 0.0;
    CGFloat productImgW = (kScreenWidth - 2.0)/2.0;
    CGFloat productImgH = productImgW * 210.0 / 185.0;
    
    for (int i = 0;  i < 4; i ++) {
        
        productImgX = (i % 2) * (productImgW + padding);
        productImgY = 32.0 + (i / 2) * (productImgH + padding);
        GWRecommendProductView *productImgView = [[GWRecommendProductView alloc] initWithFrame:CGRectMake(productImgX, productImgY, productImgW, productImgH)];
        [self.contentView addSubview:productImgView];
        [productImgView addTarget:self action:@selector(pushToDetail:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)pushToDetail:(UIButton *)btn {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
