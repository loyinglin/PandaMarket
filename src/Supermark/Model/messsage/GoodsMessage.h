//
//  GoodsMessage.h
//  Supermark
//
//  Created by 林伟池 on 15/8/21.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "BaseMessage.h"

@interface GoodsMessage : BaseMessage

-(void)requestGetGoodsListByIds:(NSArray*)arr;

@end
