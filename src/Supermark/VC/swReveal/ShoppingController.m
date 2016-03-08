//
//  ShoppingController.m
//  Supermark
//
//  Created by 林伟池 on 15/8/10.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "ShoppingController.h"
#import "NSObject+LYNotification.h"
#import "AppDelegate.h"

@implementation ShoppingController

#pragma mark - view init

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self lyObserveNotification:NOTIFY_UI_OPEN_CONFIRM_ORDER];
    UIResponder* next = self.nextResponder;
    while (next) {
        next = next.nextResponder;
    }
}


-(void)dealloc
{
    [self lyRemoveAllObserveNotification];
//    LYLog(@"dealloc %@", [self description]);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


#pragma mark - ui

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - delegate

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}

#pragma mark - notify

-(void)lyHandleNotification:(NSNotification *)notify
{
    if ([notify.name isEqualToString:NOTIFY_UI_OPEN_CONFIRM_ORDER]) {
        if (self.navigationController.visibleViewController == self) {
            
            [self performSegueWithIdentifier:@"test_confirm_order" sender:self];

        }
    }
}



@end
