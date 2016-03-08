//
//  UserModel.h
//  Supermark
//
//  Created by 林伟池 on 15/8/3.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "BaseModel.h"

@interface UserModel : BaseModel

+(instancetype) instance;

@property(nonatomic, strong) NSArray* fields;

@property long verify_code;



#pragma mark - init

-(void)clearCache;


#pragma mark - set

- (void)setLoginUserInfo:(User*)login_user;

#pragma mark - get

-(NSString*)getUserID;

-(NSString*)getUserPhone;

-(BOOL)isUserLogin;


#pragma mark - update



#pragma mark - message


@end
