//
//  UIPressGoodsViewEvent.h
//  PandaMarket
//
//  Created by 林伟池 on 15/10/12.
//  Copyright © 2015年 林伟池. All rights reserved.
//

#import "BaseEvent.h"
#import "Supermark.h"

@interface UIPressGoodsViewEvent : BaseEvent

@property (nonatomic , strong) DetailGoods* goods;

@end
