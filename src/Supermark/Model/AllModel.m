//
//  AllModel.m
//  Supermark
//
//  Created by 林伟池 on 15/8/17.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "AllModel.h"

/*
 #import "GoodsModel.h"
 #import "ShopModel.h"
 #import "UserModel.h"
 #import "AddressModel.h"
 #import "CartModel.h"
 #import "CategoryDetailModel.h"
 #import "OrderModel.h"
 #import "SettlementModel.h"
 */

@implementation AllModel

+(void)modelInit
{
    //暂定的修改，由model自己监听事件，来取代message调用。
    [GoodsModel instance];
    [ShopModel instance];
    [UserModel instance];
    [AddressModel instance];
    [CartModel instance];
    [CategoryDetailModel instance];
    [OrderModel instance];
    [SettlementModel instance];
}

@end