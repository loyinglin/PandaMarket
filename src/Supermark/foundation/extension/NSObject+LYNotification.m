//
//  NSObject+LYNotification.m
//  Supermark
//
//  Created by 林伟池 on 15/8/2.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "NSObject+LYNotification.h"

@implementation NSObject (LYNotification)

- (void)lyObserveEvent:(BaseEvent *)event
{
    NSString* key = [event toNotifyString];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:key
                                                  object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onNotifyBack:)
                                                 name:key
                                               object:nil];
}

- (void)lyPostEvent:(BaseEvent *)event
{
    [self lyPostNotificationWithSender:[event toNotifyString]  withData:[event toNotifyDict]];
}

- (void)lyObserveNotification:(NSString *)name
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:name
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onNotifyBack:)
                                                 name:name
                                               object:nil];
}


- (void)lyRemoveObserveNotification:(NSString *)name
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:name object:nil];
}

- (void)lyRemoveAllObserveNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)lyPostNotification:(NSString *)name
{
    dispatch_async(dispatch_get_main_queue(), ^{
    [[NSNotificationCenter defaultCenter] postNotificationName:name  object:self];
    });
}

- (void)lyPostNotificationWithSender:(NSString *)name withData:(NSDictionary *)data
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:name object:self userInfo:data];
    });
}

- (void)onNotifyBack:(NSNotification*)notify
{
    Class clazz = NSClassFromString(notify.name);
    if(clazz){
        id obj = [[clazz alloc] init];
        if ([obj isKindOfClass:[BaseEvent class]]) {
            BaseEvent* event = (BaseEvent*)obj;
            [event fromNotifyDict:notify.userInfo];
            [self lyHandleEvent:event];
            return ;
        }
    }
    [self lyHandleNotification:notify];
    
}

- (void)lyHandleNotification:(NSNotification *)notify
{
    
}

- (void)lyHandleEvent:(BaseEvent*)event
{
    LYLog(@"handle event");
}
@end
