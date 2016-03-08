//
//  OrderViewCell.m
//  Supermark
//
//  Created by 林伟池 on 15/8/18.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "OrderViewCell.h"
#import "AllMessage.h"
#import "AllModel.h"
#import "UIConstant.h"
#import "UIImageView+AFNetworking.h"

@implementation OrderViewCell
{
    NSArray* arrImg;
    Order* myOrder;
}

-(void)awakeFromNib
{
    arrImg = [NSArray arrayWithObjects:self.img0, self.img1, self.img2
              , self.img3, nil];
    for (UIImageView* imgView in arrImg) {
        imgView.hidden = YES;
    }
    
    self.imgMore.hidden = YES;
    
    [self lyObserveNotification:NOTIFY_GOODS_DATA_CHANGE];
}

#pragma mark - view init

- (void)lyInit:(Order*)order
{
    myOrder = order;
    if (order) {
        NSDate* date = [[NSDate alloc] initWithTimeIntervalSince1970:order.create_time.integerValue];
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm:ss"];
        self.time.text = [dateFormatter stringFromDate:date];
        self.money.text = [NSString stringWithFormat:@"￥%.2f", [order getTotalMoney]];
        self.status.text = [UIConstant getOrderStatusDesc:order.status.integerValue];
        
        if (order.shop_name) {
            self.shop.text = order.shop_name;
        }
        [self showImg];
    }
}
#pragma mark - ui

-(void)showImg
{
    Order* order = myOrder;

    
    for (UIImageView* imgView in arrImg) {
        imgView.hidden = YES;
    }
    self.imgMore.hidden = YES;
    self.goodsDesc.hidden = YES;
    
    
    if (order) {
        for (int i = 0; i < order.goods_list.count && i < arrImg.count; ++i) {
            NSArray* param = [order getParamsByIndex:i];
            if (param && param.count >= 3) {
                NSNumber* goods_id = param[0];
                UIImageView* img = arrImg[i];
                img.hidden = NO;
                
                SimpleGoods* simple_goods = [[GoodsModel instance] getSimpleGoodsById:goods_id.integerValue];
                if (simple_goods) {
                    [img setImageWithURL:[[NSURL alloc] initWithString:[[[ShopModel instance] getCurrentPrefix] stringByAppendingString:simple_goods.img]]];
                    
                    
                    if (order.goods_list.count == 1 && i == 0) {
                        self.goodsDesc.text = [NSString stringWithFormat:@"%@ x   %@", simple_goods.name, (NSNumber*)param[2]];
                        self.goodsDesc.hidden = NO;
                    }
                }
            }
        }
        if (order.goods_list.count > arrImg.count) {
            self.imgMore.hidden = NO;
        }
        
    }
}

#pragma mark - delegate

#pragma mark - notify
-(void)lyHandleNotification:(NSNotification *)notify
{
    if ([notify.name isEqualToString:NOTIFY_GOODS_DATA_CHANGE]) {
        [self showImg];
    }
}

@end
