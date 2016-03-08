//
//  GoodsMessage.m
//  Supermark
//
//  Created by 林伟池 on 15/8/21.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "GoodsMessage.h"
#import "MessageUtil.h"

@implementation GoodsMessage

-(void)requestGetGoodsListByIds:(NSArray*)arr
{
    if (arr && arr.count > 0) {
        
        NSString* ids = [MessageUtil convertArrayToString:arr];
        NSDictionary* dict = [[NSDictionary alloc] initWithObjectsAndKeys:ids, @"goods_ids",
                       //       [NSNumber numberWithLong:[[ShopModel instance] getCurrentMerchantId]], @"merchant_id",
                              nil];
        
        [self sendRequestWithPost:[msgHttpPrefix stringByAppendingFormat:@"%@", msgGetGoodsListByIds] Param:dict success:^(id responseObject) {
            NSDictionary* dict = (NSDictionary*)responseObject;
            [[GoodsModel instance] addDictGoods:dict];
        }];
        
    }

}

@end
