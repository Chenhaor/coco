//
//  ClassdetailTableViewCell.m
//  YunFuStore
//
//  Created by apple on 2017/4/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ClassdetailTableViewCell.h"
#import "ClassDetailModel.h"


@interface ClassDetailModel (){
 
}
@end
@implementation ClassdetailTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{

}

-(void)setModelArray:(NSMutableArray *)modelArray{
    
    CGFloat viewWidth=(kScreenWidth-110)/3;
    CGFloat viewHeighth=(kScreenWidth-110)/3+20;
    
    _modelArray=modelArray;
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    for (int a=0; a<_modelArray.count; a++) {
        ClassDetailModel *model=_modelArray[a];
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(viewWidth*(a%3), viewHeighth*(a/3), viewWidth, viewHeighth)];

        UILabel *titlelabel=[[UILabel alloc]initWithFrame:CGRectMake(0, viewWidth, viewWidth, viewHeighth-viewWidth)];
        titlelabel.textColor=RGBCOLOR(184, 184, 184);
        titlelabel.font=[UIFont systemFontOfSize:14];
        titlelabel.textAlignment=NSTextAlignmentCenter;
        titlelabel.text=model.detailTitle;
        [view addSubview:titlelabel];
        
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, viewWidth, viewWidth)];
        imageView.image=[UIImage imageNamed:model.imageStr];
        [view addSubview:imageView];
        [self.contentView addSubview:view];
    }
//    self.frame=CGRectMake(0, 0, kScreenWidth-110, viewHeighth*((_modelArray.count-1)/3+1));
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
