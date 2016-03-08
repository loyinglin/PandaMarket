//
//  AddressMessage.m
//  Supermark
//
//  Created by 林伟池 on 15/8/18.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "AddressMessage.h"

@implementation AddressMessage
{
    long del_address_id;
}
/**
 *  增加地址
 *
 *  @param phone 地址的手机
 *  @param addr  收货地址
 */
-(void)requestAddUserAddress:(NSString*)phone Address:(NSString*)addr
{
    NSDictionary* dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                          [[UserModel instance] getUserID], @"id",
                          addr, @"address",
                          phone, @"phone",
                          nil];
    
    [self sendRequestWithPost:[msgHttpPrefix stringByAppendingString:(NSString*)msgAddUserAddress] Param:dict success:^(id responseObject) {
        NSDictionary* data = (NSDictionary*)responseObject;
        Address* addr = [data objectForClass:[Address class]];
        [[AddressModel instance] addAddress:addr];
    }];
    
}

/**
 *  删除地址
 *
 *  @param address_id 地址ID
 */
-(void)requestDelAddressWithId:(long)address_id
{
    del_address_id = address_id;
    NSDictionary* dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                          [[UserModel instance] getUserID], @"id",
                          [NSNumber numberWithLong:address_id], @"user_address_id",
                          nil];
    
    [self sendRequestWithPost:[msgHttpPrefix stringByAppendingString:(NSString*)msgDelUserAddress] Param:dict success:^(id responseObject) {
        NSNumber* data = (NSNumber*)responseObject;
        if (data) {
//            LYLog(@"del back %@", data);
        }
        
        [[AddressModel instance] onServerBackRemoveAddress:del_address_id];
    }];
}

/**
 *  获取地址
 */
-(void)requestGetAddress
{
    NSDictionary* dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                          [[UserModel instance] getUserID], @"id",
                          nil];
    
    [self sendRequestWithPost:[msgHttpPrefix stringByAppendingString:(NSString*)msgGetUserAddress] Param:dict success:^(id responseObject) {
        NSArray* addrs = (NSArray*)responseObject;
        NSMutableArray* arrs = [[NSMutableArray alloc] init];
        
        for (NSDictionary* dict in addrs) {
            if(dict){
                Address* addr = [dict objectForClass:[Address class]];
                [arrs addObject:addr];
            }
        }
        
        [[AddressModel instance] onGetAddressBack:arrs];
    }];
    
}

/**
 *  保存修改地址
 *
 *  @param phone      手机号码
 *  @param addr       收货地址
 *  @param address_id 地址Id
 */
-(void)requestSaveAddressWithPhone:(NSString*)phone Address:(NSString*)addr AddressID:(long)address_id
{
    NSDictionary* dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                          [[UserModel instance] getUserID], @"id",
                          addr, @"address",
                          phone, @"phone",
                          [NSNumber numberWithLong:address_id], @"user_address_id",
                          nil];
    
    [self sendRequestWithPost:[msgHttpPrefix stringByAppendingString:(NSString*)msgSaveUserAddress] Param:dict success:^(id responseObject) {
        NSDictionary* data = (NSDictionary*)responseObject;
        Address* addr = [data objectForClass:[Address class]];
        [[AddressModel instance] onServerBackWithAddress:addr];
        [self lyPostNotification:NOTIFY_ADDRESS_SAVE_BACK];
    }];
}

/**
 *  选中某个地址
 *
 *  @param phone      手机号码
 *  @param addr       收货地址
 *  @param address_id 地址ID
 */
-(void)requestSelectAddressWithPhone:(NSString*)phone Address:(NSString*)addr AddressID:(long)address_id
{    
    NSDictionary* dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                          [[UserModel instance] getUserID], @"id",
                          addr, @"address",
                          phone, @"phone",
                          [NSNumber numberWithLong:address_id], @"user_address_id",
                          nil];
    
    [self sendRequestWithPost:[msgHttpPrefix stringByAppendingString:(NSString*)msgSaveUserAddress] Param:dict success:^(id responseObject){
        NSDictionary* data = (NSDictionary*)responseObject;
        Address* addr = [data objectForClass:[Address class]];
        [[AddressModel instance] onServerBackWithAddress:addr];
        
        [self lyPostNotification:NOTIFY_ADDRESS_SELECTED];
    }];
}


@end
