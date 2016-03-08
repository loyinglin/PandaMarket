//
//  UIConstant.m
//  Supermark
//
//  Created by 林伟池 on 15/7/29.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "UIConstant.h"
#import <Foundation/Foundation.h>


@implementation UIConstant

+(NSString *)getPayTypeDesc:(long)pay_type
{
    NSString* ret = @"";
    switch (pay_type) {
        case 0:
            ret = @"货到付款";
            break;
            
        case 1:
            
            ret = @"微信支付";
            break;
            
        case 2:
            ret = @"支付宝";
            break;
        default:
            break;
    }
    return ret;
}

+(NSString *)getOrderStatusDesc:(long)status
{
    NSString* ret = @"";
    switch (status) {
        case order_status_merchant_cancel:
            ret = @"商家取消";
            break;
            
        case -2:
            ret = @"用户取消";
            break;
            
        case -1:
            ret = @"商家拒单";
            break;
            
        case 0:
            ret = @"未付款";
            break;
            
        case 1:
            ret = @"等待商户响应";
            break;
            
        case 2:
            ret = @"配送中";
            break;
            
        case 3:
            ret = @"已收货";
            break;
            
        case 4:
            ret = @"已完成";
            break;
            
            
        default:
            break;
    }
    return ret;
    
}

+(NSString *)getShippingTypeDesc:(long)shipping_type
{
    
    NSString* ret = @"";
    switch (shipping_type) {
        case 0:
            ret = @"商家配送";
            break;
            
        case 1:
            
            ret = @"上门自提";
            break;
            

        default:
            break;
    }
    return ret;

}

@end



#pragma mark - CONST


float const CONST_SPLIT_INTERVAL = 5;

float const CONST_CATAGORY_NUM = 1;

float const CONST_MAX_CART_HEIGHT = 350;

float const CONST_SHOW_CART_HEIGHT = 130;

float const CONST_HIDE_CART_HEIGHT = 60;

float const CONST_TABBAR_HEIGHT = 64;

float const CONST_CART_ITEM_HEIGHT = 44;

NSString*  const OPEN_PRODUCTLIST_UI = @"open_productlist_ui";

float const CONST_ZERO = 0;

float const DEFAULT_VIEW_TAG = 10;





