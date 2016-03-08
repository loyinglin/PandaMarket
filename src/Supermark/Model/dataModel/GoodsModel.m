//
//  GoodsModel.m
//  Supermark
//
//  Created by 林伟池 on 15/8/21.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "GoodsModel.h"
#import "NSObject+Ticker.h"
#import "GoodsMessage.h"

@implementation GoodsModel
{
    NSMutableDictionary* dict;
    
    NSMutableArray* invalidArr; //等待更新的id
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
    
    dict = [[NSMutableDictionary alloc] init];
    
    invalidArr = [[NSMutableArray alloc] init];
    
    [self loadCache];
    
    return self;
}


- (void)loadCache
{
    NSData* data = [[NSUserDefaults standardUserDefaults] objectForKey:[[self class] description]];
    if (data) {
         dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    
}

- (void)saveCache
{
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:dict];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:[[self class] description]];
    
    [self lyPostNotification:NOTIFY_GOODS_DATA_CHANGE];
}


-(void)addSimpleGoods:(SimpleGoods *)simple_goods
{
    NSString* key = [NSString stringWithFormat:@"%ld", simple_goods.goods_id.integerValue];
    [dict setObject:simple_goods forKey:key];
    [self saveCache];
}

-(void)addDictGoods:(NSDictionary *)dict_goods
{
    NSArray* keys = [dict_goods allKeys];
    for (int i = 0; i < keys.count; ++i) {
        NSString* key = keys[i];
        NSDictionary* data = [dict_goods objectForKey:key];
        SimpleGoods* simple_goods = (SimpleGoods*)[data objectForClass:[SimpleGoods class]];
        if (key && simple_goods) {
            [dict setObject:simple_goods forKey:key];
        }
    }
    [self saveCache];
}

-(SimpleGoods *)getSimpleGoodsById:(long)goods_id
{
    SimpleGoods* ret;
    NSString* key = [NSString stringWithFormat:@"%ld", goods_id];
    ret = [dict objectForKey:key];
    if (!ret || ![ret isValid]) {
        [self updateGoods:goods_id];
    }
    return ret;
}

-(void)updateGoods:(long)goods_id
{
    NSNumber* goodsId = [NSNumber numberWithLong:goods_id];
    if (![invalidArr containsObject:goodsId]) {
        [invalidArr addObject:goodsId];
        [self lyObserveTick];
    }
}



#pragma mark - ticker
-(void)lyHandleTick:(NSTimeInterval)elapsed
{
    [self lyUnobserveTick];
    [[GoodsMessage backgroundInstance] requestGetGoodsListByIds:[NSArray arrayWithArray:invalidArr]];
    [invalidArr removeAllObjects];
}
@end
