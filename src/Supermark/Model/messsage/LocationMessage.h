//
//  LocationMessage.h
//  Supermark
//
//  Created by 林伟池 on 15/9/22.
//  Copyright © 2015年 林伟池. All rights reserved.
//

#import "BaseMessage.h"

@interface LocationMessage : BaseMessage

- (void)requestGetNearMerchant:(float)lon Lat:(float)lat Num:(long)num;

@end
