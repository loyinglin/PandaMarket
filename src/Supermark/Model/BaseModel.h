//
//  LYModel.h
//  Supermark
//
//  Created by 林伟池 on 15/8/17.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelConst.h"
#import "NSDictionary+LYDictToObject.h"
#import "NSObject+LYNotification.h"
#import "Supermark.h"

@interface BaseModel : NSObject

//+(instancetype) instance; 一个model只能对应一个单例，不能用

-(void)clearCache;

@end
