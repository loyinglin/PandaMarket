//
//  RecentShopModel.m
//  Supermark
//
//  Created by 林伟池 on 15/9/23.
//  Copyright © 2015年 林伟池. All rights reserved.
//

#import "RecentShopModel.h"

@implementation RecentShopModel
{
    NSMutableArray<ShopLocation*>* arrInfo;
}

#pragma mark - init
+(instancetype) instance
{
    static id test;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        test = [[[self class] alloc] init];
    });
    return test;
}

-(instancetype)init
{
    self = [super init];
    
    arrInfo = [NSMutableArray array];
    [self loadCache];
    return self;
}

-(void)loadCache
{
    NSData* data = [[NSUserDefaults standardUserDefaults] objectForKey:[[self class] description]];
    if (data) {
        arrInfo = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
}

- (void)clearCache
{
    arrInfo = [NSMutableArray array];
    [self saveCache];
}

-(void)saveCache
{
    while (arrInfo.count > 3) {
        [arrInfo removeLastObject];
    }
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:arrInfo];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:[[self class] description]];
}
#pragma mark - set

- (void)setShopLocation:(ShopLocation *)current
{
    ShopLocation* info;
    current.test = [NSMutableString stringWithFormat:@"%@", @"ac"];
    current.arr = [NSMutableArray arrayWithObjects:@"abc", current.test, nil];
    ShopLocation* test = [current copy];
    for (ShopLocation* item in arrInfo) {
        if (item._id.integerValue == current._id.integerValue) {
            info = item;
            break;
        }
    }
    if (!info) {
        info = [ShopLocation instanceWith:current];
    }
    else{
        [arrInfo removeObject:info];
    }
    [arrInfo insertObject:info atIndex:0];
    [self saveCache];
    
}

#pragma mark - get

- (long)getRecentShopInfoCount
{
    return arrInfo.count;
}

- (ShopLocation *)getSimpleShopInfoByIndex:(long)index
{
    ShopLocation* ret;
    if (index >= 0 && index < arrInfo.count) {
        ret = arrInfo[index];
    }
    return ret;
}

- (ShopLocation *)getShopLocationByMerchantId:(long)merchantId
{
    ShopLocation* ret;
    for (ShopLocation* location in arrInfo) {
        if (location.merchant_id.integerValue == merchantId) {
            ret = location;
        }
    }
    return ret;
}

- (NSString *)getCurrentAreaName
{
    NSString* ret = @"";
    if (arrInfo.count > 0) {
        ShopLocation* info = arrInfo[0];
        ret = info.name;
    }
    return ret;
}
#pragma mark - update



#pragma mark - message

@end
