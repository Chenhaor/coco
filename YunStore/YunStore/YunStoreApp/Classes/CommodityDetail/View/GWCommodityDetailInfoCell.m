//
//  GWCommodityDetailInfoCell.m
//  YunStoreApp
//
//  Created by apple on 2017/4/25.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import "GWCommodityDetailInfoCell.h"
#import "UIImageView+WebCache.h"

@implementation GWCommodityDetailInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        [self setUI];
    }
    
    return self;
}

- (void)setUI
{
    UIScrollView *productScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 390)];
    productScrollView.showsHorizontalScrollIndicator = NO;
    productScrollView.pagingEnabled = YES;
    [self.contentView addSubview:productScrollView];
    productScrollView.contentSize = CGSizeMake(kScreenWidth * 5, 390);
    
    NSArray *productImgArr = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1493117328649&di=698b3e40da37656694619e240117608f&imgtype=0&src=http%3A%2F%2Fpic.qiantucdn.com%2F58pic%2F18%2F48%2F46%2F5627eb13a2576_1024.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1493117328649&di=1febe82520f4b1694e87c5d553b30384&imgtype=0&src=http%3A%2F%2Fsc.jb51.net%2Fuploads%2Fallimg%2F150323%2F11-1503230Z525Y9.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1493117328648&di=3626618360e25807c1163f686232985b&imgtype=0&src=http%3A%2F%2Fpic.58pic.com%2F58pic%2F15%2F04%2F14%2F85Z58PICA9q_1024.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1493117328648&di=2c8bd5b4efb8ce09acba4684f1350c24&imgtype=0&src=http%3A%2F%2Fimgtu.5011.net%2Fuploads%2Fcontent%2F20170329%2F8575901490773978.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1493117328647&di=06492d746cbb8166bf30e958f09c6f0d&imgtype=0&src=http%3A%2F%2Fpic.58pic.com%2F58pic%2F15%2F04%2F14%2F97b58PICxQ9_1024.jpg"];
    
    CGFloat productImgViewX = 0.0;
    for (int i = 0; i < 5; i ++)
    {
        productImgViewX = i * kScreenWidth;
        UIImageView *productImgView = [[UIImageView alloc] initWithFrame:CGRectMake(productImgViewX, 0, kScreenWidth, 390.0)];
        [productImgView sd_setImageWithURL:[NSURL URLWithString:productImgArr[i]]];
        [productScrollView addSubview:productImgView];
    }
    
    UIView *productInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, 390, kScreenWidth, 90)];
    [self.contentView addSubview:productInfoView];
    
    UILabel *productNameLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth - 20, 36)];
    productNameLable.numberOfLines = 2;
    productNameLable.text = @"          Apple 手机大卖 开售了 iPad iPod 各种类型 手机大卖 开售了 iPad iPod 各种类型手机大卖 开售了 iPad iPod 各种类型";
    productNameLable.font = [UIFont systemFontOfSize:14.0];
    [productInfoView addSubview:productNameLable];
    
    UIButton *iconBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 14, 30, 14)];
    iconBtn.titleLabel.font = [UIFont systemFontOfSize:10.0];
    [iconBtn setBackgroundImage:[UIImage imageNamed:@"commodityDetail_icon"] forState:UIControlStateNormal];
    [iconBtn setTitle:@"自营" forState:UIControlStateNormal];
    [iconBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [productInfoView addSubview:iconBtn];
    
    UILabel *priceLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 49, kScreenWidth - 55, 40)];
    priceLable.textColor = [UIColor redColor];
    priceLable.font = [UIFont boldSystemFontOfSize:18.0];
    priceLable.text = @"¥ 1988.00";
    [productInfoView addSubview:priceLable];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
