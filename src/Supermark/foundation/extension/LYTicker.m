//
//  LYTicker.m
//  Supermark
//
//  Created by 林伟池 on 15/8/24.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "LYTicker.h"
#import "NSObject+Ticker.h"

@implementation LYTicker
{
    CADisplayLink *		_timer;
    NSTimeInterval		_interval;
    NSTimeInterval		_timestamp;
    NSMutableArray *	_receivers;
}

+(instancetype) instance
{
    static LYTicker* test;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        test = [[LYTicker alloc] init];
    });
    return test;
}

- (id)init
{
    self = [super init];
    if ( self )
    {
        _interval = (1.0f / COUNT_PER_SECOND);
        _receivers = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)addReceiver:(NSObject *)obj
{
    if ( NO == [_receivers containsObject:obj] )
    {
        [_receivers addObject:obj];
        
        if ( nil == _timer )
        {
            _timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(performTick)];
            [_timer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
            
            _timestamp = [NSDate timeIntervalSinceReferenceDate];
        }
    }
}

- (void)removeReceiver:(NSObject *)obj
{
    [_receivers removeObject:obj];
    
    if ( 0 == _receivers.count )
    {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)performTick
{
    NSTimeInterval tick = [NSDate timeIntervalSinceReferenceDate];
    NSTimeInterval elapsed = tick - _timestamp;
    
    if ( elapsed >= _interval )
    {
        NSArray * array = [NSArray arrayWithArray:_receivers];
        
        for ( NSObject * obj in array )
        {
            if ( [obj respondsToSelector:@selector(lyHandleTick:)] )
            {
                [obj lyHandleTick:elapsed];
            }
        }
        
        _timestamp = tick;
    }
}

- (void)dealloc
{
    [_timer invalidate];
    _timer = nil;
    
    [_receivers removeAllObjects];
}


-(void)lyHandleTick:(NSTimeInterval)elapsed
{
    
}

@end
