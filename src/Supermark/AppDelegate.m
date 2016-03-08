 //
//  AppDelegate.m
//  Supermark
//
//  Created by 林伟池 on 15/7/26.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "AppDelegate.h"
#import "payRequsestHandler.h"
#import "NotifyDefaultReceiver.h"
#import "WeixinPay.h"
#import "NSObject+LYUITipsView.h"
#import "ShopModel.h"
#import <AlipaySDK/AlipaySDK.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //weixin
    [WXApi registerApp:APP_ID withDescription:@"熊猫超市"];
    
    [NotifyDefaultReceiver instance];
    

   // [LYUITipsCenter setDefaultLoadingViewFromPlist:@"loadingView"];
    
    self.debug = true;
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"first_open"])
    {
        //不是第一次打开
        if ([[ShopModel instance] getNeedLocation]) { //没有商户id
            [self showFirstOpen];
        }
        else{
            [self showSupermark];
        }
    }
    else{
        [self showFirstOpen];
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    //如果极简开发包不可用,会跳转支付宝钱包进行支付,需要将支付宝钱包的支付结果回传给开 发包
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url
                                                  standbyCallback:^(NSDictionary *resultDic) {
                                                      //【由于在跳转支付宝客户端支付的过程中,商户 app 在后台很可能被系统 kill 了,所以 pay 接口的 callback 就会失效,请商户对 standbyCallback 返回的回调结果进行处理,就是在这个方 法里面处理跟 callback 一样的逻辑】
//                                                      LYLog(@"result = %@",resultDic);
                                                      
                                                      NSString* status = [resultDic objectForKey:@"resultStatus"];
                                                      if ([status isEqualToString:@"9000"]) {
                                                          [self lyPostEvent:[UIPaySuccessEvent instance]];
                                                      }
                                                  }];
    }
    else if ([url.host isEqualToString:@"platformapi"]){//支付宝钱包快登授权返回 authCode
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            //【由于在跳转支付宝客户端支付的过程中,商户 app 在后台很可能被系统 kill 了, 所以 pay 接口的 callback 就会失效,请商户对 standbyCallback 返回的回调结果进行处理,就 是在这个方法里面处理跟 callback 一样的逻辑】
//            LYLog(@"result = %@",resultDic);
            
            NSString* status = [resultDic objectForKey:@"resultStatus"];
            if ([status isEqualToString:@"9000"]) {
                [self lyPostEvent:[UIPaySuccessEvent instance]];
            }
        }];
    }
    else if ([url.host isEqualToString:@"pay"]) {
        [WXApi handleOpenURL:url delegate:[WeixinPay instance]];
    }
    return YES;
}

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:[WeixinPay instance]];
}




//-(BOOL) application:(UIApplication *)application shouldSaveApplicationState:(NSCoder *)coder
//{
//    return NO;
//}
//
//
//
//-(BOOL) application:(UIApplication *)application shouldRestoreApplicationState:(NSCoder *)coder
//{
//    return NO;
//}



- (void)application:(UIApplication *)application willEncodeRestorableStateWithCoder:(NSCoder *)coder
{
    
    NSDate *date = [NSDate date];
    NSTimeInterval sec = [date timeIntervalSinceNow];
    NSDate *currentDate = [[NSDate alloc] initWithTimeIntervalSinceNow:sec];
    
    //设置时间输出格式：
    NSDateFormatter *df = [[NSDateFormatter alloc] init ];
    [df setDateFormat:@"yyyy年MM月dd日 HH小时mm分ss秒"];
    NSString *na = [df stringFromDate:currentDate];
    
    [coder encodeObject:na forKey:@"lastShutdownTime"];
}



- (void)application:(UIApplication *)application didDecodeRestorableStateWithCoder:(NSCoder *)coder
{
    NSString * currentTime = [coder decodeObjectForKey:@"lastShutdownTime"];

    UIAlertView *alert = [[UIAlertView  alloc]
                          initWithTitle:@"上次关闭时间"
                          message:currentTime
                          delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil];
    [alert show];
}



- (void)showSupermark
{
    UIStoryboard* board = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    self.window.rootViewController = [board instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
}

- (void)showFirstOpen
{
    [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"first_open"];
    UIStoryboard* board = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    self.window.rootViewController = [board instantiateViewControllerWithIdentifier:@"FirstViewController"];
}
//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
//{
//    return  [WXApi handleOpenURL:url delegate:[WeixinPay instance]];
//}
//
//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
//{
//    return  [WXApi handleOpenURL:url delegate:[WeixinPay instance]];
//}



@end
