//
//  BaseEvent.h
//  Supermark
//
//  Created by 林伟池 on 15/8/26.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseEvent : NSObject

+(instancetype)instance;

-(NSString*)toNotifyString;

+(NSString*)notifyName;

-(void)fromNotifyDict:(NSDictionary*)dict;

-(NSDictionary*)toNotifyDict;

@end
