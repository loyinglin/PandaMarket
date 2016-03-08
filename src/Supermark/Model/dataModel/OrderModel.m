//
//  OrderModel.m
//  Supermark
//
//  Created by 林伟池 on 15/8/20.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "OrderModel.h"
#import "OrderMessage.h"
#import "UIConstant.h"
#import "NSObject+LYUITipsView.h"

@implementation OrderModel
{
    NSMutableArray* orders;
    long currentPage; //服务器用的页数
    long getCount;    //客户端用的，每页个数
}
#define ORDER_COUNT_PER_PAGE 6

#pragma mark - init
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
    
    [self clearCache];
    
    return self;
}

-(void)clearCache
{
    currentPage = 0;
    orders = [[NSMutableArray alloc] init];
}


#pragma mark - set
-(void)addNewOrder:(Order *)order
{
    Order* old;

    for (Order* item in orders) {
        if (item.order_id.integerValue == order.order_id.integerValue) {
            old = item;
        }
    }
    if (old) {
        [orders removeObject:old];
    }
    [orders addObject:order];
    [self lyPostNotification:NOTIFY_ORDER_DATA_CHANGE];
}

-(void)setOrderData:(NSArray*)arr
{
    if (currentPage == 0) { //第一次加载
        orders = [NSMutableArray array];
    }
    
    if (arr.count > 0) {
        for (Order* item  in arr) {
            if (item.status.integerValue == order_status_not_pay && ![self isFirstNotPay]) { //如果是第二个未付款的订单，跳过
                continue;
            }
            else if (item) {
                getCount++;
                [orders addObject:item];
            }
        }
        currentPage++;
        if (getCount < ORDER_COUNT_PER_PAGE) {
            [[OrderMessage backgroundInstance] requestGetUserOrderList:currentPage + 1];
        }
    }
    else{
        [self presentMessageTips:@"订单已全部加载"];
    }
    
    [self lyPostNotification:NOTIFY_ORDER_DATA_CHANGE];
}



#pragma mark - get


-(Order*)getOrderById:(long)order_id
{
    Order* ret;
    
    for (Order* item in orders) {
        if (item && item.order_id.integerValue == order_id) {
            ret = item;
        }
    }
    
    return ret;
}

-(Order *)getOrderByIndex:(long)index
{
    Order* ret;
    if (index >= 0 && index < orders.count) {
        ret = (Order*)orders[index];
    }
    
    return ret;
}

-(long)getOrderCount
{
    return orders.count;
}

-(long)getOrderIdByIndex:(long)index
{
    long ret = 0;
    if ([self getOrderByIndex:index]) {
         ret = [self getOrderByIndex:index].order_id.integerValue;
    }
    return ret;
}


- (BOOL)isFirstNotPay
{
    BOOL ret = YES;
    for (Order* item in orders) {
        if (item.status.integerValue == order_status_not_pay) {
            ret = NO;
            break;
        }
    }
    return ret;
}

- (NSArray *)getOrderArr
{
    NSArray* ret;
    
    ret = orders;
    
    return ret;    
}

#pragma mark - update
-(void)updateModel
{
    [self requestGetNewOrder];
}


#pragma mark - message

-(void)requestGetNewOrder
{
    currentPage = 0; //从1开始
    getCount = 0;
    [[OrderMessage instance] requestGetUserOrderList:1];
}


-(void)requestGetMoreOrder
{
    getCount = 0;
    [[OrderMessage instance] requestGetUserOrderList:currentPage + 1];
}

@end
