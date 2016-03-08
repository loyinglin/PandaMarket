//
//  ModelConst.m
//  Supermark
//
//  Created by 林伟池 on 15/8/18.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "ModelConst.h"

@implementation ModelConst

#pragma mark - error code
const long msg_success = 200;
const long msg_session_expire = 4001;
const long msg_verify_code_error = 4009;
const long msg_server_error = 5000;

#pragma mark - msg
const NSString* msgHttpPrefix = @"http://api.mangix.cn/Home";
//const NSString* msgHttpPrefix = @"http://192.168.10.115/Home";



#pragma mark -
const NSString* msgMerchantInfo = @"/Merchant/info";


#pragma mark -
const NSString* msgGetSubCategoryGoods = @"/MerchantGoods/getSubCategoryGoods";
const NSString* msgGetMerchantGoodsPriceByGoodsIds = @"/MerchantGoods/getMerchantGoodsPriceByGoodsIds";


#pragma mark -
const NSString* msgGetGoodsListByIds = @"/Goods/getGoodsListByIds";

#pragma mark -
const NSString* msgGetCommunityServerById = @"/CommunityServer/getCommunityServerById";

#pragma mark -
const NSString* msgSendVerify = @"/User/sendVerify";
const NSString* msgUserLogin = @"/User/login";


#pragma mark -
const NSString* msgGetUserAddress = @"/User/getUserAddress";
const NSString* msgAddUserAddress = @"/User/addUserAddress";
const NSString* msgSaveUserAddress = @"/User/saveUserAddress";
const NSString* msgDelUserAddress = @"/User/delUserAddress";
const NSString* msgCancelUserOrder = @"/User/cancelUserOrder";


#pragma mark -
const NSString* msgAddUserOrder = @"/User/addUserOrder";
const NSString* msgPayUserOrder = @"/User/payUserOrder";
const NSString* msgGetUserOrderList = @"/User/getUserOrderList";
const NSString* msgGetUserOrderById = @"/User/getUserOrderById";

#pragma mark - 
const NSString* msgAddComplaint = @"/User/addComplaint";


#pragma mark -
const NSString* msgGetNearMerchant = @"/Location/getNearCommunity";


#pragma mark -
const NSString* msgAddFeedback = @"/Feedback/addFeedback/";

@end
