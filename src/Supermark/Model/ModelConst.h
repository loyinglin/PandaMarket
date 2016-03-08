//
//  Modelextern const.h
//  Supermark
//
//  Created by 林伟池 on 15/8/18.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelConst : NSObject

#define LOG_ABLE    YES

#define VALID_TIME (24 * 3600)

enum
{
    PAY_TYPE_CASH = 0,
    PAY_TYPE_WEIXIN,
    PAY_TYPE_ALIPAY
};


#pragma mark - error code
extern const long msg_success;
extern const long msg_session_expire;
extern const long msg_verify_code_error;
extern const long msg_server_error;

#pragma mark - msg
extern const NSString* msgHttpPrefix;

#pragma mark -
extern const NSString* msgMerchantInfo;


#pragma mark -
extern const NSString* msgGetSubCategoryGoods;
extern const NSString* msgGetMerchantGoodsPriceByGoodsIds;


#pragma mark -
extern const NSString* msgGetGoodsListByIds;

#pragma mark - 
extern const NSString* msgGetCommunityServerById;

#pragma mark -
extern const NSString* msgSendVerify;
extern const NSString* msgUserLogin;

#pragma mark -
extern const NSString* msgGetUserAddress;
extern const NSString* msgAddUserAddress;
extern const NSString* msgSaveUserAddress;
extern const NSString* msgDelUserAddress;
extern const NSString* msgCancelUserOrder;

#pragma mark -
extern const NSString* msgAddUserOrder;
extern const NSString* msgPayUserOrder;
extern const NSString* msgGetUserOrderList;
extern const NSString* msgGetUserOrderById;


#pragma mark - 
extern const NSString* msgAddComplaint;

#pragma mark - 
extern const NSString* msgGetNearMerchant;

#pragma mark - 
extern const NSString* msgAddFeedback;


@end
