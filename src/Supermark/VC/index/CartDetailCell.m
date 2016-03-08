//
//  IndexBottomBarView.m
//  Supermark
//
//  Created by 林伟池 on 15/8/2.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "CartDetailCell.h"
#import "CartModel.h"

@implementation CartDetailCell
{
    CartGoods* cart_goods;
}

-(void)awakeFromNib
{
    
}


-(void)prepareForReuse
{
    [super prepareForReuse];
}

-(void)initViewWithIndex:(int)index
{
    self.indexOfView = index;
    //get data by index
    if (index < [[CartModel instance] getCartCount]) {
        cart_goods = [[CartModel instance] getCartGoodsByIndex:index];
        [self setName:cart_goods.name setMoney:cart_goods.price.intValue setCount:cart_goods.count.intValue];
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
    [[CartModel instance] ChangeCartGoods:cart_goods.goods_id.integerValue IsAdd:YES];
}

-(IBAction)numMinus:(id)sender
{
    [[CartModel instance] ChangeCartGoods:cart_goods.goods_id.integerValue IsAdd:NO];
}

@end
