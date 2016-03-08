//
//  OrderMessage.m
//  Supermark
//
//  Created by 林伟池 on 15/8/19.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "OrderMessage.h"
#import "MessageUtil.h"

@implementation OrderMessage


-(void)requestGetUserOrderById:(long)orderId
{
    NSString* user_id = [[UserModel instance] getUserID];
    NSNumber* order_id = [NSNumber numberWithLong:orderId];
    
    
    NSMutableDictionary* param = [[NSMutableDictionary alloc] init];
    [param setObject:user_id forKey:@"id"];
    [param setObject:order_id forKey:@"order_id"];
    
//    LYLog(@"%@ id reuqest", order_id);
    
    
    [self sendRequestWithPost:[msgHttpPrefix stringByAppendingFormat:@"%@", msgGetUserOrderById] Param:param success:^(id responseObject) {
        NSDictionary* dict = (NSDictionary*)responseObject;
        Order* order = [dict objectForClass:[Order class]];
//        LYLog(@"back %@ ", order.order_id);
        NSString* jsonStr = [dict objectForKey:@"goods_list"];
        order.goods_list = [MessageUtil convertStringToArray:jsonStr];

        [[OrderModel instance] addNewOrder:order];
    }];
}

-(void)requestPayUserOrder:(long)pay_type
{
    NSString* user_id = [[UserModel instance] getUserID];
    NSNumber* user_pay_type = [NSNumber numberWithLong:pay_type];
    NSNumber* order_id = [NSNumber numberWithLong:[SettlementModel instance].orderId];
    
    
    NSMutableDictionary* param = [[NSMutableDictionary alloc] init];
    [param setObject:user_id forKey:@"id"];
    [param setObject:user_pay_type forKey:@"pay_type"];
    [param setObject:order_id forKey:@"order_id"];
    [param setObject:@"ios" forKey:@"os"];
    
    [self sendRequestWithPost:[msgHttpPrefix stringByAppendingFormat:@"%@", msgPayUserOrder] Param:param success:^(id responseObject) {        
        ServerPayUserOrderEvent* event = [ServerPayUserOrderEvent instance];
        event.success = YES;
        event.myPayType = pay_type;
        if (pay_type == PAY_TYPE_WEIXIN) {
            NSDictionary* dict = responseObject;
            [SettlementModel instance].myPrepayId = [dict objectForKey:@"prepay_id"];
        }
        if (PAY_TYPE_ALIPAY == pay_type) {
            NSDictionary* dict = responseObject;
            [SettlementModel instance].myPayString = [dict objectForKey:@"pay_string"];
        }
        [self lyPostEvent:event];
    }];
    

}

-(void)requestAddUserOrder
{
    NSNumber* merchant_id = [NSNumber numberWithLong:[[ShopModel instance] getCurrentMerchantId]];
    NSString* user_id = [[UserModel instance] getUserID];
    NSNumber* shipping_type = [[SettlementModel instance] getShipping_type];
    NSString* str_goods_list = [MessageUtil convertArrayToString:[[CartModel instance] getCartGoodsList]];
    NSString* address = [[AddressModel instance] getDefaultAddress].address;
    NSString* phone = [[AddressModel instance] getDefaultAddress].phone;
    NSString* msg = [[SettlementModel instance] getMessage];
    NSString* merchant_phone = [[ShopModel instance] getCurrentMerchantBase].phone;
    NSString* shop_name = [[ShopModel instance] getCurrentMerchantBase].shop_name;
    NSString* community_name = [[RecentShopModel instance] getShopLocationByMerchantId:[[ShopModel instance] getCurrentMerchantId]].name;
    
    NSMutableDictionary* param = [[NSMutableDictionary alloc] init];
    [param setObject:user_id forKey:@"id"];
    [param setObject:merchant_id forKey:@"merchant_id"];
    [param setObject:shipping_type forKey:@"shipping_type"];
    [param setObject:str_goods_list forKey:@"goods_list"];
    [param setObject:address forKey:@"address"];
    [param setObject:phone forKey:@"phone"];
    [param setObject:msg forKey:@"msg"];
    [param setObject:merchant_phone forKey:@"merchant_phone"];
    [param setObject:shop_name forKey:@"shop_name"];
    [param setObject:community_name forKey:@"community_name"];

    
    [self sendRequestWithPost:[msgHttpPrefix stringByAppendingFormat:@"%@", msgAddUserOrder] Param:param success:^(id responseObject) {
        NSString* orderStr = (NSString*)responseObject;
        long orderId = orderStr.integerValue;
        
        ServerAddUserOrderEvent* event = [ServerAddUserOrderEvent instance];
        event.orderId = orderId;
        event.success = YES;
        [self lyPostEvent:event];
    }];
    
}

-(void)requestGetUserOrderList:(long)page
{
    LYLog(@"get page %ld", page);
    NSString* user_id = [[UserModel instance] getUserID];
    NSNumber* user_page = [NSNumber numberWithLong:page];
    
    
    NSMutableDictionary* param = [[NSMutableDictionary alloc] init];
    [param setObject:user_id forKey:@"id"];
    [param setObject:user_page forKey:@"page"];
    
    
    [self sendRequestWithPost:[msgHttpPrefix stringByAppendingFormat:@"%@", msgGetUserOrderList] Param:param success:^(id responseObject) {
        NSArray* arr = (NSArray*)responseObject;
        NSMutableArray* orders = [[NSMutableArray alloc] init];
        for (NSDictionary* dict in arr) {
            Order* order = [dict objectForClass:[Order class]];
            NSString* jsonStr = [dict objectForKey:@"goods_list"];
            order.goods_list = [MessageUtil convertStringToArray:jsonStr];
            [orders addObject:order];
        }
        [[OrderModel instance] setOrderData:orders];
    }];
    
}

-(void)requestAddComplaint:(long)orderId Type:(NSString *)type Msg:(NSString *)msg
{
    
    NSString* user_id = [[UserModel instance] getUserID];
    
    
    NSMutableDictionary* param = [[NSMutableDictionary alloc] init];
    [param setObject:user_id forKey:@"id"];
    [param setObject:[NSNumber numberWithLong:orderId] forKey:@"order_id"];
    [param setObject:type forKey:@"type"];
    [param setObject:msg forKey:@"msg"];
    
    
    [self sendRequestWithPost:[msgHttpPrefix stringByAppendingFormat:@"%@", msgAddComplaint] Param:param success:^(id responseObject) {
        ServerAddComplaintEvent* event = [ServerAddComplaintEvent instance];
        [self lyPostEvent:event];
    }];
}

-(void)requestCancelUserOrder:(long)orderId
{
    NSString* user_id = [[UserModel instance] getUserID];
    NSNumber* order_id = [NSNumber numberWithLong:orderId];
    
    NSMutableDictionary* param = [[NSMutableDictionary alloc] init];
    [param setObject:user_id forKey:@"id"];
    [param setObject:order_id forKey:@"order_id"];

    
    [self sendRequestWithPost:[msgHttpPrefix stringByAppendingFormat:@"%@", msgCancelUserOrder] Param:param success:^(id responseObject) {
        [self lyPostEvent:[ServerCancelUserOrderEvent instance]];
    }];

    
}
@end
