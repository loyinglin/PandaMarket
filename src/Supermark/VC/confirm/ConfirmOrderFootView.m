//
//  ConfirmOrderFootView.m
//  Supermark
//
//  Created by 林伟池 on 15/8/11.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "ConfirmOrderFootView.h"
#import "NSObject+LYNotification.h"
#import "ShopModel.h"
#import "CartModel.h"

@implementation ConfirmOrderFootView

#pragma mark - view init


-(void)awakeFromNib
{
    [self lyObserveNotification:NOTIFY_CART_DATA_CHANGE];
    [self viewInit];
}

-(void)dealloc
{
    [self lyRemoveAllObserveNotification];
}
#pragma mark - ui

-(void)viewInit
{
//    self.send.text = ""; 暂无配送费
    self.money.text = [NSString stringWithFormat:@"￥%.2f", [[CartModel instance] getTotalCostInCart]];
    self.total.text = self.money.text;//
    
    
    float needPrice = [[ShopModel instance] getCurrentShippingPrice];
    float totalPrice = [[CartModel instance] getTotalCostInCart];
    if (totalPrice < needPrice) {
        [self.confirm setTitle:[NSString stringWithFormat:@"还差%.0f元", needPrice - totalPrice] forState:UIControlStateNormal];
    }
    else
    {
        [self.confirm setTitle:@"确认订单" forState:UIControlStateNormal];
    }
}

-(IBAction) buttonClick:(id)sender
{
    
    float needPrice = [[ShopModel instance] getCurrentShippingPrice];
    float totalPrice = [[CartModel instance] getTotalCostInCart];
    
    if (needPrice <= totalPrice) {
        [self lyPostNotification:NOTIFY_UI_OPEN_SETTLEMENT_BOARD];
    }
    else{
        UIAlertView* view = [[UIAlertView alloc] initWithTitle:@"确认订单" message:[NSString stringWithFormat:@"还差%.2f元", needPrice - totalPrice]
                                                      delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
        [view show];
    }

}
#pragma mark - delegate

#pragma mark - notify

-(void)lyHandleNotification:(NSNotification *)notify
{
    if ([notify.name isEqualToString:NOTIFY_CART_DATA_CHANGE]) {
        [self viewInit];
    }
}


@end
