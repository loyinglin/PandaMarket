//
//  SettlementPayView.m
//  Supermark
//
//  Created by 林伟池 on 15/8/13.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "SettlementPayView.h"

@implementation SettlementPayView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - view init

#pragma mark - ui

-(void)unChoose
{
    [self.select setBackgroundImage:[UIImage imageNamed:@"settlement_empty"] forState:UIControlStateNormal];
}


-(void)setChoose
{
    [self.select setBackgroundImage:[UIImage imageNamed:@"settlement_choose"] forState:UIControlStateNormal];
}
#pragma mark - delegate

#pragma mark - notify


@end
