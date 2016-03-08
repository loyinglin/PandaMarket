//
//  DateModel.h
//  PandaMarket
//
//  Created by 林伟池 on 15/10/3.
//  Copyright © 2015年 林伟池. All rights reserved.
//

#import "BaseModel.h"

@interface DateModel : BaseModel

#pragma mark - init

+(instancetype)instance;


#pragma mark - set

/**
 *  设置验证码冷却时间
 *
 *  @param time 冷却秒数
 */
- (void)setNotifyCodeTime:(long)time;




#pragma mark - get
- (long)getNotifyCodeTime;


#pragma mark - update



#pragma mark - message


@end
