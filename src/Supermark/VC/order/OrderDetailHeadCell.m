//
//  OrderDetailCell.m
//  Supermark
//
//  Created by 林伟池 on 15/8/18.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "OrderDetailHeadCell.h"
#import "UIConstant.h"

@implementation OrderDetailHeadCell
{
    id<PhoneCallDelegate> __weak phoneCall;
}

#pragma mark - view init
-(void)viewInitWithStatus:(long)status Area:(NSString *)area_name Shop:(NSString *)shop_name Reason:(NSString*)reason PhoneCall:(id<PhoneCallDelegate> __weak)delegate
{
    phoneCall = delegate;
    
    if (reason) {
        self.status.text = [NSString stringWithFormat:@"%@(%@)", [UIConstant getOrderStatusDesc:status], reason];
    }
    else{
        self.status.text = [UIConstant getOrderStatusDesc:status];
    }
    
    self.shop.text = shop_name;
    
    self.area.text = area_name;
}

#pragma mark - ui

-(IBAction)clickCall:(id)sender
{
    LYLog(@"click call");
    [phoneCall onPhoneCall];
}


#pragma mark - delegate

#pragma mark - notify

@end
