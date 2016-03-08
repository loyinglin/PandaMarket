//
//  LYEventCenter.m
//  Supermark
//
//  Created by 林伟池 on 15/8/26.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "LYEventCenter.h"

@implementation LYEventCenter
{
    NSMutableDictionary* dict; //notify_string 
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

-(instancetype)init
{
    self = [super init];
    if (self) {
        dict = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(BaseEvent*)lyGetEventByNotify:(NSNotification *)notify
{
    NSString* key = notify.name;
    Class clazz = [self class];
    if ([dict objectForKey:key]) {
        clazz = [dict objectForKey:key];
    }
    BaseEvent* ret = [[clazz alloc] init];
    [ret fromNotifyDict:notify.userInfo];
    
    return ret;
}

@end
