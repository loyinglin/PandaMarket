//
//  LYEventCenter.h
//  Supermark
//
//  Created by 林伟池 on 15/8/26.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseEvent.h"

@interface LYEventCenter : NSObject

+(instancetype) instance;

-(BaseEvent*)lyGetEventByNotify:(NSNotification*)notify;

@end
