//
//  ChooseShopAddressViewController.m
//  Supermark
//
//  Created by 林伟池 on 15/8/24.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "ChooseShopAddressViewController.h"

@interface ChooseShopAddressViewController ()

@end

@implementation ChooseShopAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

-(BOOL)prefersStatusBarHidden{
    return YES;
}

#pragma mark - ui

-(void)onClickSure:(id)sender
{
    LYLog(@"onClickSure");
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - delegate

#pragma mark - notify


@end
