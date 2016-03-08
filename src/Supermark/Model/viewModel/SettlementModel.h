//
//  SettlementModel.h
//  Supermark
//
//  Created by 林伟池 on 15/9/4.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "BaseModel.h"

@interface SettlementModel : BaseModel

+(instancetype)instance;

-(void)setMessage:(NSString*)msg;

-(NSString*)getMessage;

-(void)setShipping_type:(long)shipping_type;

-(NSNumber*)getShipping_type;

@property(nonatomic) long orderId;

@property (nonatomic , strong) NSString* myPrepayId; //weixin

@property (nonatomic, strong) NSString* myPayString; // ali

@end
