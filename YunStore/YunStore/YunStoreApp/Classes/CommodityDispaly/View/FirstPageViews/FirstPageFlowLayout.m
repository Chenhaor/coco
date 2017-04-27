//
//  FirstPageFlowLayout.m
//  YunFuStore
//
//  Created by apple on 2017/4/19.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "FirstPageFlowLayout.h"
#import "ActivityModel.h"


#define sectionHeight 5*2+kScreenWidth/2
#define marginW 2
#define marginH 6

static CGFloat carouselHeight=370/2;
#define tagViewHeight 70*2
static CGFloat vCarouselheight=60;//竖着的轮播图高
//static CGFloat tagViewHeight=(kScreenWidth/5+20);
static CGFloat activityCellHeight=90;
//static CGFloat sectionHeadHeight=120;

@interface FirstPageFlowLayout (){
    CGFloat baseHeight;
}

@end
@implementation FirstPageFlowLayout

-(void)prepareLayout{
    [super prepareLayout];

    [self setScrollDirection:UICollectionViewScrollDirectionVertical];
//    self.itemSize = CGSizeMake(kScreenWidth/4, kScreenWidth/4);
    self.minimumLineSpacing=0;
    self.minimumInteritemSpacing=0;
    self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
//    self.headerReferenceSize=CGSizeMake(kScreenWidth, 300);
    
}

//-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
//{
//    return YES;
//}

- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    NSMutableArray* attributes = [NSMutableArray array];
    for (UICollectionViewLayoutAttributes *attri in array) {
        NSIndexPath* indexPath = attri.indexPath;
                    [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
        return attributes;
}

- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
        UICollectionViewLayoutAttributes *attris=[UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    if (indexPath.section==0) {
            attris.frame=CGRectMake(0, 0, kScreenWidth, carouselHeight);
    }else if (indexPath.section==1){
        baseHeight=carouselHeight;
        CGFloat cellWidth=kScreenWidth/5;
        CGFloat cellHeight=tagViewHeight/2;
        attris.frame=CGRectMake(cellWidth*(indexPath.row%5), baseHeight+cellHeight*(indexPath.row/5), cellWidth, cellHeight);
        
    }else if (indexPath.section==2){
        baseHeight=carouselHeight+tagViewHeight;
        attris.frame=CGRectMake(0, baseHeight, kScreenWidth, vCarouselheight);
    }else if (indexPath.section==3){
//        static CGFloat activityHeight=90;
//        static CGFloat fiveCommodHeight=180;
//        static CGFloat sixCommodHeight=140;
//        static CGFloat titleHeight=30;
        
        CGFloat cellheight=0;
        ActivityModel *model=_activityModelArray[indexPath.row];
            if (model.activityType==2&&model.commodNum==5) {
                cellheight=180+90;
            }else if (model.activityType==3&&model.commodNum==6){
                cellheight=140+90+30+5;
            }
        if (indexPath.row==0) {
            baseHeight=carouselHeight+tagViewHeight+vCarouselheight+marginH;
        }else{
        
        }
        attris.frame=CGRectMake(0, baseHeight, kScreenWidth, cellheight);
        baseHeight+=(cellheight+marginH);
    }
    
    return attris;
}


-(CGSize)collectionViewContentSize{
    return CGSizeMake(kScreenWidth, baseHeight+44+64);
}


@end
