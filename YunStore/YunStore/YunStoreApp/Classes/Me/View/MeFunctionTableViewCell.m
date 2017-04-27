//
//  MeFunctionTableViewCell.m
//  YunStoreApp
//
//  Created by apple on 2017/4/24.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import "MeFunctionTableViewCell.h"
#import "TagView.h"
#import "TagModel.h"
@interface MeFunctionTableViewCell ()

@property(nonatomic, strong)NSMutableArray *tagViewArray;
@end
@implementation MeFunctionTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}
-(void)createUI{
    
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    _tagViewArray=[NSMutableArray new];
    for (int a=0; a<5; a++) {
        TagView *tagView=[TagView new];
        [_tagViewArray addObject:tagView];
    }
    CALayer *lineLayer=[CALayer layer];
    lineLayer.backgroundColor=DEFAULT_BACKGROUND_COLOR.CGColor;
    lineLayer.frame=CGRectMake(0, 85-1, kScreenWidth, 1);
    [self.contentView.layer addSublayer:lineLayer];
}

-(void)setTagModelArray:(NSMutableArray *)TagModelArray{
    _TagModelArray=TagModelArray;
    
    CGFloat itemWidth;
    CGFloat itemHeight;
    if (_TagModelArray.count==5) {
        itemWidth=kScreenWidth/5;
        itemHeight=85;
        for (int a=0; a<_TagModelArray.count; a++) {
            TagModel *model=_TagModelArray[a];
            
            TagView *tagView=_tagViewArray[a];
            tagView.frame=CGRectMake(itemWidth*a, 0, itemWidth, itemHeight);
            tagView.topDistance=20;
            tagView.model=model;
            [self.contentView addSubview:tagView];
            
            if (a==4) {
                CALayer *layer=[CALayer layer];
                layer.frame=CGRectMake(0, 20, 1, itemHeight-40);
                layer.backgroundColor=DEFAULT_BACKGROUND_COLOR.CGColor;
                [tagView.layer addSublayer:layer];
            }
            
            tagView.tag=1000+a;
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
            [tagView addGestureRecognizer:tap];
        }
    }else if(_TagModelArray.count==4){
        itemWidth=kScreenWidth/4;
        itemHeight=85;
        for (int a=0; a<_TagModelArray.count; a++) {
            TagModel *model=_TagModelArray[a];
            TagView *tagView=_tagViewArray[a];
            tagView.frame=CGRectMake(itemWidth*a, 0, itemWidth, itemHeight);
            tagView.topDistance=15;
            tagView.model=model;
            [self.contentView addSubview:tagView];
            
            tagView.tag=1000+a;
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
            [tagView addGestureRecognizer:tap];
        }
        
    }else if(_TagModelArray.count==3){
        itemWidth=kScreenWidth/3;
        itemHeight=85;
        for (int a=0; a<_TagModelArray.count; a++) {
            TagModel *model=_TagModelArray[a];
            TagView *tagView=_tagViewArray[a];
            tagView.frame=CGRectMake(itemWidth*a, 0, itemWidth, itemHeight);
            tagView.topDistance=15;
            tagView.model=model;
            [self.contentView addSubview:tagView];
            if (a==0||a==1) {
                CALayer *layer=[CALayer layer];
                layer.frame=CGRectMake(itemWidth-1, 28, 1, itemHeight-56);
                layer.backgroundColor=DEFAULT_BACKGROUND_COLOR.CGColor;
                [tagView.layer addSublayer:layer];
            }
            
            tagView.tag=1000+a;
            UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
            [tagView addGestureRecognizer:tap];
        }
    }

}

-(void)layoutSubviews{
    
//    for (UIView *view in self.contentView.subviews) {
//        [view removeFromSuperview];
//    }

}

-(void)tapClick:(UITapGestureRecognizer *)tap{
    UIView *tapView=tap.view;
    TagModel *model=_TagModelArray[tapView.tag-1000];
    NSLog(@"%@",model.tagNameStr);
    
    if (self.subViewClickBlock) {
        self.subViewClickBlock(model.tagNameStr);
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
