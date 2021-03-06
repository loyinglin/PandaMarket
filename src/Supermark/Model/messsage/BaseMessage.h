//
//  BaseMessage.h
//  Supermark
//
//  Created by 林伟池 on 15/8/18.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "ModelConst.h"
#import "AFNetworking.h"
#import "AllModel.h"
#import "NSObject+LYNotification.h"
#import <Foundation/Foundation.h>

@interface BaseMessage : NSObject

typedef void(^AfterMessageSuccess)(void);

@property (nonatomic) BOOL background;

@property (nonatomic, strong) AfterMessageSuccess myCallback;

+(instancetype)instance;

+(instancetype)backgroundInstance;

+(instancetype)callbackInstance:(AfterMessageSuccess)callback;

-(void)sendRequestWithPost:(NSString*)str Param:(NSDictionary*)param success:(void (^)(id responseObject))success;

@end
