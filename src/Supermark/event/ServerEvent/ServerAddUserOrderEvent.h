//
//  ServerAddUserOrderSuccessEvent.h
//  Supermark
//
//  Created by 林伟池 on 15/9/4.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "BaseEvent.h"

@interface ServerAddUserOrderEvent : BaseEvent

@property (nonatomic) bool success;
@property (nonatomic) long orderId;

@end