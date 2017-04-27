//
//  GWCustomInputView.h
//  YunStoreApp
//
//  Created by apple on 2017/4/26.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GWCustomInputView : UIView

@property (nonatomic,copy)NSString *text;

- (id)initInputViewWithFrame:(CGRect)frame
                 iconImgName:(NSString *)iconImgName
                 placeHolder:(NSString *)placeHolder;

@end
