//
//  LYTicker.h
//  Supermark
//
//  Created by 林伟池 on 15/8/24.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

#pragma mark -

#undef	ON_TICK
#define ON_TICK( __time ) \
- (void)lyHandleTick:(NSTimeInterval)__time

#define COUNT_PER_SECOND 3

#pragma mark -

@interface LYTicker : NSObject


+(instancetype) instance;

@property (nonatomic, readonly)	CADisplayLink *		timer;
@property (nonatomic, readonly)	NSTimeInterval		timestamp;
@property (nonatomic, assign) NSTimeInterval		interval;


- (void)addReceiver:(NSObject *)obj;
- (void)removeReceiver:(NSObject *)obj;
@end
