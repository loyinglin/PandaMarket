//
//  ConfireAddressCell.m
//  Supermark
//
//  Created by 林伟池 on 15/8/10.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "ConfirmAddressCell.h"
#import "AddressModel.h"
#import "NSObject+LYNotification.h"

@implementation ConfirmAddressCell
{
    UIGestureRecognizer* tap;
}

#pragma mark - view init

-(void)viewInitWithAddress
{
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewSelect:)];
    [self addGestureRecognizer:tap];
    if ([[AddressModel instance] getAddressCount]) {
        [self showAddress];
    }
    else{
        [self hideAddress];
    }
}

-(void)dealloc
{
    [self removeGestureRecognizer:tap];
}

#pragma mark - ui
-(void)showAddress
{
    self.nothing.hidden = YES;

    self.userPhone.hidden = NO;
    self.userAddress.hidden = NO;
    self.phone.hidden = NO;
    self.address.hidden = NO;
    self.modify.hidden = NO;
    
    Address* addr = [[AddressModel instance] getDefaultAddress];

    if (addr) {
        self.phone.text = addr.phone;
        self.address.text = addr.address;
    }
    
}

-(void)hideAddress
{
    self.nothing.hidden = NO;
    
    self.userPhone.hidden = YES;
    self.userAddress.hidden = YES;
    self.phone.hidden = YES;
    self.address.hidden = YES;
    self.modify.hidden = YES;
}

-(void)viewSelect:(id)sender
{
    if (self.nothing.hidden == NO) {
        [self lyPostNotification:NOTIFY_OPEN_ADD_ADDRESS];
    }
    else{
        [self lyPostNotification:NOTIFY_UI_OPEN_MANAGE_ADDRESS];
    }
}
#pragma mark - delegate

#pragma mark - notify

@end
