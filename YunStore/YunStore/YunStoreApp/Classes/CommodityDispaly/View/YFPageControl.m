//
//  YFPageControl.m
//  YunFuStore
//
//  Created by apple on 2017/4/11.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "YFPageControl.h"

@implementation YFPageControl

- (void)setCurrentPage:(NSInteger)currentPage {
    [super setCurrentPage:currentPage];
    [self updateCurrentPageImage];
}

- (void)updateCurrentPageImage {
    for (int i = 0; i < self.subviews.count; i++){
        UIImageView *image = [self.subviews objectAtIndex:i];
        image.backgroundColor = [UIColor whiteColor];
//        CGSize originalSize = image.frame.size;
        CGSize size = CGSizeZero;
        size.height = 3;
        size.width = 13;
        
        [image setFrame:CGRectMake(image.frame.origin.x, image.frame.origin.y, size.width, size.height)];
//        for (UIView *view in image.subviews) {
//            [view removeFromSuperview];
//        }
//        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height)];
//        [image addSubview:imageView];
        if (i == self.currentPage) {
            image.backgroundColor=RGBCOLOR(245, 133, 39);
//            imageView.image=[UIImage imageNamed:@"currentPage"];
        } else {
            image.backgroundColor=RGBCOLOR(221, 221, 221);
//            imageView.image=[UIImage imageNamed:@"currentPag_ nomal"];
        }
    }
}

@end
