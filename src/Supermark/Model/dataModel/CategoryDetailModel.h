//
//  CategoryDetailModel.h
//  Supermark
//
//  Created by 林伟池 on 15/8/20.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "BaseModel.h"

@interface CategoryDetailModel : BaseModel

+(instancetype) instance;

-(void)updateCategoryDetailGoodsById:(long)category_id;

-(void)setCategoryDetailGoods:(NSMutableArray*)goods_arr CategoryId:(long)category_id;

-(long)getGoodsCount;

-(DetailGoods*)getDetailGoodsByIndex:(long)index;

-(void)onShopChange;

@end
