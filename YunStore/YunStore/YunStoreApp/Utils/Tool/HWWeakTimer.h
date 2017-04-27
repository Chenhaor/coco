//
//  CircularSlider.h
//
//  Created by yangye on 16/2/26.
//  Copyright © 2016年. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^HWTimerHandler)(id userInfo);

@interface HWWeakTimer : NSObject

+ (NSTimer *) scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                      target:(id)aTarget
                                    selector:(SEL)aSelector
                                    userInfo:(id)userInfo
                                     repeats:(BOOL)repeats;

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                      block:(HWTimerHandler)block
                                   userInfo:(id)userInfo
                                    repeats:(BOOL)repeats;

@end
