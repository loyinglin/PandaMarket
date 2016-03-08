//
//  AddressManageCell.m
//  Supermark
//
//  Created by 林伟池 on 15/8/12.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "AddressManageCell.h"
#import "AddressModel.h"
#import "NSObject+LYNotification.h"

@implementation AddressManageCell
{
    long address_id;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - view init
-(void)viewInitWithIndex:(long)index
{
    self.indexOfView = index;
    
    Address* addr = [[AddressModel instance] getAddressByIndex:index];
    self.addr.text = addr.address;
    self.phone.text = addr.phone;
    address_id = addr.user_address_id.integerValue;
    if (address_id != [[AddressModel instance] getDefaultSelectedId]) {
        
        [self.select setBackgroundImage:[UIImage imageNamed:@"settlement_empty"] forState:UIControlStateNormal];
    }
    else{
        [self.select setBackgroundImage:[UIImage imageNamed:@"settlement_choose"] forState:UIControlStateNormal];
    }
}


#pragma mark - ui
-(IBAction)clickModify:(id)sender
{
    [self lyPostNotificationWithSender:NOTIFY_OPEN_ADD_ADDRESS withData:[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithLong:address_id], @"data", nil]];
}

#pragma mark - delegate

#pragma mark - notify


@end
