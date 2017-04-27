//
//  RecomTableViewCell.m
//  YunStoreApp
//
//  Created by apple on 2017/4/24.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import "RecomTableViewCell.h"
@interface RecomTableViewCell ()
//@property(nonatomic, strong) UIView *leftView;
//@property(nonatomic, strong) UIView *rightView;

@property(nonatomic, strong) UIImageView *leftImageView;
@property(nonatomic, strong) UIImageView *rightImageView;
@end

static CGFloat space=2;
@implementation RecomTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    
//    self.leftView=[UIView new];
//    [self.contentView addSubview:self.leftView];
//    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(space, 0, space, kScreenWidth/2+space));
//    }];

    self.contentView.backgroundColor=RGBCOLOR(237, 237, 237);
    self.leftImageView=[UIImageView new];
    self.leftImageView.backgroundColor=[UIColor grayColor];
    [self.contentView addSubview:self.leftImageView];
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(space, 0, space, kScreenWidth/2+space));
    }];
    
    
//    self.rightView=[UIView new];
//    [self.contentView addSubview:self.rightView];
//    [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(space, kScreenWidth/2+space, space,0 ));
//    }];
//    
    
    self.rightImageView=[UIImageView new];
    self.rightImageView.backgroundColor=[UIColor yellowColor];
    [self.contentView addSubview:self.rightImageView];
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(space, kScreenWidth/2+space, space,0 ));
    }];
}

-(void)setLeftmodel:(CommodityModel *)leftmodel{
    _leftmodel=leftmodel;
    self.leftImageView.image=[UIImage imageNamed:_leftmodel.commodityImage];
}

-(void)setRightmodel:(CommodityModel *)rightmodel{
    _rightmodel=rightmodel;
    self.rightImageView.image=[UIImage imageNamed:_rightmodel.commodityImage];
}
-(void)layoutSubviews{
    if (_rightmodel==nil) {
        [self.rightImageView removeFromSuperview];
    }

}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
