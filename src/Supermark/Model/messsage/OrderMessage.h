//
//  OrderMessage.h
//  Supermark
//
//  Created by 林伟池 on 15/8/19.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "BaseMessage.h"

@interface OrderMessage : BaseMessage

-(void)requestAddUserOrder;

-(void)requestPayUserOrder:(long)pay_type;

/**
 *  这部分只能通过model来请求，涉及到currentPage的问题，如果Controller直接请求会有问题。
 *
 *  @param page <#page description#>
 */
-(void)requestGetUserOrderList:(long)page;

-(void)requestGetUserOrderById:(long)orderId;

-(void)requestAddComplaint:(long)orderId Type:(NSString*)type Msg:(NSString*)msg;

-(void)requestCancelUserOrder:(long)orderId;

@end
