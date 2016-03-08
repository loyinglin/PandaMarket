//
//  BaseEvent.m
//  Supermark
//
//  Created by 林伟池 on 15/8/26.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "BaseEvent.h"
#import <objc/runtime.h>

@implementation BaseEvent

+(instancetype)instance
{
    return [[[self class] alloc] init];
}

+(NSString *)notifyName
{
    return [[self class] description];
}

-(NSString *)toNotifyString
{
    return [[self class] notifyName];
}

-(void)fromNotifyDict:(NSDictionary *)dict
{
    unsigned int		propertyCount = 0;
    objc_property_t *	properties = class_copyPropertyList( [self class], &propertyCount );
    
    for ( NSUInteger i = 0; i < propertyCount; i++ )
    {
        const char *	name = property_getName(properties[i]);
        NSString *		propertyName = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];

        [self setValue:[dict objectForKey:propertyName] forKey:propertyName];
    }
    free(properties);
}

-(NSDictionary*)toNotifyDict
{
    NSMutableDictionary* ret = [[NSMutableDictionary alloc] init];
    unsigned int		propertyCount = 0;
    objc_property_t *	properties = class_copyPropertyList( [self class], &propertyCount );
    
    for ( NSUInteger i = 0; i < propertyCount; i++ )
    {
        const char *	name = property_getName(properties[i]);
        NSString *		propertyName = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        NSObject *	tempValue = [self valueForKey:propertyName];
        if (tempValue) {
            [ret setObject:tempValue forKey:propertyName];
        }
    }
    free(properties);
    return ret;
}

@end
