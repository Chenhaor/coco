//
//  GWStoreTableViewCell.m
//  YunStoreApp
//
//  Created by apple on 2017/4/25.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import "GWStoreTableViewCell.h"
@interface GWStoreTableViewCell ()

@property(nonatomic, strong)UIImageView *logoImageView;
@property(nonatomic, strong)UILabel *storeNameLabel;
@property(nonatomic, strong)UILabel *subordinateNamelabel;
@property(nonatomic, strong)UILabel *selfSupportLabel;
@property(nonatomic, strong)UILabel *goToStoreLabel;


@end

@implementation GWStoreTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}
-(void)createUI{
    
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.logoImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 13, 55, 25)];
    [self.contentView addSubview:self.logoImageView];
    self.logoImageView.backgroundColor=[UIColor redColor];
    
    self.storeNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(80, 10, 95, 15)];
    self.storeNameLabel.font=[UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.storeNameLabel];
    self.storeNameLabel.text=@"欧莱雅品牌馆";
    
    self.subordinateNamelabel=[[UILabel alloc]initWithFrame:CGRectMake(80, 30, 70, 10)];
    self.subordinateNamelabel.font=[UIFont systemFontOfSize:10];
    self.subordinateNamelabel.textColor=RGBCOLOR(189, 189, 189);
    [self.contentView addSubview:self.subordinateNamelabel];
    self.subordinateNamelabel.text=@"faugn iouni";
    
    
//    self.selfSupportLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.storeNameLabel.frame)+10, 10, 31, 14)];
//    self.selfSupportLabel.textAlignment=NSTextAlignmentCenter;
//    [self.selfSupportLabel.layer setCornerRadius:3];
//    [self.selfSupportLabel.layer setBorderWidth:1.0f];
//    [self.selfSupportLabel.layer setBorderColor:RGBCOLOR(247, 216, 213).CGColor];
//    self.selfSupportLabel.font=[UIFont systemFontOfSize:13];
//    [self.contentView addSubview:self.selfSupportLabel];
//    self.selfSupportLabel.text=@"自营";
    
    self.goToStoreLabel=[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-52-10, 14, 52, 13)];
    self.goToStoreLabel.text=@"进入店铺";
    self.goToStoreLabel.textAlignment=NSTextAlignmentCenter;
    self.goToStoreLabel.font=[UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.goToStoreLabel];
}

-(void)layoutSubviews{

        CGRect storeNameRect = [[NSString stringWithFormat:@"%@",_storeNameLabel.text] boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 15) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15.0]} context:nil];
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
