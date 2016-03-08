//
//  UIViewController+Shadow.m
//  Supermark
//
//  Created by 林伟池 on 15/8/29.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "UIViewController+Shadow.h"

@implementation UIViewController (Shadow)

-(UIView*)lySetShadowWithView:(UIView*)view
{
    UIView* backView;
    backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    backView.backgroundColor = [UIColor blackColor];
    backView.alpha = 0.5;
    [self.view addSubview:backView];
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shadowCloseFrom:)];
    [backView addGestureRecognizer:tap];
    if ([self.view.subviews containsObject:view]) {
        
        [self.view bringSubviewToFront:view];
        
    }
    return backView;
}

-(void)lyCloseShadowWithView:(UIView*)view OnShadowClose:(OnShadowClose)onClose
{
    if (view) {
        [view removeFromSuperview];
    }
    if (onClose) {
        onClose();
    }
}
@end
