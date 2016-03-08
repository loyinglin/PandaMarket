//
//  CartMessage.m
//  Supermark
//
//  Created by 林伟池 on 15/8/19.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "CartMessage.h"
#import "MessageUtil.h"

@implementation CartMessage

-(void)requestUpdateCartGoods
{
    NSArray* arr = [[CartModel instance] getCartGoodsId];
    if (arr && arr.count > 0) {
        
        NSString* ids = [MessageUtil convertArrayToString:arr];
        NSDictionary* dict = [[NSDictionary alloc] initWithObjectsAndKeys:ids, @"goods_ids",
                              [NSNumber numberWithLong:[[ShopModel instance] getCurrentMerchantId]], @"merchant_id",
                              nil];
        
        [self sendRequestWithPost:[msgHttpPrefix stringByAppendingFormat:@"%@", msgGetMerchantGoodsPriceByGoodsIds] Param:dict success:^(id responseObject) {
            NSArray* data = (NSArray*)responseObject;
            NSMutableArray* arr = [[NSMutableArray alloc] init];
            for (NSDictionary* item in data) {
                NSString* goods_id = [item objectForKey:@"goods_id"];
                NSString* price = [item objectForKey:@"price"];
                
                [arr addObject:[NSArray arrayWithObjects:[NSNumber numberWithLong:[goods_id integerValue]], [NSNumber numberWithFloat:[price floatValue]], nil]];
            }
            
            [[CartModel instance] updateCArtGoodsWith:arr];
        }];
    }
}
@end
