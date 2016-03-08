//
//  SettlementDetailView.m
//  Supermark
//
//  Created by 林伟池 on 15/8/13.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "SettlementDetailView.h"
#import "AddressModel.h"
#import "CartModel.h"
#import "ShopModel.h"
#import "RecentShopModel.h"

@implementation SettlementDetailView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - view init
-(void)viewInitWithAddress
{
    Address* address = [[AddressModel instance] getDefaultAddress];
    if (address) {
        self.address.text = [NSString stringWithFormat:@"收货地址：%@", address.address];
        self.phone.text = address.phone;
    }
    
    ShopLocation* location = [[RecentShopModel instance] getShopLocationByMerchantId:[[ShopModel instance] getCurrentMerchantId]];
    self.area.text = location.name; //小区的名字
    //配送费和优惠金额
    self.ship.text = @"￥0.00";
    
    //商品的
    self.money.text = [NSString stringWithFormat:@"￥%.2f", [[CartModel instance] getTotalCostInCart]];
    
    //总共的
    self.total.text = [NSString stringWithFormat:@"￥%.2f", [[CartModel instance] getTotalCostInCart]];
    
}
#pragma mark - ui

#pragma mark - delegate

#pragma mark - notify


@end
