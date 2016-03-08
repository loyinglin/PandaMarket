//
//  LocationModel.m
//  Supermark
//
//  Created by 林伟池 on 15/9/22.
//  Copyright © 2015年 林伟池. All rights reserved.
//

#import "LocationModel.h"

@implementation LocationModel
{
    NSArray* arrShop;
}

+(instancetype) instance
{
    static id test;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        test = [[[self class] alloc] init];
    });
    return test;
}
#pragma mark - init

-(instancetype)init
{
    self = [super init];
    
    return self;
}

- (void)clearCache
{
    arrShop = [NSArray array];
}
#pragma mark - set

- (void)setArrShop:(NSArray *)arr
{
    arrShop = arr;
    [self lyPostEvent:[DataLocationModelEvent instance]];
}


#pragma mark - get

- (long)getArrShopCount
{
    long ret = 0;
    if (arrShop) {
        ret = arrShop.count;
    }
    return ret;
}


- (ShopLocation*)getShopLocationByIndex:(long)index
{
    ShopLocation* ret;
    if (index >= 0 && index < arrShop.count) {
        ret = [arrShop objectAtIndex:index];
    }
    
    return ret;
}

- (ShopLocation*)getShopLocationById:(long)merchantId
{
    ShopLocation* ret;
    for (ShopLocation* item in arrShop) {
        if (item.merchant_id.integerValue == merchantId) {
            ret = item;
        }
    }
    return ret;
}
#pragma mark - update



#pragma mark - message


@end
