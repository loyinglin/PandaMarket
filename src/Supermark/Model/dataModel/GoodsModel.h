//
//  GoodsModel.h
//  Supermark
//
//  Created by 林伟池 on 15/8/21.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "BaseModel.h"

@interface GoodsModel : BaseModel

+(instancetype) instance;

/**
 *  添加单个物品
 *
 *  @param simple_goods <#simple_goods description#>
 */
-(void)addSimpleGoods:(SimpleGoods*)simple_goods;


/**
 *  添加物品字典
 *
 *  @param dict_goods <#dict_goods description#>
 */
-(void)addDictGoods:(NSDictionary*)dict_goods;

/**
 *  根据ID 获取缓存中的物品
 *
 *  @param goods_id 物品ID
 *
 *  @return 物品
 */
-(SimpleGoods*)getSimpleGoodsById:(long)goods_id;


@end
