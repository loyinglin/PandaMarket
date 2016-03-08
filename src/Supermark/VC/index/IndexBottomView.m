//
//  IndexBottomView.m
//  Supermark
//
//  Created by 林伟池 on 15/8/2.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "IndexBottomView.h"

@implementation IndexBottomView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView* view = [self viewWithTag:10];
    // 当touch point是在_btn上，则hitTest返回_btn
    CGPoint abc = [view convertPoint:point fromView:self];
    if ([view pointInside:abc withEvent:event]) {
        return [view hitTest:point withEvent:event];
    }
    
    // 否则，返回默认处理
    return nil;
    
}

@end
