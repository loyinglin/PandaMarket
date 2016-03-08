//
//  DateModel.m
//  PandaMarket
//
//  Created by 林伟池 on 15/10/3.
//  Copyright © 2015年 林伟池. All rights reserved.
//

#import "DateModel.h"
#import "LYTicker.h"

@implementation DateModel
{
    long myNotifyCodeTime;
}

+(instancetype) instance
{
    static id test;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        test = [[[self class] alloc] init];
    });
    return test;
}


#pragma mark - init


#pragma mark - set


- (void)setNotifyCodeTime:(long)time
{
    myNotifyCodeTime = time * COUNT_PER_SECOND;
    [[LYTicker instance] addReceiver:self];
}


#pragma mark - get

- (long)getNotifyCodeTime
{
    return myNotifyCodeTime / COUNT_PER_SECOND;
}

#pragma mark - update
ON_TICK(timer)
{
    myNotifyCodeTime--;
    long time = myNotifyCodeTime / COUNT_PER_SECOND;
    if (time <= 0) {
        [[LYTicker instance] removeReceiver:self];
    }
    DataDateModelEvent* event = [DataDateModelEvent instance];
    event.time = time;
    [self lyPostEvent:event];
}

#pragma mark - message

@end
