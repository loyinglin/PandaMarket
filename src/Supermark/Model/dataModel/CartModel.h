//
//  CartModel.h
//  Supermark
//
//  Created by 林伟池 on 15/8/3.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "BaseModel.h"

@interface CartModel : BaseModel

+(instancetype)instance;

/**
 *  在商品展示页面添加物品
 *
 *  @param goods 增加的物品
 */
- (void)addWithGoods:(DetailGoods*)goods;

- (void)removeWithGoods:(DetailGoods *)goods;

- (void)ChangeCartGoods:(long)goodsId IsAdd:(BOOL)add; //在可以显示零的地方调用

- (void)clearEmptyGoods;

- (CartGoods*)getCartGoodsById:(long)goodsId;

- (CartGoods*)getCartGoodsByIndex:(long)index;

- (void)clearCache;
/**
 *  购物车物品种数
 *
 *  @return long
 */
- (long)getCartCount;

- (float)getTotalCostInCart;

- (void)clearCartGoods;

- (NSArray*)getCartGoodsId;

/**
 *  获取添加订单用的数组
 *
 *  @return <#return value description#>
 */
- (NSArray*)getCartGoodsList;

/**
 *  购物车goods总共数量
 *
 *  @return long
 */
- (long)getGoodsCount;

- (void)onShopChange;

- (void)updateCArtGoodsWith:(NSArray*)arr;

@end
