//
//  ConfireMessageCell.m
//  Supermark
//
//  Created by 林伟池 on 15/8/10.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "ConfirmMessageCell.h"

@implementation ConfirmMessageCell

#pragma mark - view init
-(void)viewInitWithMessage:(NSString *)msg
{
    if (!msg || [msg isEqualToString:@"null"]) {
        self.detail.text = @"给商家留言";
    }
    else{
        self.detail.text = msg;
    }
}

#pragma mark - ui

#pragma mark - delegate

#pragma mark - notify

@end
