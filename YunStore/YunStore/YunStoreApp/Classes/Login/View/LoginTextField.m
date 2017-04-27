//
//  LoginTextField.m
//  guoxiaotong
//
//  Created by zxc on 16/4/9.
//  Copyright © 2016年 StenpChou. All rights reserved.
//

#import "LoginTextField.h"

@implementation LoginTextField

- (instancetype)initWithImage:(NSString *)imageName placeHolder:(NSString *)placeholder top:(CGFloat)top {
    if (self = [super init]) {
        
        self.frame = CGRectMake(15, top, kScreenWidth - 30, 50);
        self.clipsToBounds = YES;
        self.layer.borderWidth = 0.5;
        self.layer.cornerRadius = 5;
        self.layer.borderColor = DEFAULT_CUTTINGLINE_COLOR.CGColor;
        
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        [self setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
        [self setValue:[UIFont boldSystemFontOfSize:12.0] forKeyPath:@"_placeholderLabel.font"];
        
        self.placeholder = placeholder;
        
        self.font = [UIFont systemFontOfSize:13.0];
        
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, 17, 17)];
        imageV.center = leftView.center;
        imageV.image = [UIImage imageNamed:imageName];
        [leftView addSubview:imageV];
        
        self.leftView = leftView;
        self.leftViewMode = UITextFieldViewModeAlways;
        
    }
    return self;
}

@end
