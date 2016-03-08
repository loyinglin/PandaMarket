//
//  AddressModel.h
//  Supermark
//
//  Created by 林伟池 on 15/8/11.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "BaseModel.h"

@interface AddressModel : BaseModel

+(instancetype) instance;

-(long)getAddressCount;

-(Address*)getAddressByIndex:(long)index;

-(void)onServerBackWithAddress:(Address*)addr;

-(void)onServerBackRemoveAddress:(long)address_id;

-(Address*)getDefaultAddress;

-(long)getDefaultSelectedId;

-(Address*)getAddressById:(long)address_id;

-(void)addAddress:(Address*)addr;

-(void)onGetAddressBack:(NSMutableArray*)arr;

-(void)clearCache;

@end
