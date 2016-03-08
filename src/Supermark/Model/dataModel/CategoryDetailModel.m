//
//  CategoryDetailModel.m
//  Supermark
//
//  Created by 林伟池 on 15/8/20.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "CategoryDetailModel.h"
#import "ShopMessage.h"

@implementation CategoryDetailModel
{
    NSMutableDictionary* dict;
    NSMutableArray* arr;
}

#pragma mark - init

+(instancetype) instance
{
    static CategoryDetailModel* test;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        test = [[CategoryDetailModel alloc] init];
    });
    return test;
}


-(instancetype)init
{
    self = [super init];
    
    dict = [NSMutableDictionary new];
    arr = [[NSMutableArray alloc] init];
    
    return self;
}


#pragma mark - set

-(void)setCategoryDetailGoods:(NSMutableArray*)goods_arr CategoryId:(long)category_id
{
    NSNumber* key = [NSNumber numberWithLong:category_id];
    [dict setObject:goods_arr forKey:key];
    arr = goods_arr;
    
    [self lyPostNotification:NOTIFY_LIST_DATA];
}




#pragma mark - get

-(long)getGoodsCount
{
    return arr.count;
}

-(DetailGoods*)getDetailGoodsByIndex:(long)index
{
    DetailGoods* ret = nil;
    if (index < [self getGoodsCount] && index >= 0) {
        ret = arr[index];
    }
    return ret;
}




#pragma mark - update

-(void)updateCategoryDetailGoodsById:(long)category_id
{
    NSNumber* key = [NSNumber numberWithLong:category_id];
    if ([dict objectForKey:key]) {
        arr = [dict objectForKey:key];
        [self lyPostNotification:NOTIFY_LIST_DATA];
    }
    else{
        [[ShopMessage instance] requestGetSubCategoryGoods:category_id];
    }
    
}


-(void)onShopChange
{
    dict = [NSMutableDictionary new];
    arr = [[NSMutableArray alloc] init];
}

#pragma mark - message


@end
