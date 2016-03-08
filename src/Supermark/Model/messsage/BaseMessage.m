//
//  BaseMessage.m
//  Supermark
//
//  Created by 林伟池 on 15/8/18.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "BaseMessage.h"
#import "NSObject+LYNotification.h"
#import "NSObject+LYUITipsView.h"
#import <CFNetwork/CFNetwork.h>

@implementation BaseMessage

+(instancetype)instance
{
    return [[[self class] alloc] init];
}

+(instancetype)backgroundInstance
{
    BaseMessage* ret = [[[self class] alloc] init];
    ret.background = YES;
    return ret;
}

+(instancetype)callbackInstance:(AfterMessageSuccess)callback
{
    BaseMessage* ret = [[[self class] alloc] init];
    ret.myCallback = callback;
    
    return ret;
}

-(void)sendRequestWithPost:(NSString *)str Param:(NSDictionary *)param success:(void (^)(id))success
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = 10;
    if (!self.background) {
        [self presentLoadingTips:@"加载中"];
    }
    
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL: [NSURL URLWithString:str]];
    if (cookies.count > 0) {
        for (NSHTTPCookie* item in cookies) {
     //       LYLog(@"%@", [item description]);
        }
    }
    else{
        [self loadCookie];
    }
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", nil];
    
    [manager POST:str parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (!self.background) {
            [self dismissTips];
        }
        NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:[operation.responseString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
        
        NSNumber* code = [dict objectForKey:@"code"];
        if (code.integerValue == msg_success) {
            id data = [dict objectForKey:@"data"];
            success(data);

            /**
             *  成功后回调，在success之后
             */
            if (self.myCallback) {
                self.myCallback();
            }
            
            /**
             *  bug
                cookie没有设置成服务器给的expiresDate 所以sessionOnly:TRUE，app重启就会被删除
                暂时没找到解决方案，先缓存
             */
            NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL: [NSURL URLWithString:str]];
            for (NSHTTPCookie* item in cookies) {
                [self saveCookie:item];
            }
        }
        else if (code.integerValue == msg_session_expire){

            
            [[UserModel instance] clearCache];
            [[AddressModel instance] clearCache];
            
            UIViewController* controller = [self getCurrentVC];
            
            UIViewController* login = [controller.storyboard instantiateViewControllerWithIdentifier:@"login_view_controller"];
            [controller presentViewController:login animated:YES completion:^{
                
            }];
        }
        else if (code.integerValue == msg_verify_code_error){
            [self presentMessageTips:@"验证码错误"];
        }
        else if (code.integerValue == msg_server_error){
            [self presentMessageTips:@"服务器错误"];
        }
        else
        {
            if (false) {
                NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL: [NSURL URLWithString:[msgHttpPrefix stringByAppendingFormat:@"%@", msgUserLogin]]];
                LYLog(@"%@", [cookies description]);
//                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:cookies];
//                [[NSUserDefaults standardUserDefaults] setObject:data forKey:kUserDefaultsCookie];
            }
            LYLog(@"opertaion %@ error \n %@", operation.request, [dict objectForKey:@"msg"]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self dismissTips];
        [self presentMessageTips:@"操作失败"];
        LYLog(@"Error: %@", error);
        LYLog(@"opertaion %@ error", operation.request);
        switch (error.code) {
            case kCFURLErrorTimedOut:
            {
                ErrorRequestTimedOutEvent* timedOutEvent = [ErrorRequestTimedOutEvent instance];
                timedOutEvent.requestStr = [error.userInfo objectForKey:@"NSErrorFailingURLStringKey"];
                [self lyPostEvent:timedOutEvent];
                break;
            }
            default:
                break;
        }
    }];
}



- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}


- (void)saveCookie:(NSHTTPCookie*)cookie
{
    [[NSUserDefaults standardUserDefaults] setObject:cookie.properties forKey:@"panda cookie"];
}

- (void)loadCookie
{
    NSDictionary* cookieProperties = [[NSUserDefaults standardUserDefaults] objectForKey:@"panda cookie"];
    NSHTTPCookie* cookie = [NSHTTPCookie cookieWithProperties:cookieProperties];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
}
@end
