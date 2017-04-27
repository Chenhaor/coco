//
//  ClassScrollTableViewCell.m
//  YunStoreApp
//
//  Created by apple on 2017/4/21.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import "ClassScrollTableViewCell.h"
#import "ClassDetailModel.h"

static CGFloat viewWidth=80;
static CGFloat viewHeighth=100;

@interface ClassScrollTableViewCell ()

@property(nonatomic, strong)UIScrollView *scrollView;

@end
@implementation ClassScrollTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}


-(void)createUI{
    self.scrollView=[UIScrollView new];
    self.scrollView.showsHorizontalScrollIndicator=NO;
    self.scrollView.contentOffset=CGPointMake(0, 0);
    [self.contentView addSubview:self.scrollView];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

-(void)setScrollCellDatas:(NSMutableArray *)scrollCellDatas{
    _scrollCellDatas=scrollCellDatas;
    _scrollView.contentSize=CGSizeMake(viewWidth*_scrollCellDatas.count, 0);
    
    for (int a=0; a<_scrollCellDatas.count; a++) {
        ClassDetailModel *model=_scrollCellDatas[a];
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(viewWidth*a, 0, viewWidth, viewHeighth)];
        
        CALayer *lineLayer=[CALayer layer];
        lineLayer.frame=CGRectMake(viewWidth-1, 20, 1, viewHeighth-40);
        lineLayer.backgroundColor=DEFAULT_BACKGROUND_COLOR.CGColor;
        [view.layer addSublayer:lineLayer];
        
        UILabel *titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(0, viewWidth, viewWidth-1, viewHeighth-viewWidth)];
        titlelabel.textColor=RGBCOLOR(184, 184, 184);
        titlelabel.font=[UIFont systemFontOfSize:14];
        titlelabel.textAlignment=NSTextAlignmentCenter;
        titlelabel.text=model.detailTitle;
        [view addSubview:titlelabel];
        
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, viewWidth-1, viewWidth)];
        imageView.image=[UIImage imageNamed:model.imageStr];
        [view addSubview:imageView];
        
        [self.scrollView addSubview:view];
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
