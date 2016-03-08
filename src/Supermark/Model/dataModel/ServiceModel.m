//
//  ServiceModel.m
//  Supermark
//
//  Created by 林伟池 on 15/9/16.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "ServiceModel.h"
#import "ShopMessage.h"

@implementation ServiceModel
{
    NSMutableDictionary* serviceDict;
    NSArray* myServices;
}

+(instancetype) instance
{
    static id test;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        test = [[[self class] alloc] init];
    });
    return test;
}

#pragma mark - init

-(instancetype)init
{
    self = [super init];
    
    serviceDict = [NSMutableDictionary new];
    
    return self;
}

-(void)clearCache
{
    [serviceDict removeAllObjects];
}

#pragma mark - set

- (void)setServiceArr:(NSArray *)arr
{
    myServices = arr;
    
    [self lyPostEvent:[DataServiceModelEvent instance]];
}

#pragma mark - get


-(SimpleService *)getSimpleSericeByIndex:(long)index
{
    SimpleService* ret;
    
    if (index >= 0 && index < myServices.count) {
        ret = myServices[index];
    }
    
    return ret;
}

- (long)getSimpleServiceCount
{
    return myServices.count;
}

#pragma mark - update

-(void)onShopChange
{
    [self clearCache];
}

- (void)updateServiceWithAreaId:(long)areaId
{
    long myAreaId = areaId;
    if (myServices.count == 0 && myAreaId != -1) {
        [[ShopMessage instance] requestGetCommunityServerById:myAreaId];
    }
}
#pragma mark - message

@end
