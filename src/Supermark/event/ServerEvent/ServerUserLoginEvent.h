//
//  LoginEvent.h
//  Supermark
//
//  Created by 林伟池 on 15/8/26.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "BaseEvent.h"

@interface ServerUserLoginEvent : BaseEvent

@property (nonatomic , strong) NSNumber* selectId;

@end
