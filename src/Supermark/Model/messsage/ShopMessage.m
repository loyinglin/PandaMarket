//
//  ShopMessage.m
//  Supermark
//
//  Created by 林伟池 on 15/8/18.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "ShopMessage.h"
#import "CartMessage.h"

#import "ServiceModel.h"
#import "CategoryDetailModel.h"
#import "CartModel.h"

@implementation ShopMessage


/**
 *  获取子类的信息
 *
 *  @param sub_category_id 子类ID
 */
-(void)requestGetSubCategoryGoods:(long)sub_category_id
{
    long merchant_id = [[ShopModel instance] getCurrentMerchantId];
    
    
    NSDictionary* dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                          [NSNumber numberWithLong:merchant_id], @"merchant_id",
                          [NSNumber numberWithLong:sub_category_id], @"sub_category_id",
                          nil];
    
    [self sendRequestWithPost:[msgHttpPrefix stringByAppendingString:(NSString*)msgGetSubCategoryGoods] Param:dict success:^(id responseObject){
        NSArray* arr = (NSArray*)responseObject;
        
        NSMutableArray* goods = [NSMutableArray array];
        for (NSDictionary* dict in arr) {
            if ([dict isKindOfClass:[NSDictionary class]]){
                DetailGoods* detail_goods = [dict objectForClass:[DetailGoods class]];
                [goods addObject:detail_goods];
            }
        }
        [[CategoryDetailModel instance] setCategoryDetailGoods:goods CategoryId:sub_category_id];
    }];

    
    
    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", nil];
//    
//    [manager GET:str parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:[operation.responseString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
//        
//        ListData* listData = [dict objectForClass:[ListData class]];
//        [ShopModel instance].listData = listData;
//        [self lyPostNotification:NOTIFY_LIST_DATA];
//        [[CategoryDetailModel instance] setCategoryDetailGoods:nil];
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        LYLog(@"Error: %@", error);
//    }];
//    
    
}


/**
 *  拉取商店信息
 *
 *  @param merchant_id 商店ID
 */
-(void)requestGetMerchantInfo:(long)merchant_id
{
    long info_id = merchant_id;

    NSDictionary* dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                          [NSNumber numberWithLong:info_id], @"id",
                          nil];
    
    [self sendRequestWithPost:[msgHttpPrefix stringByAppendingString:(NSString*)msgMerchantInfo] Param:dict success:^(id responseObject){
        NSDictionary* dict = (NSDictionary*)responseObject;
        NSDictionary* data = [dict objectForKey:@"sys_info"];
        Sys_info *info = [data objectForClass:[Sys_info class]];
        
        data = [dict objectForKey:@"merchant"];
        Merchant *merchant = [data objectForClass:[Merchant class]]; //对象需要手动解析
        
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        
        data = [data objectForKey:@"category"];
        
        if (data.count) {
            NSEnumerator *enumerator = [data keyEnumerator];
            id key;
            while (key = [enumerator nextObject]) {
                NSDictionary* objDict = [data objectForKey:key];
                IndexCategory* index = [objDict objectForClass:[IndexCategory class]];
                [arr addObject:index];
            }

        }
        merchant.category = arr;
        
        [[ShopModel instance] setMerchantInfo: merchant];
        [[ShopModel instance] setSysInfo: info];
        
        [self lyPostNotification:NOTIFY_INDEX_DATA];
        
        ShopLocation* location = [[LocationModel instance] getShopLocationById:merchant_id];

        if (location) {
            [[RecentShopModel instance] setShopLocation:location];
        }
        else{ //此刻有商店A/B，直接从A切换到B，那么没有定位数据
            location = [[RecentShopModel instance] getShopLocationByMerchantId:merchant_id];
            if (location) {
                [[RecentShopModel instance] setShopLocation:location];
            }
        }
        
        [[CartModel instance] onShopChange];
        [[CategoryDetailModel instance] onShopChange];
        [[ServiceModel instance] onShopChange];
    }];
}

-(void)requestGetCommunityServerById:(long)areaId
{    
    NSDictionary* dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                          [NSNumber numberWithLong:areaId], @"community_id",
                          nil];
    
    [self sendRequestWithPost:[msgHttpPrefix stringByAppendingString:(NSString*)msgGetCommunityServerById] Param:dict success:^(id responseObject){
        NSMutableArray* arr = (NSMutableArray*)responseObject;
        NSMutableArray* data = [NSMutableArray array];

        for (NSDictionary* dict in arr) {
            SimpleService* service = [dict objectForClass:[SimpleService class]];
            [data addObject:service];
        }
        
        [[ServiceModel instance] setServiceArr:data];        
    }];

    
}
@end
