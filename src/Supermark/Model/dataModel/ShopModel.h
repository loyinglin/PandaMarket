//
//  ShopModel.h
//  Supermark
//
//  Created by 林伟池 on 15/8/3.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "BaseModel.h"

@interface ShopModel : BaseModel



#pragma mark - init

+(instancetype) instance;

#pragma mark - set

-(void)setDefaultIdAndRquest:(long)merchantId Area:(long)areaId Update:(BOOL)update;

-(void)setSysInfo:(Sys_info*)sys;

-(void)setMerchantInfo:(Merchant*)merchant_info;

#pragma mark - get

-(NSArray*)getSubCategorysByID:(long)categoryID;

-(IndexCategory*)getIndexCategoryByID:(long)categoryID;

-(IndexCategory*)getIndexCategoryByIndex:(long)index;

-(NSString*)getIndexCategoryNameByID:(long)categoryID;

-(long)getCurrentMerchantId;

-(float)getCurrentShippingPrice;

-(long)getCurrentCategoryCount;

-(NSString*)getCurrentPrefix;

-(Base*)getCurrentMerchantBase;

-(NSString*)getStringMerchantId;

/**
 *  获取指定index目录的goods数量
 *
 *  @param index <#index description#>
 *
 *  @return <#return value description#>
 */
-(long)getGoodsCountByIndex:(long)index;

/**
 *  是否需要定位
 *
 *  @return <#return value description#>
 */
-(BOOL)getNeedLocation;

/**
 *  是否需要提示
 *
 *  @return YES：首次返回；NO：其他询问。
 */
-(BOOL)getAlertAble;

- (long)getAreaId;

#pragma mark - update

-(void)updateMerchantInfo;

#pragma mark - message


@end
