//
//  GWAlertView.h
//  Holoera
//
//  Created by gowild on 16/11/3.
//  Copyright © 2016年 gowild. All rights reserved.
//

#import "GWCustomerAlertView.h"

@interface GWAlertView : GWCustomerAlertView

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
                    leftTitle:(NSString *)leftTitle
                   rightTitle:(NSString *)rightTitle;

@end
