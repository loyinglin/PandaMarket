//
//  ChangeHeadView.m
//  Supermark
//
//  Created by 林伟池 on 15/8/24.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "ChangeHeadView.h"
#import "NSObject+LYNotification.h"

@implementation ChangeHeadView

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - view init

#pragma mark - ui

-(void)onClickModify:(id)sender
{
    UIModifyShopEvent* event = [[UIModifyShopEvent alloc] init];
    [self lyPostEvent:event];
}

#pragma mark - delegate

#pragma mark - notify

@end
