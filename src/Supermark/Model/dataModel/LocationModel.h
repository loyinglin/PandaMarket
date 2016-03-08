//
//  LocationModel.h
//  Supermark
//
//  Created by 林伟池 on 15/9/22.
//  Copyright © 2015年 林伟池. All rights reserved.
//

#import "BaseModel.h"

@interface LocationModel : BaseModel

+(instancetype)instance;

#pragma mark - init


#pragma mark - set

- (void)setArrShop:(NSArray*)arr;


#pragma mark - get

- (long)getArrShopCount;

- (ShopLocation*)getShopLocationByIndex:(long)index;

/**
 *  通过ID获取小区定位数据，如果没定为过，那么没有数据
 *
 *  @param merchantId <#merchantId description#>
 *
 *  @return <#return value description#>
 */
- (ShopLocation*)getShopLocationById:(long)merchantId;


#pragma mark - update



#pragma mark - message


@end
