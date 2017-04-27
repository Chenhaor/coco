//
//  GWResponseDelegate.h
//  smallWhite
//
//  Created by yangye on 16/5/19.
//  Copyright © 2016年 Shenzhen Gowild Robotics Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol GWResponseDelegate <NSObject>


@required
- (id)initWithData:(id)responseData
               err:(NSError *)err;

@end

