//
//  LocationMessage.m
//  Supermark
//
//  Created by 林伟池 on 15/9/22.
//  Copyright © 2015年 林伟池. All rights reserved.
//

#import "LocationMessage.h"
#import "LocationModel.h"

@implementation LocationMessage

-(void)requestGetNearMerchant:(float)lon Lat:(float)lat Num:(long)num
{
    NSNumber* myLon = [NSNumber numberWithFloat:lon];
    NSNumber* myLat = [NSNumber numberWithFloat:lat];
    NSNumber* myNum = [NSNumber numberWithLong:num];
    
    
    NSMutableDictionary* param = [[NSMutableDictionary alloc] init];
    [param setObject:myLon forKey:@"lon"];
    [param setObject:myLat forKey:@"lat"];
    [param setObject:myNum forKey:@"num"];
    
    
    [self sendRequestWithPost:[msgHttpPrefix stringByAppendingFormat:@"%@", msgGetNearMerchant] Param:param success:^(id responseObject) {
        NSArray* data = (NSArray*)responseObject;
        NSMutableArray* arrShop = [NSMutableArray array];
        for (NSDictionary* dict in data) {
            NSNumber* dis = [dict objectForKey:@"dis"];
            NSDictionary* obj = [dict objectForKey:@"obj"];
            ShopLocation* item = [obj objectForClass:[ShopLocation class]];
            item.dis = dis;
            if (item) {
                [arrShop addObject:item];
            }
        }
        
        [[LocationModel instance] setArrShop:arrShop];
    }];
}


@end
