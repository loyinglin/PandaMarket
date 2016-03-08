//
//  OrderNavigationController.m
//  Supermark
//
//  Created by 林伟池 on 15/8/31.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "OrderNavigationController.h"
#import "LYColor.h"

@interface OrderNavigationController ()

@end

@implementation OrderNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationBar setBarTintColor:UIColorFromRGB(LY_COLOR_RED)];
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationBar setTitleTextAttributes:[[NSDictionary alloc] initWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - view init

#pragma mark - ui

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - delegate

#pragma mark - notify


@end
