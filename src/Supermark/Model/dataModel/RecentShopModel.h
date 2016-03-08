//
//  RecentShopModel.h
//  Supermark
//
//  Created by 林伟池 on 15/9/23.
//  Copyright © 2015年 林伟池. All rights reserved.
//

#import "BaseModel.h"
@interface RecentShopModel : BaseModel

+(instancetype)instance;

#pragma mark - init


#pragma mark - set

- (void)setShopLocation:(ShopLocation*)current;


#pragma mark - get
- (long)getRecentShopInfoCount;

- (ShopLocation*)getSimpleShopInfoByIndex:(long)index;

- (ShopLocation*)getShopLocationByMerchantId:(long)merchantId;

- (NSString*)getCurrentAreaName;

#pragma mark - update



#pragma mark - message

@end
