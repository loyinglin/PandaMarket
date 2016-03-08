//
//  ConfirmGoodsCell.m
//  Supermark
//
//  Created by 林伟池 on 15/8/10.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "ConfirmGoodsCell.h"
#import "UIImageView+AFNetWorking.h"
#import "CartModel.h"
#import "ShopModel.h"

@implementation ConfirmGoodsCell
{
    CartGoods* cart_goods;
}



-(void)initViewWithIndex:(int)index
{
    self.indexOfView = index;
    //get data by index
    if (index < [[CartModel instance] getCartCount]) {
        cart_goods = [[CartModel instance] getCartGoodsByIndex:index];
        [self setName:cart_goods.name setMoney:cart_goods.price.intValue setCount:cart_goods.count.intValue];
        NSString* prefix = [[ShopModel instance] getCurrentPrefix];
        if (prefix && cart_goods.img) {
            [self.img setImageWithURL:[[NSURL alloc] initWithString:[prefix stringByAppendingString:cart_goods.img]]];
        }
    }
    
}

-(void)setName:(NSString*)name setMoney:(float)money setCount:(int)count
{
    self.name.text = name;
    self.money.text = [NSString stringWithFormat:@"￥%.2f", money * count];
    [self.count setTitle:[NSString stringWithFormat:@"%d", count] forState:UIControlStateNormal];
}


-(IBAction)numAdd:(id)sender
{
    if ([cart_goods isKindOfClass:[CartGoods class]]) {
        [[CartModel instance] ChangeCartGoods:cart_goods.goods_id.integerValue IsAdd:YES];
    }
}

-(IBAction)numMinus:(id)sender
{
    if ([cart_goods isKindOfClass:[CartGoods class]]) {
        [[CartModel instance] ChangeCartGoods:cart_goods.goods_id.integerValue IsAdd:NO];
    }
}


@end
