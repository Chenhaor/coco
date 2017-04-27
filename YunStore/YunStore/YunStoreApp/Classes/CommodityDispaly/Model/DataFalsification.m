//
//  DataFalsification.m
//  YunFuStore
//
//  Created by apple on 2017/4/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "DataFalsification.h"
#import "CommodityModel.h"
#import "ClassModel.h"
#import "ClassDetailModel.h"

#import "shopCommodityModel.h"
#import "FrontPageModel.h"
#import "ActivityModel.h"

#import "TagModel.h"


@implementation DataFalsification

-(NSMutableArray *)createHomePageCommodityData{
    
    NSMutableArray *marray=[[NSMutableArray alloc]init];
    int max=arc4random()%10+3;
    for (int a=0; a<max; a++) {
        CommodityModel *model=[[CommodityModel alloc]init];
        model.commodityName=[NSString stringWithFormat:@"商品%d",a];
        model.commodityImage=[NSString stringWithFormat:@"H_commodity%d",arc4random()%7];
        [marray addObject:model];
    }
    return marray;
}

-(NSMutableArray *)createClassData{
    
    NSMutableArray *mArray=[[NSMutableArray alloc]initWithArray:@[@"大健康馆",@"健康食品",@"居家用品",@"家电数码",@"美肤专家"]];
    NSMutableArray *classDataArray=[[NSMutableArray alloc]init];
    for (int a=0; a<mArray.count; a++) {
        ClassModel *classModel=[ClassModel new];
        classModel.titleStr=mArray[a];
        [classDataArray addObject:classModel];
    }
    return classDataArray;
}

-(NSMutableArray *)creatDetailDataArray{
    NSMutableArray *detailDataArray=[NSMutableArray new];
    int max=arc4random()%3+2;
    for (int a=0 ; a<max; a++) {
        int detailMax=arc4random()%5+5;
        NSMutableArray *mArray=[NSMutableArray new];
        for (int i=0; i<detailMax; i++) {
            ClassDetailModel *detailModel=[ClassDetailModel new];
            detailModel.detailTitle=[NSString stringWithFormat:@"第%d_%d款",a,i];
            detailModel.imageStr=[NSString stringWithFormat:@"commodity_%d",arc4random()%4+1];
            [mArray addObject:detailModel];
        }
        [detailDataArray addObject:mArray];
    }
    return detailDataArray;
}

-(NSMutableArray *)createMineDataArray{
    NSMutableArray *mineArray=[NSMutableArray new];
    
    for (int a=0; a<4; a++) {
        NSMutableArray *mArray=[NSMutableArray new];
        for (int i=0; i<4; i++) {
            CommodityModel *model=[CommodityModel new];
            model.commodityName=@"代付款";
            model.commodityImage=[NSString stringWithFormat:@"icon_%d_%d",a,i];
            [mArray addObject:model];
        }
        [mineArray addObject:mArray];
    }
    return mineArray;
}


-(NSMutableArray *)createMineTagDataArray{
    NSMutableArray *mineArray=[NSMutableArray new];
    
    for (int i=0; i<4; i++) {
        NSMutableArray *mArray=[NSMutableArray new];


            if (i==0) {
                NSArray *tagNameArray=@[@"匀富余额",@"匀富钱包",@"优惠劵"];
                NSArray *tagNumArray=@[@"100",@"29",@"1"];
                for (int a=0; a<tagNumArray.count; a++) {
                    TagModel *model=[TagModel new];
                    model.tagNameStr=tagNameArray[a];
                    model.tagNumStr=tagNumArray[a];
                    model.isImage=NO;
                    [mArray addObject:model];
                }

            }else if (i==1){

                NSArray *tagNameArray=@[@"代付款",@"待收货",@"待评价",@"退货/售后",@"我的订单"];
                NSArray *tagimageArray=@[@"me_dfk",@"me_dsh",@"me_dpj",@"me_thsh",@"me_wddd"];
                for (int a=0; a<tagNameArray.count; a++) {
                    TagModel *model=[TagModel new];
                    model.tagNameStr=tagNameArray[a];
                    model.tagImageStr=tagimageArray[a];
                    model.isImage=YES;
                    [mArray addObject:model];
                }
            }else if (i==2){
            
                NSArray *tagNameArray=@[@"商品关注",@"商铺关注",@"浏览记录",@"客户服务",@"我的钱包"];
                NSArray *tagNumArray=@[@"100",@"1",@"29"];
                for (int a=0; a<tagNumArray.count; a++) {
                    TagModel *model=[TagModel new];
                    model.tagNameStr=tagNameArray[a];
                    model.tagNumStr=tagNumArray[a];
                    model.isImage=NO;
                    [mArray addObject:model];
                }
                
                TagModel *model=[TagModel new];
                model.tagNameStr=tagNameArray[3];
                model.tagImageStr=@"me_khfw";
                model.isImage=YES;
                [mArray addObject:model];
            
            }else if (i==3){
                NSArray *tagNameArray=@[@"地址管理",@"我的活动",@"功能反馈",@"关于我们"];
                NSArray *tagimageArray=@[@"me_dzgl",@"me_wdhd",@"me_gnfk",@"me_gywm"];
                for (int a=0; a<tagNameArray.count; a++) {
                    TagModel *model=[TagModel new];
                    model.tagNameStr=tagNameArray[a];
                    model.tagImageStr=tagimageArray[a];
                    model.isImage=YES;
                    [mArray addObject:model];
                }
            }
        
        [mineArray addObject:mArray];
    }
    return mineArray;
}

-(NSMutableArray *)craeteShoppingCartData{
    NSMutableArray *shopCartDatas=[NSMutableArray new];
    for (int a=0; a<4; a++) {
        shopCommodityModel *model=[shopCommodityModel new];
        model.cargoImageStr=[NSString stringWithFormat:@"commodity_%d",arc4random()%4+1];
        model.cargoName=@"萌露士蜂蜜A，蜂蜜酿造天数20天以上";
        model.cargoStandard=@"萌露士蜂蜜A，蜂蜜酿";
        model.cargoPrice=arc4random()%100+50;
        model.cargoNum=a;
        model.cargoTotalprices=model.cargoPrice*a;
        [shopCartDatas addObject:model];
    }
    return shopCartDatas;
}

-(NSMutableArray *)frontPageData{
NSMutableArray *frontPageDatas=[NSMutableArray new];
    for (int a=0; a<4; a++) {
        FrontPageModel *model=[FrontPageModel new];
        model.upTitleStr=[NSString stringWithFormat:@"限时%d",a];
        model.upDetailStr=[NSString stringWithFormat:@"限时抢购%d",a];
        model.downTitleStr=[NSString stringWithFormat:@"爆款%d",a];
        model.downDetailStr=[NSString stringWithFormat:@"爆款抢购%d",a];
        [frontPageDatas addObject:model];
    }
    return frontPageDatas;
}

-(NSArray *)homePageTagImageAndTitle{
    
    NSArray *imageArray=@[@"xpss",@"djkg",@"xxsp",@"jpfs",@"mzhf",@"clbk",@"myyp",@"qdhb",@"jdsm",@"jpxb"];

    NSArray *titleArray=@[@"新品上市",@"大健康馆",@"休闲食品",@"精品服饰",@"美妆护肤",@"潮流爆款",@"母婴用品",@"签到红包",@"家电数码",@"精品箱包"];
    
    NSArray *mArray=@[imageArray,titleArray];
    return mArray;
}

-(NSMutableArray *)activityPlateData{
    NSMutableArray *mArray=[NSMutableArray new];
    ActivityModel *model1=[ActivityModel new];
    model1.activityType=2;
    model1.commodNum=5;
    
    ActivityModel *model2=[ActivityModel new];
    model2.activityType=3;
    model2.commodNum=6;
    
    ActivityModel *model3=[ActivityModel new];
    model3.activityType=3;
    model3.commodNum=6;
    
    [mArray addObjectsFromArray:@[model1,model2,model3]];
    
    return mArray;
}
@end
