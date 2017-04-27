//
//  FrontPageModel.h
//  YunFuStore
//
//  Created by apple on 2017/4/19.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ArchiveModel.h"

@interface FrontPageModel : ArchiveModel

@property(nonatomic, strong)NSString *upTitleStr;
@property(nonatomic, strong)NSString *upDetailStr;
@property(nonatomic, strong)NSString *downTitleStr;
@property(nonatomic, strong)NSString *downDetailStr;

@end
