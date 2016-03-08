//
//  UserModel.m
//  Supermark
//
//  Created by 林伟池 on 15/8/3.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel
{
    User* user;
    long myTime;
}

+(instancetype) instance
{
    static id test;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        test = [[[self class] alloc] init];
    });
    return test;
}


-(instancetype)init
{
    self = [super init];
    
    [self loadCache];
    
    return self;
}

#pragma mark - init

- (void)loadCache
{
    NSData* data = [[NSUserDefaults standardUserDefaults] objectForKey:[[self class] description]];
    if(data) {
        user = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
}

- (void)saveCache
{
    NSData *personEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:user];
    [[NSUserDefaults standardUserDefaults] setObject:personEncodedObject forKey:[[self class] description]];
    [self lyPostNotification:NOTIFY_USER_DATA_CHANGE];
}

- (void)clearCache
{
    user = nil;
    myTime = 0;
    [self saveCache];
}
#pragma mark - set

-(void)setLoginUserInfo:(User*)login_user
{
    if (user) {
        //之前已经登陆
    }
    user = login_user;
    [self saveCache];
}


#pragma mark - get


-(NSString*)getUserID
{
    NSString* ret = nil;
    if ([self isUserLogin]) {
        ret = user.user_id;
    }
    return ret;
}

-(NSString*)getUserPhone
{
    NSString* ret = nil;
    if ([self isUserLogin]) {
        ret = user.phone;
    }
    return ret;
    
}



-(BOOL)isUserLogin
{
    if (user) {
        return YES;
    }
    else{
        return NO;
    }
}


#pragma mark - update



#pragma mark - message



@end
