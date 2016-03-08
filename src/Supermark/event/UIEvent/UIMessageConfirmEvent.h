//
//  UIMessageConfirmEvent.h
//  Supermark
//
//  Created by 林伟池 on 15/8/26.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "BaseEvent.h"

/**
 *  留言
 */
@interface UIMessageConfirmEvent : BaseEvent

@property (nonatomic , strong) NSString* message;

@end
