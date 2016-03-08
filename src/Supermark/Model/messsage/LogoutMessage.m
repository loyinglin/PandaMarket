//
//  LogoutMessage.m
//  Supermark
//
//  Created by 林伟池 on 15/8/19.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "LogoutMessage.h"

@implementation LogoutMessage

-(void)requestLogout
{
    //请求登出
    
    //BACK
    [self lyPostNotification:NOTIFY_USER_LOGOUT];
    
    [[CartModel instance] clearCache];
    [[AddressModel instance] clearCache];
    [[UserModel instance] clearCache];
    [[OrderModel instance] clearCache];
}


@end
