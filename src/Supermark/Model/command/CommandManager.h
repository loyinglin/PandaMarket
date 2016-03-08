//
//  CommandManager.h
//  Supermark
//
//  Created by 林伟池 on 15/8/18.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommandManager : NSObject

+(instancetype) instance;

+(void)excuteCommand:(NSString*)command_name;

@end
