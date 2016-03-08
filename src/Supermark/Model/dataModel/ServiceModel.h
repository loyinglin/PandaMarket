//
//  ServiceModel.h
//  Supermark
//
//  Created by 林伟池 on 15/9/16.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "BaseModel.h"

@interface ServiceModel : BaseModel

+(instancetype)instance;



#pragma mark - init


#pragma mark - set

- (void)setServiceArr:(NSArray*)arr;


#pragma mark - get

-(SimpleService*)getSimpleSericeByIndex:(long)index;

- (long)getSimpleServiceCount;

#pragma mark - update

- (void)onShopChange;

- (void)updateServiceWithAreaId:(long)areaId;

#pragma mark - message

@end
