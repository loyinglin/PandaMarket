//
//  FeedbackMessage.m
//  Supermark
//
//  Created by 林伟池 on 15/9/14.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "FeedbackMessage.h"

@implementation FeedbackMessage

-(void)requestAddFeedback:(NSString *)msg
{    
    NSMutableDictionary* param = [[NSMutableDictionary alloc] init];
    [param setObject:msg forKey:@"msg"];

    [self sendRequestWithPost:[msgHttpPrefix stringByAppendingFormat:@"%@", msgAddFeedback] Param:param success:^(id responseObject) {
        ServerAddFeedbackEvent* event = [ServerAddFeedbackEvent instance];
        [self lyPostEvent:event];
    }];
    
}

@end
