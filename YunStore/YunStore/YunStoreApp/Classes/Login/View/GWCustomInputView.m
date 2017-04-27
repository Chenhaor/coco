//
//  GWCustomInputView.m
//  YunStoreApp
//
//  Created by apple on 2017/4/26.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import "GWCustomInputView.h"

@interface GWCustomInputView()

@property (nonatomic,weak)UITextField *textFild;

@end

@implementation GWCustomInputView

- (id)initInputViewWithFrame:(CGRect)frame
                 iconImgName:(NSString *)iconImgName
                 placeHolder:(NSString *)placeHolder
{
    if (self = [super initWithFrame:frame])
    {
        UIImageView *inputImgView = [[UIImageView alloc] initWithFrame:self.bounds];
        inputImgView.userInteractionEnabled = YES;
        inputImgView.image = [UIImage imageNamed:@"login_input_bg"];
        [self addSubview:inputImgView];
        
        UITextField *textFild = [[UITextField alloc] init];
        textFild.placeholder = placeHolder;
        [inputImgView addSubview:textFild];
        self.textFild = textFild;
        
        UIImage *iconImg = [UIImage imageNamed:iconImgName];
        
        if (iconImg)
        {
            UIImageView *iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, (frame.size.height - 18)/2.0, 12, 18)];
            
            iconImgView.image = [UIImage imageNamed:iconImgName];
            
            [inputImgView addSubview:iconImgView];
            
            CGFloat textFildX = CGRectGetMaxX(iconImgView.frame) + 15;
            
            textFild.frame = CGRectMake(textFildX, 10, frame.size.width - textFildX - 10, frame.size.height - 20);
        }
        else
        {
            textFild.frame = CGRectMake(10, 10, frame.size.width - 20, frame.size.height - 20);
        }
    }

    return self;
}

- (NSString *)text {
    return _textFild.text;
}

@end
