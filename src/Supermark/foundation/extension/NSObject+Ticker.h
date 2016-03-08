//
//  NSObject+Ticker.h
//  Supermark
//
//  Created by 林伟池 on 15/8/24.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Ticker)

- (void)lyObserveTick;
- (void)lyUnobserveTick;
- (void)lyHandleTick:(NSTimeInterval)elapsed;

@end
