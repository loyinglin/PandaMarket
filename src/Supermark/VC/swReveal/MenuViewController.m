//
//  MenuViewController.m
//  RevealControllerStoryboardExample
//
//  Created by Nick Hodapp on 1/9/13.
//  Copyright (c) 2013 CoDeveloper. All rights reserved.
//

#import "MenuViewController.h"
#import "SWRevealViewController.h"
#import "OrderViewController.h"
#import "LoginViewController.h"
#import "AllMessage.h"
#import "AllModel.h"
#import "NSObject+LYUITipsView.h"
#import "UIViewController+LoginViewController.h"
#import "ShoppingController.h"
#import "OrderNavigationController.h"
#import "SettingNavigationController.h"


@implementation MenuViewController
{
    UITapGestureRecognizer* tap;
    UITapGestureRecognizer* labelTap;
    UIView* backView;
    UIViewController* viewController;
}

enum{
    head = 0,
    shop,
    order,
    setting,
    logout,
};


- (void) prepareForSegue: (UIStoryboardSegue *) segue sender: (id) sender
{
    // configure the destination view controller:
    if ( [sender isKindOfClass:[UITableViewCell class]] )
    {
     //   UILabel* c = [(SWUITableViewCell *)sender label];
        UINavigationController *navController = segue.destinationViewController;
        OrderViewController* cvc = [navController childViewControllers].firstObject;
        if ( [cvc isKindOfClass:[OrderViewController class]] )
        {
//            cvc.color = c.textColor;
//            cvc.text = c.text;
        }
    }
}

#pragma mask - view init

- (void)viewDidLoad
{
//    UIImageView* img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"left_bg.jpg"]];
//    img.alpha = 0.1;
//    [self.tableView setBackgroundView:img];
    [super viewDidLoad];
    [self lyObserveNotification:NOTIFY_USER_DATA_CHANGE];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];

    long row = 0;;
    UIViewController* controller = self.revealViewController.frontViewController;
    if ([controller isKindOfClass:[ShoppingController class]]) {
        row = 1;
    }
    else if([controller isKindOfClass:[OrderNavigationController class]]){
        row = 2;
    }
    else if ([controller isKindOfClass:[SettingNavigationController class]]){
        row = 3;
    }
    
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
    //    [self.tableView scrollToRowAtIndexPath:[[NSIndexPath alloc] initWithIndex:1] atScrollPosition:UITableViewScrollPositionNone animated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"setting";

    switch ( indexPath.row )
    {
        case head:
            CellIdentifier = @"head";
            break;
            
        case shop:
            CellIdentifier = @"shop";
            break;

        case order:
            CellIdentifier = @"order";
            break;
            
        case setting:
            CellIdentifier = @"setting";
            break;
            
        case logout:
            CellIdentifier = @"logout";
            break;
    }

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier forIndexPath: indexPath];
 
    if (indexPath.row == 0) {
        UILabel* label = (UILabel*)[cell viewWithTag:10];
        labelTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapLogin)];
        [label addGestureRecognizer:labelTap];
        if (label) {
            if ([[UserModel instance] isUserLogin]) {
                label.text = [[UserModel instance] getUserPhone];
            }
            else{
                label.text = @"请登陆";
            }
        }
    }
    if (indexPath.row == 1) {
//        [cell setSelected:YES animated:NO];
    }
    return cell;
}

- (void)onTapLogin
{
    if (![[UserModel instance] isUserLogin]){
        [self lyPresentLoginView];
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 46;
    if (indexPath.row == 0) {
        height = 87;
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath* ret = indexPath;
    
    if (indexPath.row == head) {
        ret = nil;
    }
    else if (indexPath.row == setting) {
        
//        if (![[UserModel instance] isUserLogin]) {
//            [self lyPresentLoginView];
//            ret = nil;
//        }
    }
    else if (indexPath.row == logout){
        [[LYUITipsCenter instance] setFailureIcon:[UIImage imageNamed:@"amap_man"]];
        [self presentMessageTips:@"logout"];
        [[LogoutMessage instance] requestLogout];
    }
    else if (indexPath.row == order){
        if (![[UserModel instance] isUserLogin]) {
            [self lyPresentLoginView];
            ret = nil;
        }
    }
    
    return ret;
}


-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark state preservation / restoration
- (void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    LYLog(@"%s", __PRETTY_FUNCTION__);
    
    // TODO save what you need here
    
    [super encodeRestorableStateWithCoder:coder];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    LYLog(@"%s", __PRETTY_FUNCTION__);
    
    // TODO restore what you need here
    
    [super decodeRestorableStateWithCoder:coder];
}

- (void)applicationFinishedRestoringState {
    LYLog(@"%s", __PRETTY_FUNCTION__);
    
    // TODO call whatever function you need to visually restore
}

-(void)lyHandleNotification:(NSNotification *)notify
{
    if ([notify.name isEqualToString:NOTIFY_USER_DATA_CHANGE]) {
        [self.tableView reloadData];
    }
}


@end
