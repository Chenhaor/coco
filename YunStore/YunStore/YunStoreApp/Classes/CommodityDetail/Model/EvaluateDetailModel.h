//
//  EvaluateDetailModel.h
//  YunStoreApp
//
//  Created by apple on 2017/4/25.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import "ArchiveModel.h"

@interface EvaluateDetailModel : ArchiveModel

@property(nonatomic, strong)NSString *evaluateStr;
@property(nonatomic, assign)NSInteger starNum;
@property(nonatomic, strong)NSMutableArray *imageArray;
@property(nonatomic, assign)CGFloat cellHeight;

- (void)getcellHight;
@end
