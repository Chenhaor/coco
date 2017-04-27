//
//  GWBaseViewController.h
//  YunStoreApp
//
//  Created by apple on 2017/4/20.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GWNavgationItemProtocol.h"

@interface GWBaseViewController : UIViewController<GWNavgationItemProtocol>

- (void)navBackBtnAction;
    
@end
