//
//  LoginMessage.h
//  Supermark
//
//  Created by 林伟池 on 15/8/18.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseMessage.h"

@interface LoginMessage :BaseMessage

-(void)requestGetPhoneCode:(NSString*)phone;

-(void)requestLoginWithPhone:(NSString*)phone Code:(long)codes;

@end
