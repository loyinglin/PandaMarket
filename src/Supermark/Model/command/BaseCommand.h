//
//  BaseCommand.h
//  Supermark
//
//  Created by 林伟池 on 15/8/18.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AllModel.h"
#import "NSObject+LYNotification.h"
//#import "AllMessage.h"

@interface BaseCommand : NSObject

+(instancetype)instance;

-(void)execute;

@property (nonatomic , strong) id data;

@end
