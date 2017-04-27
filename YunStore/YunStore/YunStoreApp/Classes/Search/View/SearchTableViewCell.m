//
//  SearchTableViewCell.m
//  YunStoreApp
//
//  Created by apple on 2017/4/21.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import "SearchTableViewCell.h"

@implementation SearchTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{

}

-(void)setTitleArray:(NSMutableArray *)titleArray{
    _titleArray=titleArray;
    CGFloat spaceWith=15;
    CGFloat spaceheight=15;
    CGFloat butnWidth=(kScreenWidth-spaceWith*5)/4;
    CGFloat butnHeight=25;
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    for (int a=0; a<titleArray.count; a++) {
        UIButton *titleButn=[UIButton buttonWithType:UIButtonTypeCustom];
        titleButn.frame=CGRectMake(spaceWith+(butnWidth+spaceWith)*(a%4), spaceheight+(butnHeight+spaceheight)*(a/4), butnWidth, butnHeight);
        NSString *str=titleArray[a];
        [titleButn setBackgroundColor:RGBCOLOR(175, 175, 175)];
        [titleButn setTitle:str forState:UIControlStateNormal];
        [titleButn addTarget:self action:@selector(titleButnClcik:) forControlEvents:UIControlEventTouchUpInside];
        [titleButn.layer setCornerRadius:5];
        [titleButn.layer setMasksToBounds:YES];
        [self.contentView addSubview:titleButn];
    }
}

-(void)titleButnClcik:(UIButton *)butn{
    if (_searchButnClick) {
        _searchButnClick(butn.titleLabel.text);
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
