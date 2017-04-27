//
//  SingleAddress.h
//  YunStoreApp
//
//  Created by apple on 2017/4/27.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingleAddress : NSObject
@property(nonatomic, strong)NSMutableArray *addressArray;
+ (SingleAddress *)shareAddress;
@end
