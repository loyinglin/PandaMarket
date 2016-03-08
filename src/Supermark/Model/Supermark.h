//
//  Supermark.h
//  Supermark
//
//  Created by 林伟池 on 15/8/3.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - enums

enum ATTR_TYPE
{
    ATTR_TYPE_UNIQUE = 0,
    ATTR_TYPE_SINGLE = 1,
    ATTR_TYPE_MULTI = 2,
};

enum ERROR_CODE
{
    ERROR_CODE_OK = 0,
};

enum GOOD_TYPE
{
    GOOD_TYPE_NORMAL = 0,
    GOOD_TYPE_GROUP = 1,
    GOOD_TYPE_AUCTION = 2,
    GOOD_TYPE_RAIDERS = 3,
};

enum RANK_LEVEL
{
    RANK_LEVEL_NORMAL = 0,
    RANK_LEVEL_VIP = 1,
};

#define ORDER_LIST_FINISHED	@"finished"
#define ORDER_LIST_SHIPPED	@"shipped"
#define ORDER_LIST_AWAIT_PAY	@"await_pay"
#define ORDER_LIST_AWAIT_SHIP	@"await_ship"

#define SEARCH_ORDER_BY_CHEAPEST	@"price_asc"
#define SEARCH_ORDER_BY_HOT	@"is_hot"
#define SEARCH_ORDER_BY_EXPENSIVE	@"price_desc"

#define BANNER_ACTION_GOODS	@"goods"
#define BANNER_ACTION_CATEGORY @"category"
#define BANNER_ACTION_BRAND	@"brand"

#pragma mark - models



/**************************SUPERMARK***************************/
/// 支持序列化，还有深度复制。注意调用 的是copy 不是mutableCopy，对于可变对象，不可以用此基类
/// 类似nsmutableString NSMutableArray等，不应该是成员对象，否则copy出来的是不可变对象。
@interface LYCoding : NSObject <NSCoding, NSCopying>

@end



@class DetailGoods;
@interface CartGoods : LYCoding
@property(nonatomic, copy) NSNumber* goods_id;
@property(nonatomic, copy) NSString* name;
@property(nonatomic, copy) NSNumber* price;
@property(nonatomic, copy) NSNumber* count;
@property(nonatomic, copy) NSString* img;

+(instancetype)initWithDetailGoods:(DetailGoods*)goods;
@end

@interface DEALER : NSObject
@property(nonatomic) NSString* address;
@property(nonatomic) NSString* shop_name;
@property(nonatomic) NSString* business_start;
@property(nonatomic) NSString* shipping_desc;
@property(nonatomic) NSString* business_end;
@property(nonatomic) NSString* range_km;
@property(nonatomic) NSNumber* base_price;
@end


@interface Base : NSObject
@property(nonatomic) NSString* address;
@property(nonatomic) NSNumber* free_shipping_price;
@property(nonatomic) NSNumber* latitude;
@property(nonatomic) NSNumber* longitude;
@property(nonatomic) NSNumber* merchant_id;
@property(nonatomic) NSString* merchant_name;
@property(nonatomic) NSString* phone;
@property(nonatomic) NSString* range_desc;
@property(nonatomic) NSString* shipping_range;
@property(nonatomic) NSString* shop_name;
@property(nonatomic) NSString* working_begin;
@property(nonatomic) NSString* working_end;
@end

//@interface Goods : NSObject
//@property(nonatomic) NSNumber* category_id;
//@property(nonatomic) NSNumber* goods_id;
//@property(nonatomic) NSString* img;
//@property(nonatomic) NSString* name;
//@property(nonatomic) NSNumber* sub_category_id;
//@end

@interface SubCategory : NSObject
@property(nonatomic) NSNumber* category_id;
@property(nonatomic) NSString* name;
@property(nonatomic) NSNumber* sub_category_id;
@end

@interface IndexCategory : NSObject     //首页 展示用 分类
@property(nonatomic) NSArray* goods;    // arr of goods max is 6
@property(nonatomic) NSArray* sub_category;
@property(nonatomic) NSNumber* id;
@property(nonatomic) NSString* img;
@property(nonatomic) NSString* name;
@end

@interface DetailGoods : NSObject
@property(nonatomic) NSNumber* category_id;
@property(nonatomic) NSNumber* goods_id;
@property(nonatomic) NSString* img;
@property(nonatomic) NSString* name;
@property(nonatomic) NSNumber* sub_category_id;
//@property(nonatomic) NSNumber* id; //use for show
@property(nonatomic) NSNumber* price;
@property(nonatomic) NSNumber* month_sell;
@end

@interface ListData : NSObject
@property(nonatomic) NSArray* data;
@end

@interface Merchant : NSObject
@property(nonatomic) Base* base;
@property(nonatomic) NSArray* category;
@end

@interface Sys_info : NSObject
@property(nonatomic) NSString* res_prefix;
@end

@interface Address : LYCoding
@property (nonatomic, copy) NSString* phone;
@property (nonatomic, copy) NSString* address;
@property (nonatomic, copy) NSNumber* user_address_id;
@property (nonatomic, copy) NSNumber* modify_time;
@end

@interface User : LYCoding
@property (nonatomic , strong) NSString* user_id;
@property (nonatomic , strong) NSString* phone;
@property (nonatomic , strong) NSString* create_time;
@end

@interface Order : NSObject
@property (nonatomic , strong) NSNumber* order_id;
@property (nonatomic , strong) NSNumber* user_id;
@property (nonatomic , strong) NSNumber* merchant_id;
@property (nonatomic , strong) NSNumber* pay_id;
@property (nonatomic , strong) NSNumber* pay_time;
@property (nonatomic , strong) NSNumber* status;
@property (nonatomic , strong) NSNumber* pay_type;
@property (nonatomic , strong) NSNumber* shipping_type;
@property (nonatomic , strong) NSArray* goods_list;
@property (nonatomic , strong) NSString* address;
@property (nonatomic , strong) NSString* phone;
@property (nonatomic , strong) NSString* msg;
@property (nonatomic , strong) NSNumber* create_time;
@property (nonatomic , strong) NSString* merchant_phone;
@property (nonatomic , strong) NSString* shop_name;
@property (nonatomic , strong) NSNumber* rsp_time;
@property (nonatomic , strong) NSNumber* complete_time;
@property (nonatomic , strong) NSString* reason;
@property (nonatomic , strong) NSString* community_name;
-(float)getTotalMoney;

-(NSArray*)getGoodsId;

-(NSArray*)getParamsByIndex:(long)index;

@end

@interface SimpleGoods : LYCoding

@property(nonatomic) NSNumber* goods_id;
@property(nonatomic) NSString* img;
@property(nonatomic) NSString* name;

-(BOOL)isValid;

@end



@interface SimpleService : NSObject

@property(nonatomic) NSNumber* server_id;
@property(nonatomic) NSNumber* community_id;
@property(nonatomic) NSNumber* weight;
@property(nonatomic) NSString* img;
@property(nonatomic) NSString* name;
@property(nonatomic) NSString* user_name;
@property(nonatomic) NSString* server_desc;
@property(nonatomic) NSString* address;
@property(nonatomic) NSString* phone;

@end


@interface ShopLocation : LYCoding
@property(nonatomic) NSNumber* _id;
@property(nonatomic) NSNumber* merchant_id;
@property(nonatomic) NSString* name;
@property(nonatomic) NSNumber* dis;
@property(nonatomic) NSString* address;

@property(nonatomic) NSMutableString* test;
@property(nonatomic) NSMutableArray* arr;

+(instancetype)instanceWith:(ShopLocation*)item;

@end




#pragma mark - API

@interface API : NSObject

@end
