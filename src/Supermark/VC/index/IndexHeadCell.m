//
//  IndexTopCell.m
//  Supermark
//
//  Created by 林伟池 on 15/9/9.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "IndexHeadCell.h"
#import "AllModel.h"
#import "AllEvent.h"
@implementation IndexHeadCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark - view init

- (IBAction)onPhoneCall:(id)sender
{
    [self lyPostEvent:[UIRequestPhoneCallEvent instance]];
}

-(void)viewInit
{
    Base* baseInfo = [[ShopModel instance] getCurrentMerchantBase];
    
    self.time.text = [NSString stringWithFormat:@"%@ - %@", baseInfo.working_begin, baseInfo.working_end];
    self.shipping.text = baseInfo.range_desc;
    self.shipping.text = [NSString stringWithFormat:@"(%.0f元起送)", [[ShopModel instance] getCurrentShippingPrice]];
    self.shopName.text = baseInfo.shop_name;
}

-(IBAction)onSelect:(id)sender
{
    UIIndexSelectServiceEvent* event = [UIIndexSelectServiceEvent instance];
    event.selectedSerivce = YES;
    [self lyPostEvent:event];
}
#pragma mark - ui

#pragma mark - delegate

#pragma mark - notify


@end
