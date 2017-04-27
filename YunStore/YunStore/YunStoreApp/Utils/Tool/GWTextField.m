//
//  GWTextField.m
//  GowildXB
//
//  Created by Charse on 16/7/29.
//  Copyright © 2016年 Shenzhen Gowild Robotics Co.,Ltd. All rights reserved.
//

#import "GWTextField.h"

@interface GWTextField()

@end

@implementation GWTextField

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        _numLimit = NSUIntegerMax;
        
        // 监听textFild文字改变的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextFieldTextDidChangeNotification object:self];
        
    }
    
    return self;
}

- (void)textDidChange:(NSNotification *)notification
{
    NSString *toBeString = self.text;
    
    if (toBeString.length > self.numLimit) {
        self.text = [toBeString substringToIndex:self.numLimit];
    }
}

#pragma mark - overload methods
- (CGRect)placeholderRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, self.contentOffset.x, self.contentOffset.y);
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, self.contentOffset.x, self.contentOffset.y);
}

- (CGRect)textRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, self.contentOffset.x, self.contentOffset.y);
}
//
//
- (CGRect)leftViewRectForBounds:(CGRect)bounds {
    
    CGRect textRect = [super leftViewRectForBounds:bounds];
    textRect.origin.x += (bounds.size.height/4);
    return textRect;
}
//
//- (CGRect)rightViewRectForBounds:(CGRect)bounds {
//    
//    CGRect textRect = [super rightViewRectForBounds:bounds];
//    textRect.origin.x -= 10;
//    return textRect;
//}

@end
