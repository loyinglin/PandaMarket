//
//  OrderDetailGoodsCellTableViewCell.m
//  Supermark
//
//  Created by 林伟池 on 15/8/18.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "OrderDetailGoodsCell.h"
#import "AllModel.h"
#import "NSObject+LYNotification.h"
#import "UIImageView+AFNetworking.h"

@implementation OrderDetailGoodsCell
{
    long my_goods_id;
    float my_price;
    long my_count;
}


#pragma mark - view init

- (void)awakeFromNib {
    // Initialization code
    [self lyObserveNotification:NOTIFY_GOODS_DATA_CHANGE];
}

- (void)dealloc
{
    [self lyRemoveAllObserveNotification];
}

-(void)viewInitWithGoodsId:(long)goods_id Price:(float)price Count:(long)count
{
    my_goods_id = goods_id;
    my_price = price;
    my_count = count;
    self.money.text = [NSString stringWithFormat:@"￥%.2f", price];
    self.count.text = [NSString stringWithFormat:@"x%ld", count];
    [self updateGoods];
}

-(void)updateGoods
{
    if (my_goods_id) {
        SimpleGoods* simple_goods = [[GoodsModel instance] getSimpleGoodsById:my_goods_id];
        if (simple_goods) {
            [self.img setImageWithURL:[[NSURL alloc] initWithString:[[[ShopModel instance] getCurrentPrefix] stringByAppendingString:simple_goods.img]]];
            self.name.text = simple_goods.name;
        }
    }
}

#pragma mark - ui

#pragma mark - delegate

#pragma mark - notify
-(void)lyHandleNotification:(NSNotification *)notify
{
    if ([notify.name isEqualToString:NOTIFY_GOODS_DATA_CHANGE]) {
        [self updateGoods];
    }
}


@end
