//
//  IndexTopView.m
//  Supermark
//
//  Created by 林伟池 on 15/7/29.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "IndexTopViewController.h"
#import "ShopModel.h"
#import "NSObject+LYNotification.h"
#import "NSObject+LYNotification.h"

@implementation IndexTopViewController
{
    
}

- (IBAction)onPhoneCall:(id)sender
{
    UIRequestPhoneCallEvent* event = [[UIRequestPhoneCallEvent alloc] init];
    [self lyPostEvent:event];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    Base* baseInfo = [[ShopModel instance] getCurrentMerchantBase];
    
    self.time.text = [NSString stringWithFormat:@"%@ - %@", baseInfo.working_begin, baseInfo.working_end];
    self.shipping.text = baseInfo.range_desc;
    self.shipping.text = [NSString stringWithFormat:@"(%.0f元起送)", [[ShopModel instance] getCurrentShippingPrice]];
    self.shopName.text = baseInfo.shop_name;
}

-(IBAction)onSelect:(id)sender
{
    [self lyPostNotification:[UIIndexSelectServiceEvent notifyName]];
    self.segment.selectedSegmentIndex = 0;
}

@end
