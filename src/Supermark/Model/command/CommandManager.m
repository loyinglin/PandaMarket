//
//  CommandManager.m
//  Supermark
//
//  Created by 林伟池 on 15/8/18.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "CommandManager.h"


@implementation CommandManager

+(instancetype) instance
{
    static CommandManager* test;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        test = [[CommandManager alloc] init];
    });
    return test;
}


+(void)excuteCommand:(NSString *)command_name
{
    Class clazz = NSClassFromString(command_name);
    if (clazz) {
        id command = [[clazz alloc] init];
        if ([command respondsToSelector:@selector(execute:)]) {
            [command performSelector:@selector(execute:) withObject:nil];
        }
    }
}

@end
