//
//  LoginCommand.m
//  Supermark
//
//  Created by 林伟池 on 15/8/18.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "LoginCommand.h"

@implementation LoginCommand

-(void)execute
{
    User* msg_user = (User*)self.data;
    if (msg_user) {
        [[UserModel instance] setLoginUserInfo:msg_user];
    }
    
  //  [[AddressMessage instance] requestGetAddressWithId:[[[UserModel instance] getUserID] integerValue]];

    LYLog(@"登陆成功");
    
    [self lyPostNotification:NOTIFY_LOGIN_SUCCESS];
}
@end
