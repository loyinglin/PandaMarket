//
//  NSObject+Ticker.m
//  Supermark
//
//  Created by 林伟池 on 15/8/24.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "NSObject+Ticker.h"
#import "LYTicker.h"

@implementation NSObject (Ticker)

- (void)lyObserveTick
{
    [[LYTicker instance] addReceiver:self];
}

- (void)lyUnobserveTick
{
    [[LYTicker instance] removeReceiver:self];
}

- (void)lyHandleTick:(NSTimeInterval)elapsed
{
    LYLog(@"ticker! should not be appear");
}


@end
