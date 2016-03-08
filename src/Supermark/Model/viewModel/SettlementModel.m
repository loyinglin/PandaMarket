//
//  SettlementModel.m
//  Supermark
//
//  Created by 林伟池 on 15/9/4.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "SettlementModel.h"

@implementation SettlementModel
{
    NSString* userMsg;
    NSNumber* userShippingType;
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

-(void)setMessage:(NSString *)msg
{
    userMsg = msg;
}

-(NSString *)getMessage
{
    if (!userMsg || userMsg.length == 0) {
        userMsg = @"null"; //为空时
    }
    return userMsg;
}

-(void)setShipping_type:(long)shipping_type
{
    userShippingType = [NSNumber numberWithLong:shipping_type];
}

-(NSNumber *)getShipping_type
{
    if (!userShippingType) {
        userShippingType = [NSNumber numberWithLong:0];
    }
    return userShippingType;
}
@end
