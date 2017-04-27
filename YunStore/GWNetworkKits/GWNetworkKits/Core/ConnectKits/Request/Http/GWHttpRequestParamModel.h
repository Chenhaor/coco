//
//  GWHttpRequestParam.h
//  SmallGowildClient
//
//  Created by yangye on 16/5/26.
//  Copyright © 2016年 2016年 Shenzhen Gowild Robotics Co.,Ltd. All rights reserved.
//

#import "GWRequestDelegate.h"
#import "GWHttpJWTResponseBase.h"
#import "GWHttpResponseBase.h"
#import "GWConnectManager.h"

typedef NS_ENUM(NSUInteger, GWHTTPREQURSTTYPE)
{
    HTTP_REQUESTPYE_POST  = 1,  //POST请求
    HTTP_REQUESTPYE_GET,  //GET请求
};

typedef NS_ENUM(NSUInteger, GWHTTPREQURSTPAMARFORMAT)
{
    HTTP_PARMA_FORMAT_JSON  = 1,  //JSON格式的
    HTTP_PARMA_FORMAT_KEYVALUE,  //KeyValue格式 ，默认格式
};

@interface GWHttpRequestParamModel : NSObject
<
GWRequestDelegate
>


/**
 *  request type default is POST
 */
@property (nonatomic, assign) GWHTTPREQURSTTYPE reqType;
@property (nonatomic, assign) GWHTTPREQURSTPAMARFORMAT parmaFormat;
@property (nonatomic, copy) NSString *interfaceUrl;
@property (nonatomic, copy) NSString *authorization; //header 验证

/**
 *  sometime request key is system reserved keywords like "id" need replace.
 *
 *  @return need transfer key dic
 */
- (NSDictionary *)keysTransfer;

/**
 *  some property only use define, can't send
 *
 *  @return ignore list
 */
- (NSSet *)ignoreList;

@end
