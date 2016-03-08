//
//  MessageUtil.m
//  Supermark
//
//  Created by 林伟池 on 15/8/20.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "MessageUtil.h"

@implementation MessageUtil

+(NSString*)convertArrayToString:(NSArray*)arr
{
    NSString* ret = @"";
    
    if([NSJSONSerialization isValidJSONObject:arr]){
        NSError* error;
        NSData* jsonData = [NSJSONSerialization dataWithJSONObject:arr options:0 error:&error];
        ret = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    else{
        LYLog(@"not valid json");
    }
    
    return ret;
}

+(NSArray*)convertStringToArray:(NSString*)str
{
    NSArray* ret;
    NSData* jsonData = [str dataUsingEncoding:NSUTF8StringEncoding];

        NSError* error;
        ret = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];

    
    
    return ret;
}
@end
