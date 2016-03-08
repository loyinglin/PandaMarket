//
//  AddressMessage.h
//  Supermark
//
//  Created by 林伟池 on 15/8/18.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "BaseMessage.h"

@interface AddressMessage : BaseMessage

-(void)requestSaveAddressWithPhone:(NSString*)phone Address:(NSString*)addr AddressID:(long)address_id;

-(void)requestDelAddressWithId:(long)address_id;

-(void)requestAddUserAddress:(NSString*)phone Address:(NSString*)addr;

-(void)requestGetAddress;

-(void)requestSelectAddressWithPhone:(NSString*)phone Address:(NSString*)addr AddressID:(long)address_id;


@end
