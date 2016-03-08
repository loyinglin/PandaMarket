//
//  OrderModel.h
//  Supermark
//
//  Created by 林伟池 on 15/8/20.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "BaseModel.h"

@interface OrderModel : BaseModel

+(instancetype)instance;

-(void)clearCache;

-(void)setOrderData:(NSArray*)arr;

-(void)addNewOrder:(Order*)order;

-(Order*)getOrderByIndex:(long)index;

-(Order*)getOrderById:(long)order_id;

-(long)getOrderIdByIndex:(long)index;

-(long)getOrderCount;

-(void)requestGetNewOrder; //重新加载，下拉刷新

-(void)requestGetMoreOrder; //获取更多订单，上拉加载

-(void)updateModel;


#pragma mark - init


#pragma mark - set



#pragma mark - get
- (NSArray*)getOrderArr;



#pragma mark - update



#pragma mark - message


@end
