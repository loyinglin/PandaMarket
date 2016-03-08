//
//  ShopModel.m
//  Supermark
//
//  Created by 林伟池 on 15/8/3.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "ShopModel.h"
#import "ShopMessage.h"

@implementation ShopModel
{
    Merchant* myMerchant;
    Sys_info* mySysInfo;
    
    NSNumber* myMerchantId; // 商店ID
    NSNumber* myAreaId; //小区ID
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
    
    [self loadCache];
    
    if (!myMerchantId) {
        myMerchantId = [NSNumber numberWithLong:-1];
        myAreaId = [NSNumber numberWithLong:-1];
    }
    
    return self;
}

- (void)loadCache
{
    myMerchantId = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@%@",[[self class] description], @"merchantId"]];
    
    myAreaId = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@%@",[[self class] description], @"areaId"]];
}

- (void)clearCache
{
    myMerchantId = [NSNumber numberWithLong:-1];
    myAreaId = [NSNumber numberWithLong:-1];
    myMerchant = nil;
    mySysInfo = nil;
    [self saveCache];
}

- (void)saveCache
{
    [[NSUserDefaults standardUserDefaults] setObject:myMerchantId
                                              forKey:[NSString stringWithFormat:@"%@%@",[[self class] description], @"merchantId"]];
    [[NSUserDefaults standardUserDefaults] setObject:myAreaId
                                              forKey:[NSString stringWithFormat:@"%@%@",[[self class] description], @"areaId"]];
}
#pragma mark - set

-(void)setDefaultIdAndRquest:(long)merchantId Area:(long)areaId Update:(BOOL)update
{
    if(YES){ //不等于0的时候，代表不是第一次打开app;第一次打开app时候，不需要请求，在viewDidload会请求一次。但是清除缓存
//        LYLog(@"abc %ld", merchantId);
        [[ShopMessage instance] requestGetMerchantInfo:merchantId];
        [[ShopMessage instance] requestGetCommunityServerById:areaId];
    }
    myMerchantId = [NSNumber numberWithLong:merchantId];
    myAreaId = [NSNumber numberWithLong:areaId];
    
    [self saveCache];
}

-(void)setSysInfo:(Sys_info*)sys
{
    mySysInfo = sys;
}

-(void)setMerchantInfo:(Merchant*)merchant_info
{
    merchant_info.category = [merchant_info.category sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        IndexCategory* item1 = obj1;
        IndexCategory* item2 = obj2;
        
        return item1.id.integerValue - item2.id.integerValue;
    }];
    myMerchant = merchant_info;
}

#pragma mark - get


-(NSArray *)getSubCategorysByID:(long)categoryID
{
    NSArray* ret;
    for (IndexCategory* category in myMerchant.category) {
        if (category.id.integerValue == categoryID) {
            ret = category.sub_category;
            break;
        }
    }
    return ret;
}

-(IndexCategory*)getIndexCategoryByID:(long)categoryID
{
    IndexCategory* ret;
    for (IndexCategory* category in myMerchant.category) {
        if (category.id.integerValue == categoryID) {
            ret = category;
            break;
        }
    }
    
    return ret;
}


-(IndexCategory*)getIndexCategoryByIndex:(long)index
{
    IndexCategory* ret;
    if (index < myMerchant.category.count && index >= 0) {
        ret = myMerchant.category[index];
    }
    return ret;
}

-(NSString*)getIndexCategoryNameByID:(long)categoryID
{
    IndexCategory* index = [self getIndexCategoryByID:categoryID];
    return index.name;
}

-(long)getCurrentMerchantId
{
    long ret = 0;
    if (myMerchant && myMerchant.base) {
        ret = myMerchant.base.merchant_id.integerValue;
    }
    return ret;
}

-(NSString*)getStringMerchantId
{
    NSString* ret = [NSString stringWithFormat:@"%ld", [self getCurrentMerchantId]];
    return ret;
}

-(float)getCurrentShippingPrice
{
    
    long ret = 0;
    if (myMerchant && myMerchant.base) {
        ret = myMerchant.base.free_shipping_price.floatValue;
    }
    return ret;
}

-(long)getCurrentCategoryCount
{
    long ret = 0;
    if (myMerchant && myMerchant.category) {
        ret = myMerchant.category.count;
    }
    return ret;
}

-(NSString*)getCurrentPrefix
{
    NSString* ret = @"";
    if (mySysInfo) {
        ret = mySysInfo.res_prefix;
    }
    return ret;
}


-(Base*)getCurrentMerchantBase
{
    Base* ret = myMerchant.base;
    return ret;
}


-(long)getGoodsCountByIndex:(long)index
{
    long ret = 0;
    IndexCategory* category = [self getIndexCategoryByIndex:index];
    if (category) {
        ret = category.goods.count;
    }
    return ret;
}

-(BOOL)getNeedLocation
{
    BOOL ret;
    if (myMerchantId.integerValue == -1) {
        ret = YES;
    }
    else{
        ret = NO;
    }
    return ret;
}

-(BOOL)getAlertAble
{
    return  YES;
    static BOOL ret = YES;
    if (ret == YES) {
        ret = NO;
        return YES;
    }
    else{
        return ret;
    }
}

- (long)getAreaId
{
    return myAreaId.integerValue;
}
#pragma mark - update

-(void)updateMerchantInfo
{
    if (!myMerchant && myMerchantId.integerValue != -1) {
        [[ShopMessage instance] requestGetMerchantInfo:myMerchantId.integerValue];
    }
}


#pragma mark - message

@end
