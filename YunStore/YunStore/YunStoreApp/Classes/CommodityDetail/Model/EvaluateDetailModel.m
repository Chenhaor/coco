//
//  EvaluateDetailModel.m
//  YunStoreApp
//
//  Created by apple on 2017/4/25.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import "EvaluateDetailModel.h"

@implementation EvaluateDetailModel

- (void)getcellHight{
     CGFloat  evaluateLabelHeight=[self getHight:_evaluateStr andFont:[UIFont systemFontOfSize:14.0f] andWidth:kScreenWidth-20];
    if (_imageArray.count>0) {
        _cellHeight=30+evaluateLabelHeight+80+10;
    }else{
        _cellHeight=30+evaluateLabelHeight+10;
    }
}
- (CGFloat)getHight:(NSString *)text andFont:(UIFont *)font andWidth:(CGFloat)width
{
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil] ;
    CGFloat hight = rect.size.height;
    return hight ;
}
@end
