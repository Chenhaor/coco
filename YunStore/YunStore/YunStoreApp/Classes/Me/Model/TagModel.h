//
//  TagModel.h
//  YunStoreApp
//
//  Created by apple on 2017/4/24.
//  Copyright © 2017年 yangye. All rights reserved.
//

#import "ArchiveModel.h"

@interface TagModel : ArchiveModel

@property(nonatomic, assign) BOOL isImage;
@property(nonatomic, strong) NSString *tagImageStr;
@property(nonatomic, strong) NSString *tagNumStr;

@property(nonatomic, strong) NSString *tagNameStr;


@end
