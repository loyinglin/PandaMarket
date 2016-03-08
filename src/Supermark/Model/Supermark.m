//
//  Supermark.m
//  Supermark
//
//  Created by 林伟池 on 15/8/3.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "Supermark.h"
#import "NSDictionary+LYDictToObject.h"
#import "ModelConst.h"
#import <objc/runtime.h>

@implementation LYCoding

- (id)copyWithZone:(NSZone *)zone
{
    id ret = [[[self class] allocWithZone:zone] init];
    
    unsigned int		propertyCount = 0;
    objc_property_t *	properties = class_copyPropertyList( [self class], &propertyCount );
    
    for ( NSUInteger i = 0; i < propertyCount; i++ )
    {
        const char *	name = property_getName(properties[i]);
        NSString *		propertyName = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        
        NSObject<NSCopying> *	tempValue = [self valueForKey:propertyName];
        if (tempValue) {
            id value = [tempValue copy];
            [ret setValue:value forKey:propertyName];
        }
    }
    
    free(properties);

    return ret;
}


- (void)encodeWithCoder:(NSCoder *)coder
{
    unsigned int		propertyCount = 0;
    objc_property_t *	properties = class_copyPropertyList( [self class], &propertyCount );
    
    for ( NSUInteger i = 0; i < propertyCount; i++ )
    {
        const char *	name = property_getName(properties[i]);
        NSString *		propertyName = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        
        NSObject *	tempValue = [self valueForKey:propertyName];
//        [tempValue conformsToProtocol:@protocol(NSCoding)];
        [coder encodeObject:tempValue forKey:propertyName];
    }
    
    free(properties);
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        unsigned int		propertyCount = 0;
        objc_property_t *	properties = class_copyPropertyList( [self class], &propertyCount );
        
        for ( NSUInteger i = 0; i < propertyCount; i++ )
        {
            const char *	name = property_getName(properties[i]);
            NSString *		propertyName = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
            
            [self setValue:[aDecoder decodeObjectForKey:propertyName] forKey:propertyName];
        }
        free(properties);
    }
    
    return self;
}

@end


@implementation ShopLocation

+(instancetype)instanceWith:(ShopLocation *)item
{
    ShopLocation* ret = [[ShopLocation alloc] init];
    ret._id = [NSNumber numberWithLong:item._id.integerValue];
    ret.merchant_id = [NSNumber numberWithLong:item.merchant_id.integerValue];
    ret.address = [NSString stringWithFormat:@"%@", item.address];
    ret.name = [NSString stringWithFormat:@"%@", item.name];
    ret.dis = [NSNumber numberWithLong:item.dis.integerValue];
    
    return ret;
}

@end

@implementation SimpleService


@end

@implementation SimpleGoods
{
    //本地存储，收到那一刻生成
    long create_time;
}

-(instancetype)init
{
    self = [super init];
    
    create_time = time(NULL);
    
    return self;
}

-(BOOL)isValid
{
    long now = time(NULL);
    
    if (now - create_time >= VALID_TIME) {
        return NO;
    }    
    return YES;
}
//
//- (void)encodeWithCoder:(NSCoder *)coder
//{
//    unsigned int		propertyCount = 0;
//    objc_property_t *	properties = class_copyPropertyList( [self class], &propertyCount );
//    
//    for ( NSUInteger i = 0; i < propertyCount; i++ )
//    {
//        const char *	name = property_getName(properties[i]);
//        NSString *		propertyName = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
//        
//        NSObject *	tempValue = [self valueForKey:propertyName];
//        [coder encodeObject:tempValue forKey:propertyName];
//    }
//    free(properties);
//}
//
//- (instancetype)initWithCoder:(NSCoder *)aDecoder
//{
//    if (self = [super init]) {
//        unsigned int		propertyCount = 0;
//        objc_property_t *	properties = class_copyPropertyList( [self class], &propertyCount );
//        
//        for ( NSUInteger i = 0; i < propertyCount; i++ )
//        {
//            const char *	name = property_getName(properties[i]);
//            NSString *		propertyName = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
//            
//            [self setValue:[aDecoder decodeObjectForKey:propertyName] forKey:propertyName];
//        }
//        
//        free(properties);
//    }
//    
//    return self;
//}


@end

@implementation Order

-(float)getTotalMoney
{
    float ret = 0;
    
    for (NSArray* arr in self.goods_list) {
        if (arr && arr.count == 3) { //id price count
//            NSNumber* goods_id = arr[0];
            NSNumber* price = arr[1];
            NSNumber* count = arr[2];
            if (price && count) {
                ret += price.floatValue * count.integerValue;
            }
        }
    }
    
    return ret;
}

-(NSArray *)getGoodsId
{
    NSMutableArray* ret = [[NSMutableArray alloc] init];
    
    for (NSArray* arr in self.goods_list) {
        if (arr && arr.count == 3) { //id price count
            NSNumber* goods_id = arr[0];
            [ret addObject:goods_id];
        }
    }
    return ret;
}

-(NSArray*)getParamsByIndex:(long)index
{
    NSArray* ret;
    
    if (index >= 0 && index < self.goods_list.count) {
        ret = self.goods_list[index];
    }
    
    return ret;
    
}
@end

@implementation User


@end

@implementation Address

@end

@implementation DEALER

@end

@implementation Sys_info

@end

@implementation Merchant
CONVERT_PROPERTY_CLASS(base, Base)
//CONVERT_PROPERTY_CLASS(category, IndexCategory) 手动解析
@end

@implementation Base


@end

//@implementation Goods
//
//
//@end

@implementation SubCategory


@end

@implementation IndexCategory

CONVERT_PROPERTY_CLASS(goods, DetailGoods)
CONVERT_PROPERTY_CLASS(sub_category, SubCategory)

@end


@implementation DetailGoods


@end


@implementation ListData
CONVERT_PROPERTY_CLASS(data, DetailGoods)

@end

@implementation CartGoods
+(instancetype)initWithDetailGoods:(DetailGoods*)goods
{
    CartGoods* ret = [[CartGoods alloc] init];
    
    ret.name = goods.name;
    ret.goods_id = goods.goods_id;
    ret.price = goods.price;
    ret.img = goods.img;
    ret.count = 0;
    
    return ret;
}


@end