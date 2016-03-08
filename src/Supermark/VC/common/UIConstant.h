//
//  Header.h
//  Supermark
//
//  Created by 林伟池 on 15/7/29.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#ifndef Supermark_UIConstant_h
#define Supermark_UIConstant_h

#import <Foundation/Foundation.h>

enum{
    order_status_merchant_cancel = -3,
    order_status_user_cancel,
    order_status_merchant_refuse,
    order_status_not_pay,
    order_status_waiting_response,
    order_status_shipping,
    order_status_receive_goods,
    order_status_complete
};

#define NUMBER_CUSTOMER_SERVICE @"15000011867"

@interface UIConstant: NSObject

extern float const CONST_SPLIT_INTERVAL;

extern float const CONST_CATAGORY_NUM;

extern float const CONST_SHOW_CART_HEIGHT;

extern float const CONST_ZERO;

extern float const CONST_MAX_CART_HEIGHT;

extern float const CONST_HIDE_CART_HEIGHT;

extern float const CONST_CART_ITEM_HEIGHT;

extern float const DEFAULT_VIEW_TAG;

extern float const CONST_TABBAR_HEIGHT;


+(NSString*)getPayTypeDesc:(long)pay_type;

+(NSString*)getOrderStatusDesc:(long)status;

+(NSString*)getShippingTypeDesc:(long)shipping_type;



@end


#endif
