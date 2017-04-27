//
//  GWRecommendCell.m
//  YunStoreApp
//
//  Created by apple on 2017/4/20.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import "GWRecommendCell.h"
#import "GWRecommendProductView.h"

@implementation GWRecommendCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = DEFAULT_BACKGROUND_COLOR;
        
        [self setUI];
    }
    
    return self;
}


- (void)setUI {
    //title 为你推荐
    UIView *titleBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 25.5)];
    titleBgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:titleBgView];
    
    UIImageView *textImgView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth - 79)/2.0, 5, 79, 15.5)];
    textImgView.image = [UIImage imageNamed:@"shopCart_recommendTitle"];
    [titleBgView addSubview:textImgView];
    
    //product show
    CGFloat padding = 2.0;
    CGFloat productImgX = 0.0;
    CGFloat productImgY = 0.0;
    CGFloat productImgW = (kScreenWidth - 2.0)/2.0;
    CGFloat productImgH = productImgW * 210.0 / 185.0;
    
    for (int i = 0;  i < 8; i ++) {
        
        productImgX = (i % 2) * (productImgW + padding);
        productImgY = 27.0 + (i / 2) * (productImgH + padding);
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
