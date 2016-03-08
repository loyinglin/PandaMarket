//
//  UIChangeShopSelectEvent.h
//  Supermark
//
//  Created by 林伟池 on 15/8/26.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "BaseEvent.h"

@interface UIChangeShopSelectEvent : BaseEvent

@property (nonatomic) long merchantId;
@property (nonatomic) long areaId;

@end
