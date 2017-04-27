//
//  ActivityPlateCollectionViewCell.m
//  YunFuStore
//
//  Created by apple on 2017/4/19.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ActivityPlateCollectionViewCell.h"
#import "ActivityView.h"

static CGFloat activityHeight=90;
static CGFloat fiveCommodHeight=180;
static CGFloat sixCommodHeight=140;
static CGFloat titleHeight=30;

static CGFloat minSpacin=2;
static CGFloat maxSpacin=5;


static

@interface ActivityPlateCollectionViewCell ()

@property(nonatomic, strong)ActivityView *activityView;

@property(nonatomic, strong)UIView *commodityView;
@property(nonatomic, strong)UIImageView *titleIamgeView;



@end

@implementation ActivityPlateCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    
    self.commodityView=[UIView new];
    [self.contentView addSubview:self.commodityView];
    
}

-(void)setModel:(ActivityModel *)model{
    _model=model;
    
    if (_model.activityType==1) {
        if (_model.commodNum==5) {
            self.commodityView.frame=CGRectMake(0, 0, kScreenWidth, fiveCommodHeight);
        }else if (_model.commodNum==6){
            self.commodityView.frame=CGRectMake(0, 0, kScreenWidth, sixCommodHeight);
        }
        [self createCommodityView];
        
    }else if (_model.activityType==2){
        self.activityView=[[ActivityView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, activityHeight)];
        self.activityView.activityIamgeView.image=[UIImage imageNamed:@"spike-bg"];
        [self.contentView addSubview:self.activityView];
        
        if (_model.commodNum==5) {
            self.commodityView.frame=CGRectMake(0, activityHeight, kScreenWidth, fiveCommodHeight);
        }else if (_model.commodNum==6){
            self.commodityView.frame=CGRectMake(0, activityHeight, kScreenWidth, sixCommodHeight);
        }
        [self createCommodityView];
    }else{
        self.activityView=[[ActivityView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, activityHeight)];
        self.activityView.activityIamgeView.image=[UIImage imageNamed:@"floor-banner1"];
        [self.contentView addSubview:self.activityView];
        
        self.titleIamgeView=[[UIImageView alloc]initWithFrame:CGRectMake(0, activityHeight+maxSpacin, kScreenWidth, titleHeight)];
        self.titleIamgeView.image=[UIImage imageNamed:@"title_section_1"];
        [self.contentView addSubview:self.titleIamgeView];
        
        if (_model.commodNum==5) {
            self.commodityView.frame=CGRectMake(0, activityHeight+maxSpacin+titleHeight, kScreenWidth, fiveCommodHeight);
        }else if (_model.commodNum==6){
            self.commodityView.frame=CGRectMake(0, activityHeight+maxSpacin+titleHeight, kScreenWidth, sixCommodHeight);
        }
        [self createCommodityView];
    }
}

-(void)createCommodityView{
    switch (_model.commodNum) {
        case 5:
        {
            for (int a=0; a<5; a++) {
                UIImageView *commodimageView=[UIImageView new];
                commodimageView.backgroundColor=[UIColor yellowColor];
                CGFloat commodImageWidth=(kScreenWidth-minSpacin*2)/3;
                if (a==0) {
                    commodimageView.frame=CGRectMake(0, 0,commodImageWidth , fiveCommodHeight);
                    commodimageView.image=[UIImage imageNamed:@"big_1"];
                }else{
                    CGFloat commodImageHeight=(fiveCommodHeight-minSpacin)/2;
                    commodimageView.frame=CGRectMake((commodImageWidth+minSpacin)*((a-1)%2+1), (commodImageHeight+minSpacin)*((a-1)/2), commodImageWidth, commodImageHeight);
                    commodimageView.image=[UIImage imageNamed:@"tu_5_4"];
                }
                [self.commodityView addSubview:commodimageView];
            }
        }
            break;
            
        case 6:
        {
            for (int a=0; a<6; a++) {
                UIImageView *commodimageView=[UIImageView new];
                commodimageView.backgroundColor=[UIColor yellowColor];
                CGFloat commodImageWidth=(kScreenWidth-minSpacin*2)/3;
                if (a==0) {
                    commodimageView.frame=CGRectMake(0, 0,commodImageWidth , sixCommodHeight);
                    commodimageView.image=[UIImage imageNamed:@"big_2"];
                }else if(a<=2){
                    CGFloat commodImageHeight=(sixCommodHeight-minSpacin)/2;
                    commodimageView.frame=CGRectMake((commodImageWidth+minSpacin)*((a-1)%2+1), 0, commodImageWidth, commodImageHeight);
                    commodimageView.image=[UIImage imageNamed:@"tu_6_1"];
                }else{
                    CGFloat commodImageHeight=(sixCommodHeight-minSpacin)/2;
                    commodImageWidth=((kScreenWidth*2)/3-2*minSpacin)/3;
                    commodimageView.frame=CGRectMake(kScreenWidth/3+(commodImageWidth+minSpacin)*((a-3)%3), commodImageHeight+minSpacin, commodImageWidth, commodImageHeight);
                    commodimageView.image=[UIImage imageNamed:@"tuxia_6_1"];
                    
                }
                [self.commodityView addSubview:commodimageView];
            }
        }
            break;
            
        default:
            break;
    }
    
}
@end
