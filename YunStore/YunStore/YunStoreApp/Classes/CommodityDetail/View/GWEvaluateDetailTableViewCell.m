//
//  GWEvaluateDetailTableViewCell.m
//  YunStoreApp
//
//  Created by apple on 2017/4/25.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import "GWEvaluateDetailTableViewCell.h"
@interface GWEvaluateDetailTableViewCell ()

@property(nonatomic, strong)UIImageView *userImageView;
@property(nonatomic, strong)UILabel *userNamelabel;
@property(nonatomic, strong)UILabel *evaluateLabel;

@property(nonatomic, strong)UIView *imageBackView;
@property(nonatomic, strong)UIView *starBackView;

@property(nonatomic, strong)NSMutableArray *imageViewArray;
@property(nonatomic, strong)NSMutableArray *starArray;

@end

CGFloat evaluateLabelHeight;
CGFloat imageBackViewHeight;
@implementation GWEvaluateDetailTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.selectionStyle=UITableViewCellSelectionStyleNone;

    CALayer *layer=[CALayer layer];
    layer.frame=CGRectMake(10, 0, kScreenWidth-20, 1);
    layer.backgroundColor=RGBCOLOR(243, 243, 243).CGColor;
    [self.contentView.layer addSublayer:layer];
    
    self.userImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 20, 20)];
    self.userImageView.backgroundColor=[UIColor grayColor];
    [self.userImageView.layer setCornerRadius:10];
    [self.userImageView.layer setMasksToBounds:YES];
    [self.contentView addSubview:self.userImageView];
    
    self.userNamelabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.userImageView.frame)+5, 9, 120, 12)];
    self.userNamelabel.font=[UIFont systemFontOfSize:12];
    self.userNamelabel.textColor=RGBCOLOR(139, 139, 139);
    [self.contentView addSubview:self.userNamelabel];
    self.userNamelabel.text=@"inein";
    
    self.evaluateLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 30, kScreenWidth-20, 0)];
    self.evaluateLabel.numberOfLines=0;
    self.evaluateLabel.font=[UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.evaluateLabel];
    
    self.imageBackView=[[UIView alloc]initWithFrame:CGRectMake(0, 35, kScreenWidth, 0)];
    [self.contentView addSubview:self.imageBackView];
    
    self.imageViewArray=[NSMutableArray new];
    for (int a=0; a<4; a++) {
        UIImageView *imageView=[UIImageView new];
        [imageView.layer setBorderWidth:1];
        [imageView.layer setBorderColor:RGBCOLOR(232, 232, 232).CGColor];
        [imageView.layer setMasksToBounds:YES];
        [self.imageViewArray addObject:imageView];
    }
    self.starArray=[NSMutableArray new];
    for (int a=0; a<5; a++) {
        UIImageView *imageView=[UIImageView new];

        [self.starArray addObject:imageView];
    }
    
    self.starBackView=[[UIView alloc]initWithFrame:CGRectMake(kScreenWidth-10, 9, 0, 12)];
    [self.contentView addSubview:self.starBackView];
}

-(void)setModel:(EvaluateDetailModel *)model{
    _model=model;
    self.evaluateLabel.text=_model.evaluateStr;
    
    if (_model.imageArray.count==0) {
        [self.imageBackView removeFromSuperview];
    }
    
    evaluateLabelHeight=[self getHight:_model.evaluateStr andFont:[UIFont systemFontOfSize:14.0f] andWidth:kScreenWidth-20];
    self.evaluateLabel.frame=CGRectMake(10, 30, kScreenWidth-20, evaluateLabelHeight);
    
    if (_model.imageArray.count) {
        self.imageBackView.frame=CGRectMake(0, CGRectGetMaxY(self.evaluateLabel.frame)+5, kScreenWidth, 80);
        CGFloat imageWidth=(kScreenWidth-50)/4;
        for (NSInteger a=0; a<MIN(_model.imageArray.count, 4); a++) {
            
            UIImageView *imageView=self.imageViewArray[a];
           imageView.frame=CGRectMake(10+(imageWidth+10)*a, 0, imageWidth, 80);
            imageView.image=[UIImage imageNamed:_model.imageArray[a]];
            [self.imageBackView addSubview:imageView];
        }
        
    }else{
        [self.imageBackView removeFromSuperview];
    }
    
    if (_model.starNum>0) {
        CGFloat starWidth=12;
        CGFloat starHeight=12;
        CGFloat starSpace=5;
        self.starBackView.frame=CGRectMake(kScreenWidth-10-(starWidth+(starWidth+starSpace)*(_model.starNum-1)), 9, starWidth+(starWidth+starSpace)*(_model.starNum-1), starHeight);
        
        for (int a=0; a<_model.starNum; a++) {
            UIImageView *starImageView=self.starArray[a];
            starImageView.frame=CGRectMake((starWidth+starSpace)*a, 0, starWidth, starHeight);
            starImageView.image=[UIImage imageNamed:@"YF_star"];
            [self.starBackView addSubview:starImageView];
        }
    }
}


-(void)layoutSubviews{
    
    
}

- (CGFloat)getHight:(NSString *)text andFont:(UIFont *)font andWidth:(CGFloat)width
{
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil] ;
    CGFloat hight = rect.size.height;
    return hight ;
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
