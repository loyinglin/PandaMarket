//
//  ConfireOrderViewController.m
//  Supermark
//
//  Created by 林伟池 on 15/8/10.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "ConfirmOrderViewController.h"
#import "ConfirmAddressCell.h"
#import "ConfirmGoodsCell.h"
#import "ConfirmMessageCell.h"
#import "NSObject+LYNotification.h"
#import "NSObject+LYUITipsView.h"
#import "UIViewController+LoginViewController.h"

#import "AddressModel.h"
#import "AllModel.h"
#import "AllMessage.h"
#import "AddressManageViewController.h"
#import "AddressAddViewController.h"
#import "SettlementViewController.h"

@implementation ConfirmOrderViewController
{
    long open_address_id;
}
#pragma mark - view init

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self lyObserveNotification:NOTIFY_CART_DATA_CHANGE];
    [self lyObserveNotification:NOTIFY_OPEN_ADD_ADDRESS];
    [self lyObserveNotification:NOTIFY_UI_OPEN_MANAGE_ADDRESS];

    [self lyObserveNotification:NOTIFY_UI_OPEN_SETTLEMENT_BOARD];
    [self lyObserveNotification:NOTIFY_ADDRESS_DATA_CHANGE];
    
    [self lyObserveNotification:[UIMessageConfirmEvent notifyName]];
    [self lyObserveNotification:[ServerAddUserOrderEvent notifyName]];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.confirmView reloadData];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[CartModel instance] clearEmptyGoods];
}

-(void)dealloc
{
    [self lyRemoveAllObserveNotification];
}

#pragma mark - ui

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"confirm_order_to_add_address"]) {
        AddressAddViewController* controller = (AddressAddViewController*)segue.destinationViewController;
        if (controller) {
            controller.address_id = open_address_id; //保存或者修改
        }
    }
    if ([segue.identifier isEqualToString:@"open_manage_address"]) {
        AddressManageViewController* controller = (AddressManageViewController*)segue.destinationViewController;
    }
    if ([segue.identifier isEqualToString:@"open_settlement_board"]) {
        SettlementViewController* controller = (SettlementViewController*)segue.destinationViewController;
    }
}

#pragma mark - delegate

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < 2) {
        return YES;
    }
    else{
        return NO;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[CartModel instance] getCartCount] + 2;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier;
    UITableViewCell *ret;
    
    switch ( indexPath.row )
    {
        case 0:
        {
            CellIdentifier = @"address";
            ConfirmAddressCell* cell = (ConfirmAddressCell*)[tableView dequeueReusableCellWithIdentifier: CellIdentifier forIndexPath: indexPath];
            
            [cell viewInitWithAddress]; //是默认
            ret = cell;
            break;
        }
            
        case 1:
        {
            CellIdentifier = @"message";
            ConfirmMessageCell* cell = (ConfirmMessageCell*)[tableView dequeueReusableCellWithIdentifier: CellIdentifier forIndexPath: indexPath];
            [cell viewInitWithMessage:[[SettlementModel instance] getMessage]];
            ret = cell;
            break;
        }
        case 2:
        default:
        {
            CellIdentifier = @"cell";
            ConfirmGoodsCell* cell = (ConfirmGoodsCell*)[tableView dequeueReusableCellWithIdentifier: CellIdentifier forIndexPath: indexPath];
            [cell initViewWithIndex:(int)indexPath.row - 2];
            ret = cell;
        }
    }
    
    return ret;
}

- (NSIndexPath*)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        [self performSegueWithIdentifier:@"open_meesage_board" sender:self];
    }
    
    return indexPath;
}

#pragma mark - notify

-(void)lyHandleNotification:(NSNotification *)notify
{
    if ([notify.name isEqualToString:NOTIFY_CART_DATA_CHANGE]) {
        [self.confirmView reloadData];
    }
    else if ([notify.name isEqualToString:NOTIFY_OPEN_ADD_ADDRESS])
    {
        if ([[UserModel instance] isUserLogin]) {
            NSDictionary* dict = notify.userInfo;
            NSNumber* num = [dict objectForKey:@"data"];
            if (num) {
                open_address_id = num.integerValue;
            }
            else{
                open_address_id = 0;
            }
            [self performSegueWithIdentifier:@"confirm_order_to_add_address" sender:self];
        }
        else{
            [self lyPresentLoginView];
        }
    }
    else if ([notify.name isEqualToString:NOTIFY_UI_OPEN_MANAGE_ADDRESS])
    {
        [self performSegueWithIdentifier:@"open_manage_address" sender:self];
    }
    else if ([notify.name isEqualToString:NOTIFY_UI_OPEN_SETTLEMENT_BOARD]){
        if (![[AddressModel instance] getDefaultAddress]) {
            [self presentMessageTips:@"请选择收货地址"];
        }
        else{
            if ([[UserModel instance] isUserLogin]) {
                [[OrderMessage instance] requestAddUserOrder]; //添加订单
                [self presentLoadingTips:@"结算中"];
            }
            else{
                [self lyPresentLoginView];
            }
        }
    }
    else if ([notify.name isEqualToString:NOTIFY_ADDRESS_DATA_CHANGE])
    {
        [self.confirmView reloadData];
    }
}

-(void)lyHandleEvent:(BaseEvent *)event
{
    if ([event isKindOfClass:[UIMessageConfirmEvent class]]) {
        UIMessageConfirmEvent* messageEvent = (UIMessageConfirmEvent*)event;
        [[SettlementModel instance] setMessage:messageEvent.message];
        [self.confirmView reloadData];
    }
    else if ([event isKindOfClass:[ServerAddUserOrderEvent class]]){
        ServerAddUserOrderEvent* addUserOrderEvent = (ServerAddUserOrderEvent*)event;
        [self dismissTips];
        if (addUserOrderEvent.success) {
            [SettlementModel instance].orderId = addUserOrderEvent.orderId;
            [self performSegueWithIdentifier:@"open_settlement_board" sender:self];
        }
        else{
            [self presentMessageTips:@"结算失败"];
        }
    }
}

@end
