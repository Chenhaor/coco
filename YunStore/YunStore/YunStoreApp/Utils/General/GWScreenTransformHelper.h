//
//  GWScreenTransformHelper.h
//  SmallGowildClient
//
//  Created by Charse on 16/5/30.
//  Copyright © 2016年 Shenzhen Gowild Robotics Co.,Ltd. All rights reserved.
//

#ifndef GWScreenTransformHelper_h
#define GWScreenTransformHelper_h


#define ScreenRect [[UIScreen mainScreen] bounds]

#define GWXBScreenWidth 375
#define GWXBScreenHeight 667


typedef enum _DeviceType
{
    iPhone4_4S  = 10001,
    iPhone5_5S = 10002,
    iPhone6 = 10003,
    iPhone6Plus = 10004,
}DeviceType;

CG_INLINE DeviceType currentDeviceType() {
    CGRect mainFrme = [[UIScreen mainScreen] bounds];
    if (mainFrme.size.height > 667)
    {
        return iPhone6Plus;
    }
    else if (mainFrme.size.height > 568)
    {
        return iPhone6;
    }
    else if (mainFrme.size.height > 480)
    {
        return iPhone5_5S;
    }
    return iPhone4_4S;
}


CG_INLINE CGFloat CurrentScreenScale()
{
    CGRect mainFrme = [[UIScreen mainScreen] bounds];
    return mainFrme.size.width/375.0;
}

CG_INLINE CGFloat TFScalePoint(CGFloat x) {
    if (x != 0)
    {
        CGRect mainFrme = [[UIScreen mainScreen] bounds];
        CGFloat scale = mainFrme.size.width/375.0;
        return x*scale;
    }
    
    return x;
}

CG_INLINE CGPoint TFPointMake(CGFloat x, CGFloat y)
{
    if (x+y)
    {
        CGRect mainFrme = [[UIScreen mainScreen] bounds];
        CGFloat scale = mainFrme.size.width/375.0;
        CGPoint point = CGPointMake(x*scale, y*scale);
        return point;
    }
    
    return CGPointZero;
}

CG_INLINE CGRect TFRectMakeFixWidth(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
    CGRect rect;
    rect.origin.x = TFScalePoint(x);
    rect.origin.y = y;
    rect.size.width = TFScalePoint(width);
    rect.size.height = height;
    return rect;
}

CG_INLINE CGRect TFRectMakeFixHeight(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
    CGRect rect;
    rect.origin.x = x;
    rect.origin.y = TFScalePoint(y);
    rect.size.width = width;
    rect.size.height = TFScalePoint(height);
    return rect;
}

CG_INLINE CGRect TFRectMake(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
    CGRect rect;
    rect.origin.x = TFScalePoint(x);
    rect.origin.y = TFScalePoint(y);
    rect.size.width = TFScalePoint(width);
    rect.size.height = TFScalePoint(height);
    return rect;
}

CG_INLINE CGRect TFRectMakeWithRect(CGRect nrect)
{
    CGRect rect;
    rect.origin.x = TFScalePoint(nrect.origin.x);
    rect.origin.y = TFScalePoint(nrect.origin.y);
    rect.size.width = TFScalePoint(nrect.size.width);
    rect.size.height = TFScalePoint(nrect.size.height);
    return rect;
}

#endif /* GWScreenTransformHelper_h */
