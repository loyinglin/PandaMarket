//
//  AddressModel.m
//  Supermark
//
//  Created by 林伟池 on 15/8/11.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "AddressModel.h"
#import "NSObject+LYNotification.h"


@implementation AddressModel
{
    NSMutableArray* addrs;
}


+(instancetype) instance
{
    static AddressModel* test;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        test = [[AddressModel alloc] init];
    });
    return test;
}


-(instancetype)init
{
    self = [super init];
    
    
    addrs = [[NSMutableArray alloc] init];
    
    [self loadCache];
    
    return self;
}


- (void)loadCache
{
    NSMutableArray* arr = [[NSUserDefaults standardUserDefaults] objectForKey:[[self class] description]];
    
    for (NSData* data in arr) {
        Address* item = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        [addrs addObject:item];
    }
}

- (void)saveCache
{
    NSMutableArray *archiveArray = [NSMutableArray arrayWithCapacity:addrs.count];
    for (Address *item in addrs) {
        NSData *personEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:item];
        [archiveArray addObject:personEncodedObject];
    }
    [[NSUserDefaults standardUserDefaults] setObject:archiveArray forKey:[[self class] description]];
}

-(void)clearCache
{
    [addrs removeAllObjects];
    [self saveCache];
}


-(Address *)getAddressByIndex:(long)index
{
    Address* ret;
    if (index <= addrs.count) {
        ret = addrs[index];
    }
    return ret;
}

-(long)getAddressCount
{
    return addrs.count;
}


-(void)onServerBackWithAddress:(Address*)addr
{
    for (Address* tmp in addrs) {
        if (tmp.user_address_id == addr.user_address_id) {
            tmp.phone = addr.phone;
            tmp.address = addr.address;
            tmp.modify_time = addr.modify_time;
        }
    }
    
    [self saveCache];
}

-(void)onServerBackRemoveAddress:(long)address_id
{
    for (Address* tmp in addrs) {
        if (tmp.user_address_id.integerValue == address_id) {
            [addrs removeObject:tmp];
            break;
        }
    }
    [self saveCache];
    [self lyPostNotification:NOTIFY_ADDRESS_REMOVE_BACK];
}


-(Address*)getDefaultAddress
{
    Address* ret;
    if (addrs.count > 0) { //应该根据userModel的默认address_id来找
        ret = addrs[0];
        for (int i = 1; i < addrs.count; ++i) {
            Address* addr = addrs[i];
            if (addr.modify_time.integerValue > ret.modify_time.integerValue) {
                ret = addr;
            }
        }
    }
    return ret;
}

-(long)getDefaultSelectedId
{
    long ret = 0;
    Address* addr = [self getDefaultAddress];
    if (addr) {
        ret = addr.user_address_id.integerValue;
    }
    return ret;
}

-(Address*)getAddressById:(long)address_id
{
    Address* ret;
    for (Address* address in addrs) {
        if (address.user_address_id.integerValue == address_id) {
            ret = address;
            break;
        }
    }
    return ret;
}

-(void)addAddress:(Address *)addr
{
    [addrs addObject:addr];
    [self saveCache];
    [self lyPostNotification:NOTIFY_ADDRESS_ADD_BACK];
}

-(void)onGetAddressBack:(NSMutableArray*)arr
{
    if (arr != nil) {
        addrs = arr;
    }
    
    [self saveCache];
    [self lyPostNotification:NOTIFY_ADDRESS_DATA_CHANGE];
}


@end
