//
//  AddressManageViewController.m
//  Supermark
//
//  Created by 林伟池 on 15/8/12.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "AddressManageViewController.h"
#import "AddressManageCell.h"
#import "NSObject+LYNotification.h"
#import "AddressModel.h"
#import "AllMessage.h"

@interface AddressManageViewController ()

@end

@implementation AddressManageViewController
{
    long address_id;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self lyObserveNotification:NOTIFY_ADDRESS_SELECTED];
    [self lyObserveNotification:NOTIFY_ADDRESS_DATA_CHANGE];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [self lyRemoveAllObserveNotification];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - view init

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.addressView reloadData];
}

#pragma mark - ui

#pragma mark - delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[AddressModel instance] getAddressCount] + 1;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier;
    UITableViewCell *ret;
    
    if (indexPath.row < [[AddressModel instance] getAddressCount]) {
        cellIdentifier = @"address";
        AddressManageCell* cell = (AddressManageCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        [cell viewInitWithIndex:indexPath.row];
        ret = cell;
    }
    else{
        cellIdentifier = @"addAddress";
        ret = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    }
    
    return ret;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat ret = 70;
    
    return ret;
}


- (NSIndexPath*)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < [[AddressModel instance] getAddressCount]) {
        Address* addr = [[AddressModel instance] getAddressByIndex:indexPath.row];
        
        [[AddressMessage instance] requestSelectAddressWithPhone:addr.phone Address:addr.address AddressID:addr.user_address_id.integerValue];
    }
    else{
        [self lyPostNotificationWithSender:NOTIFY_OPEN_ADD_ADDRESS withData:[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithLong:0], @"data", nil]];
    }
    
    return indexPath;
}

#pragma mark - notify
-(void)lyHandleNotification:(NSNotification *)notify
{
    if ([notify.name isEqualToString:NOTIFY_ADDRESS_SELECTED]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if([notify.name isEqualToString:NOTIFY_ADDRESS_DATA_CHANGE])
    {
        [self.addressView reloadData];
    }
}

@end
