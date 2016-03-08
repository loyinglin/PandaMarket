//
//  LoginMessage.m
//  Supermark
//
//  Created by 林伟池 on 15/8/18.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "LoginMessage.h"
#import "AddressMessage.h"

@implementation LoginMessage


#pragma mark - msg

/**
 *  获取验证码
 *
 *  @param phone 手机号码
 */
-(void)requestGetPhoneCode:(NSString*)phone
{
    
    NSDictionary* dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                          phone, @"phone",
                          nil];
    
    [self sendRequestWithPost:[msgHttpPrefix stringByAppendingString:(NSString*)msgSendVerify] Param:dict success:^(id responseObject){
        
        NSNumber* data = (NSNumber*)responseObject;
        [UserModel instance].verify_code = data.integerValue;
        LYLog(@"验证码:%ld", data.integerValue);
        
        [self lyPostEvent:[ServerGetPhoneCodeEvent instance]];
    }];
}


/**
 *  登陆
 *
 *  @param phone 手机
 *  @param codes 验证码
 */
-(void)requestLoginWithPhone:(NSString*)phone Code:(long)codes
{    
    
    NSDictionary* dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                          [NSNumber numberWithLong:codes], @"verify",
                          phone, @"phone",
                          nil];
    
    [self sendRequestWithPost:[msgHttpPrefix stringByAppendingString:(NSString*)msgUserLogin] Param:dict success:^(id responseObject){
        NSDictionary* data = (NSDictionary*)responseObject;
        User* msg_user = [data objectForClass:[User class]];
        [[UserModel instance] setLoginUserInfo:msg_user];
        
        LYLog(@"登陆成功");
        
        [self lyPostNotification:NOTIFY_LOGIN_SUCCESS];
        
        
        [[AddressMessage instance] requestGetAddress];
        
        ServerUserLoginEvent* event = [[ServerUserLoginEvent alloc] init];
        event.selectId = [NSNumber numberWithInt:123];
        [self lyPostEvent:event];
    
    }];
}


@end
