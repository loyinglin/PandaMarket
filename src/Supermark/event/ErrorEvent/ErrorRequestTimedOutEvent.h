//
//  ErrorRequestTimedOutEvent.h
//  Supermark
//
//  Created by 林伟池 on 15/9/5.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "BaseEvent.h"

@interface ErrorRequestTimedOutEvent : BaseEvent

@property (nonatomic , strong) NSString* requestStr;

@end
