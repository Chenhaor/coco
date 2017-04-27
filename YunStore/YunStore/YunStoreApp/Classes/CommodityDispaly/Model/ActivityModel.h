//
//  ActivityModel.h
//  YunFuStore
//
//  Created by apple on 2017/4/19.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ArchiveModel.h"

@interface ActivityModel : ArchiveModel

@property(nonatomic, assign)NSInteger activityType;//1只有小商品图，2有活动大广告，3有标题
@property(nonatomic, assign)NSInteger commodNum;//小商品图个数
@end
