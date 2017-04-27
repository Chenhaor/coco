//
//  ClassScrollCollectionViewCell.m
//  YunStoreApp
//
//  Created by apple on 2017/4/21.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import "ClassScrollCollectionViewCell.h"
#import "ClassDetailModel.h"
@interface ClassScrollCollectionViewCell ()

@property(nonatomic, strong)UIScrollView *scrollView;

@end

static CGFloat viewWidth=80;
static CGFloat viewHeighth=100;

@implementation ClassScrollCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.scrollView=[[UIScrollView alloc]initWithFrame:self.frame];
    self.scrollView.showsHorizontalScrollIndicator=NO;
    self.scrollView.contentOffset=CGPointMake(0, 0);
    
    [self.contentView addSubview:self.scrollView];
}

-(void)setScrollCellDatas:(NSMutableArray *)scrollCellDatas{
    _scrollCellDatas=scrollCellDatas;
    _scrollView.contentSize=CGSizeMake(viewWidth*_scrollCellDatas.count, 0);

    for (int a=0; a<_scrollCellDatas.count; a++) {
        ClassDetailModel *model=_scrollCellDatas[a];
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, viewWidth*a, viewHeighth)];
        
        CALayer *lineLayer=[CALayer layer];
        lineLayer.frame=CGRectMake(viewWidth-1, 15, 1, viewHeighth-30);
        lineLayer.backgroundColor=[UIColor grayColor].CGColor;
        [view.layer addSublayer:lineLayer];
        
        UILabel *titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(0, viewWidth, viewWidth-1, viewHeighth-viewWidth)];
        titlelabel.text=model.detailTitle;
        [view addSubview:titlelabel];
        
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, viewWidth-1, viewWidth)];
        imageView.image=[UIImage imageNamed:@"imageStr"];
        [view addSubview:imageView];
        
        [self.scrollView addSubview:view];
    }

}
@end
