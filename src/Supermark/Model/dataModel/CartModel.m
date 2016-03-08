//
//  CartModel.m
//  Supermark
//
//  Created by 林伟池 on 15/8/3.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "CartModel.h"
#import "CartMessage.h"

@implementation CartModel
{
    NSMutableDictionary* totalGoods; //购物车 所有商品 索引是商店ID
    NSMutableArray* goods; //本商店 所有商品
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


-(instancetype)init
{
    self = [super init];
    
    totalGoods = [[NSMutableDictionary alloc] init];
    [self loadCache];
    
    return self;
}

- (void)loadCache
{
    NSDictionary* saveDict = [[NSUserDefaults standardUserDefaults] objectForKey:[[self class] description]];
    NSArray* keys;
    keys = [saveDict allKeys];
    for (int i = 0; i < keys.count; ++i) {
        NSString* merchantId = keys[i];
        NSArray* archiveArray = [saveDict objectForKey:merchantId];
        NSMutableArray* arr = [[NSMutableArray alloc] init];
        for (NSData* data in archiveArray) {
            CartGoods* item = (CartGoods*)[NSKeyedUnarchiver unarchiveObjectWithData:data];
            [arr addObject:item];
        }
        [totalGoods setObject:arr forKey:merchantId];
    }
}

- (void)saveCache
{
    NSString* shopKey = [[ShopModel instance] getStringMerchantId];
    [totalGoods setObject:goods forKey:shopKey];
    
    NSArray* keys;
    keys = [totalGoods allKeys];
    NSMutableDictionary* saveDict = [[NSMutableDictionary alloc] init];
    for (int i = 0; i < keys.count; ++i) {
        NSString* merchantId = keys[i];
        NSArray* arrGoods = [totalGoods objectForKey:merchantId];
        NSMutableArray *archiveArray = [NSMutableArray arrayWithCapacity:arrGoods.count];
        for (CartGoods *item in arrGoods) {
            NSData *personEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:item];
            [archiveArray addObject:personEncodedObject];
        }
        [saveDict setObject:archiveArray forKey:merchantId];
    }
    
    NSString* className = [[self class] description];
    

    
    [[NSUserDefaults standardUserDefaults] setObject:saveDict forKey:className];
}

- (void)clearCache
{
    [totalGoods removeAllObjects];
    [goods removeAllObjects];
    [self saveCache];
    [self lyPostNotification:NOTIFY_CART_DATA_CHANGE];
}

- (void)dealloc
{
    [self saveCache];
}

-(void)ChangeCartGoods:(long)goodsId IsAdd:(BOOL)add
{
    CartGoods* item = [self getCartGoodsById:goodsId];
    if (item) {
        long count = item.count.integerValue;
        if (add) {
            ++count;
        }
        else{
            --count;
            if (count < 0) {
                count = 0;
//                [goods removeObject:item]; 不移除
            }
        }
        item.count = [NSNumber numberWithLong:count];
        
        [self lyPostNotification:NOTIFY_CART_DATA_CHANGE];
    }
    [self saveCache];
}

-(void)addWithGoods:(DetailGoods *)detail_goods
{
    CartGoods* item = [self getCartGoodsById:detail_goods.goods_id.integerValue];
    if (!item) {
        item = [CartGoods initWithDetailGoods:detail_goods];
        [goods addObject:item];
    }
    long count = item.count.integerValue;
    ++count;
    item.count = [NSNumber numberWithLong:count];
    [self saveCache];
    
    [self lyPostNotification:NOTIFY_CART_DATA_CHANGE];
}

-(void)removeWithGoods:(DetailGoods *)detail_goods
{
    CartGoods* item = [self getCartGoodsById:detail_goods.goods_id.integerValue];
    if (item) {
        long count = item.count.integerValue;
        --count;
        if (count <= 0) {
            [goods removeObject:item];
        }
        else{
            item.count = [NSNumber numberWithLong:count];
        }
        
        [self lyPostNotification:NOTIFY_CART_DATA_CHANGE];
    }
    
    [self saveCache];
}

-(long)getCartCount
{
    return goods.count;
}


-(long)getGoodsCount
{
    long ret = 0;
    for (CartGoods* item in goods) {
        ret += item.count.integerValue;
    }
    return ret;
}


-(CartGoods*)getCartGoodsById:(long)goodsId
{
    CartGoods* ret;
    for (CartGoods* item in goods) {
        if (item.goods_id && (item.goods_id.integerValue ==goodsId)) {
            ret = item;
            break;
        }
    }
    return ret;
}

- (CartGoods*)getCartGoodsByIndex:(long)index
{
    CartGoods* ret;
    if (index < goods.count) {
        ret = [goods objectAtIndex:index];
    }
    return ret;
}

- (void)clearEmptyGoods
{
    NSMutableArray* otherArr = [NSMutableArray arrayWithArray:goods];
    for (CartGoods* item in goods) {
        if (item.count.integerValue <= 0) {
            [otherArr removeObject:item];
        }
    }
    goods = otherArr;
    [self saveCache];
    [self lyPostNotification:NOTIFY_CART_DATA_CHANGE];
}

-(float)getTotalCostInCart
{
    float ret = 0;
    for (CartGoods* item in goods) {
        if (item) {
            ret += item.count.integerValue * item.price.floatValue;
        }
    }
    return ret;
}


- (void)clearCartGoods
{
    [goods removeAllObjects];
    
    [self lyPostNotification:NOTIFY_CART_DATA_CHANGE];
    [self saveCache];
}


- (void)onShopChange
{
    NSString* shopKey = [[ShopModel instance] getStringMerchantId];
    goods = [NSMutableArray arrayWithArray:[totalGoods objectForKey:shopKey]];
    
    [[CartMessage instance] requestUpdateCartGoods];
    [self lyPostNotification:NOTIFY_CART_DATA_CHANGE];
}


- (NSArray*)getCartGoodsId
{
    NSMutableArray* ret = [[NSMutableArray alloc] init];
    
    for (CartGoods* item in goods) {
        if (item.count >= 0) {
            NSNumber* goodsId = [NSNumber numberWithLong: item.goods_id.integerValue];
            [ret addObject: goodsId];
        }
    }
    
    return ret;
}

-(NSArray *)getCartGoodsList
{
    NSMutableArray* ret = [[NSMutableArray alloc] init];
    
    for (CartGoods* item in goods) {
        if (item.count >= 0) {
            NSNumber* goodsId = [NSNumber numberWithLong: item.goods_id.integerValue];
            NSNumber* goodsPrice = [NSNumber numberWithFloat: item.price.floatValue];
            NSNumber* goodsCount = [NSNumber numberWithLong: item.count.integerValue];
            [ret addObject:[NSArray arrayWithObjects:goodsId, goodsPrice, goodsCount, nil]];
        }
    }
    return ret;
}

-(void)updateCArtGoodsWith:(NSArray *)arr
{
    NSMutableArray* newGoods = [[NSMutableArray alloc] init];
    for (NSArray* id_price in arr) {
        if (id_price.count >= 2) {
            NSNumber* goods_id = id_price[0];
            NSNumber* price = id_price[1];
            for (CartGoods* item in goods) {
                if (item.goods_id.integerValue == goods_id.integerValue) {
                    item.price = [NSNumber numberWithFloat:price.floatValue];
                    [newGoods addObject:item];
                    break;
                }
            }
        }
    }
    goods = newGoods;
    [self saveCache];

    [self lyPostNotification:NOTIFY_CART_DATA_CHANGE];
}

@end
