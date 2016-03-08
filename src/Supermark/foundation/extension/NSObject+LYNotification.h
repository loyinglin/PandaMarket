//
//  NSObject+LYNotification.h
//  Supermark
//
//  Created by 林伟池 on 15/8/2.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AllEvent.h"


#pragma mark - address
//选择了address_id 的地址
#define NOTIFY_ADDRESS_SELECTED @"NOTIFY_ADDRESS_SELECTED"
//删除地址 返回
#define NOTIFY_ADDRESS_REMOVE_BACK @"NOTIFY_ADDRESS_REMOVE_BACK"
//保存地址 回复
#define NOTIFY_ADDRESS_SAVE_BACK @"NOTIFY_ADDRESS_SAVE_BACK"
//增加地址 
#define NOTIFY_ADDRESS_ADD_BACK @"NOTIFY_ADDRESS_ADD_BACK"
//增加收货地址
#define NOTIFY_OPEN_ADD_ADDRESS @"NOTIFY_OPEN_ADD_ADDRESS"


#pragma mark - shop
//商店信息
#define NOTIFY_INDEX_DATA @"NOTIFY_INDEX_DATA"
//子类页信息
#define NOTIFY_LIST_DATA @"NOTIFY_LIST_DATA"

#pragma mark - goods
#define NOTIFY_GET_GOOODS_LIST @"NOTIFY_GET_GOOODS_LIST"


#pragma mark - login
//登出
#define NOTIFY_USER_LOGOUT @"NOTIFY_USER_LOGOUT"
//被踢
#define NOTIFY_USER_KICKOUT @"NOTIFY_USER_KICKOUT"

//登陆成功
#define NOTIFY_LOGIN_SUCCESS @"NOTIFY_LOGIN_SUCCESS"
//登陆失败
#define NOTIFY_LOGIN_FAIL @"NOTIFY_LOGIN_FAIL"


#pragma mark - data change
//改动数据
#define NOTIFY_CART_DATA_CHANGE @"NOTIFY_CART_DATA_CHANGE"
#define NOTIFY_ADDRESS_DATA_CHANGE @"NOTIFY_ADDRESS_DATA_CHANGE"
#define NOTIFY_USER_DATA_CHANGE @"NOTIFY_USER_DATA_CHANGE"
#define NOTIFY_ORDER_DATA_CHANGE @"NOTIFY_ORDER_DATA_CHANGE"
#define NOTIFY_GOODS_DATA_CHANGE @"NOTIFY_GOODS_DATA_CHANGE"

#pragma mark - ui notify


//打开子类页
#define NOTIFY_UI_OPEN_PRODUCT_LIST @"NOTIFY_UI_OPEN_PRODUCT_LIST"
//打开确认订单
#define NOTIFY_UI_OPEN_CONFIRM_ORDER @"NOTIFY_UI_OPEN_CONFIRM_ORDER"
//打开收货地址管理
#define NOTIFY_UI_OPEN_MANAGE_ADDRESS @"NOTIFY_UI_OPEN_MANAGE_ADDRESS"
//打开结算
#define NOTIFY_UI_OPEN_SETTLEMENT_BOARD @"NOTIFY_UI_OPEN_SETTLEMENT_BOARD"






@interface NSObject (LYNotification)

- (void)lyObserveEvent:(BaseEvent*)event;
- (void)lyPostEvent:(BaseEvent*)event;

- (void)lyObserveNotification:(NSString*)name;
- (void)lyRemoveObserveNotification:(NSString*)name;
- (void)lyRemoveAllObserveNotification;

- (void)lyPostNotification:(NSString*)name;
- (void)lyPostNotificationWithSender:(NSString *)name withData:(NSDictionary *)data;

- (void)lyHandleNotification:(NSNotification*)notify;
- (void)lyHandleEvent:(BaseEvent*)event;

@end

