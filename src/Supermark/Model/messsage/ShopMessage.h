//
//  ShopMessage.h
//  Supermark
//
//  Created by 林伟池 on 15/8/18.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "BaseMessage.h"

@interface ShopMessage : BaseMessage

-(void)requestGetMerchantInfo:(long)merchant_id;

-(void)requestGetSubCategoryGoods:(long)sub_category_id;

-(void)requestGetCommunityServerById:(long)areaId;

@end
