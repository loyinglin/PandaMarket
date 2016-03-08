//
//  Alipay.m
//  Supermark
//
//  Created by 林伟池 on 15/9/28.
//  Copyright © 2015年 林伟池. All rights reserved.
//

#import "Alipay.h"
#import "NSObject+LYNotification.h"
#import "AlipayOrder.h"
#import "CartModel.h"
#import "SettlementModel.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>

@implementation Alipay

+(instancetype) instance
{
    static id test;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        test = [[[self class] alloc] init];
    });
    return test;
}


-(void)sendPay
{
    
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *partner = @"2088021590232853";
    NSString *seller = @"243906957@qq.com";
    NSString *privateKey = [self getKey];
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    AlipayOrder *order = [[AlipayOrder alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO = [NSString stringWithFormat:@"%ld", [SettlementModel instance].orderId];
    order.productName = @"购买商品"; //商品标题
    order.productDescription = @"购买商品"; //商品描述
    
    order.amount = [NSString stringWithFormat:@"%.1f", [[CartModel instance] getTotalCostInCart]]; //商品价格
    order.notifyURL =  @"http://api.mangix.cn/Home/AlipayNotify/index"; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme ,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"PandaMarket";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    //    LYLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
//        NSLog(@"%@", orderString);
//        NSLog(@"%@", [SettlementModel instance].myPayString);
        if ([orderString isEqualToString:[SettlementModel instance].myPayString]) {
            NSLog(@"yes");
        }
        [[AlipaySDK defaultService] payOrder:[SettlementModel instance].myPayString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            //            LYLog(@"reslut = %@",resultDic);
            NSString* status = [resultDic objectForKey:@"resultStatus"];
            if ([status isEqualToString:@"9000"]) {
                [self lyPostEvent:[UIPaySuccessEvent instance]];
            }
            
        }];
    }
    
}





#pragma mark -
#pragma mark   ==============产生随机订单号==============


- (NSString *)generateTradeNO
{
    long date = time(NULL);
    NSString* ret = [NSString stringWithFormat:@"%ld", date];
    return ret;
}


- (NSString *)getKey
{
    NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
    NSArray*  arr = [[NSArray alloc] initWithContentsOfFile:plistPath];
    NSString* ret = @"";
    
    for (NSString* item in arr) {
        ret = [ret stringByAppendingString:item];
    }
    
    return ret;
}

@end
