//
//  MessageBridge.m
//  Supermark
//
//  Created by 林伟池 on 15/8/19.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "NotifyDefaultReceiver.h"
#import "AllMessage.h"
#import "AllModel.h"
#import "NSObject+LYNotification.h"

@implementation NotifyDefaultReceiver

+(instancetype) instance
{
    static NotifyDefaultReceiver* test;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        test = [[NotifyDefaultReceiver alloc] init];
    });
    return test;
}

-(instancetype)init
{
    self = [super init];
        
    return self;
}









@end
