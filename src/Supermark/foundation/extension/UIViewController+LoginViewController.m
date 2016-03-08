//
//  UIViewController+LoginViewController.m
//  Supermark
//
//  Created by 林伟池 on 15/8/22.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "UIViewController+LoginViewController.h"

@implementation UIViewController (LoginViewController)

-(void)lyPresentLoginView
{
    UIViewController* controller = [self.storyboard instantiateViewControllerWithIdentifier:@"login_view_controller"];
    [self presentViewController:controller animated:YES completion:^{

    }];
}

@end
