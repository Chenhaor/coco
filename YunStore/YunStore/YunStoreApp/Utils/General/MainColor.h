//
//  MainColor.h
//  YunStoreApp
//
//  Created by apple on 2017/4/26.
//  Copyright © 2017年 yangye. All rights reserved.
//

#ifndef MainColor_h
#define MainColor_h


#pragma mark - color functions
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define GlobalWhiteColor UIColorFromHexValue(0xffffff)

// rgb颜色转换（16进制->10进制）
#define UIColorFromHexValue(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:1.0]

#define DEFAULT_BACKGROUND_COLOR RGBCOLOR(240, 244, 247)
#define DEFAULT_NAVIGATIONBAR_COLOR RGBCOLOR(240, 20, 56)
#define DEFAULT_CUTTINGLINE_COLOR RGBCOLOR(246, 246, 246)

//文字颜色
#define FIRST_DEGREE_COLOR RGBCOLOR(0, 0, 0)
#define SECOND_DEGREE_COLOR RGBCOLOR(148, 148, 148)
#define THREE_DEGREE_COLOR RGBCOLOR(195, 195, 195)


#endif /* MainColor_h */
