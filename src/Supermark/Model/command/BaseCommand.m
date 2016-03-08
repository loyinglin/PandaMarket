//
//  BaseCommand.m
//  Supermark
//
//  Created by 林伟池 on 15/8/18.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "BaseCommand.h"

@implementation BaseCommand

+(instancetype)instance
{
    return [[[self class] alloc] init];
}

-(void)execute
{
    LYLog(@"excute command");
}

@end
