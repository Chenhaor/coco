//
//  DataFalsification.h
//  YunFuStore
//
//  Created by apple on 2017/4/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataFalsification : NSObject

-(NSMutableArray *)createHomePageCommodityData;
//伪造分类的数据
-(NSMutableArray *)createClassData;
//伪造分类的数据
-(NSMutableArray *)creatDetailDataArray;

//我的数据
-(NSMutableArray *)createMineDataArray;

-(NSMutableArray *)createMineTagDataArray;
//伪造购物车数据
-(NSMutableArray *)craeteShoppingCartData;

//伪造匀富头条数据
-(NSMutableArray *)frontPageData;

//首页固定标签
-(NSArray *)homePageTagImageAndTitle;

//首页活动板块数据
-(NSMutableArray *)activityPlateData;

@end
