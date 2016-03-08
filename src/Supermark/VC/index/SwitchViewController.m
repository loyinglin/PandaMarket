//
//  SwitchViewController.m
//  Supermark
//
//  Created by 林伟池 on 15/8/24.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "SwitchViewController.h"
#import "SwitchViewCell.h"
#import "RecentShopModel.h"
#import "NSObject+LYNotification.h"

@interface SwitchViewController ()
{
    UITapGestureRecognizer* tap;
}

@end

@implementation SwitchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onBackClick:)];
    [self.backView addGestureRecognizer:tap];

    self.shopView.backgroundColor = [UIColor clearColor];
    
    for (NSLayoutConstraint* constraint in self.shopView.constraints) {
        if ([constraint.identifier isEqualToString:@"height"]) {
            constraint.constant = [self getCount] * self.shopView.rowHeight;
        }
    }
//    [self.view addSubview:img];
//    [self.view bringSubviewToFront:img];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [self.backView removeGestureRecognizer:tap];
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

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


#pragma mark - ui

-(void)onBackClick:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self getCount];
}

- (long)getCount
{
    return [[RecentShopModel instance] getRecentShopInfoCount] + 1;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* str;
    if (indexPath.row + 1 == [self getCount]) {
        str = @"change";
    }
    else if (indexPath.row == 0) {
        str = @"current";
    }
    else{
        str = @"other";
    }
    SwitchViewCell* cell = [tableView dequeueReusableCellWithIdentifier:str forIndexPath:indexPath];
    [cell viewInitIndex:indexPath.row];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIChangeShopSelectEvent* event = [[UIChangeShopSelectEvent alloc] init];
    if (indexPath.row + 1 == [self getCount]) {
        event.merchantId = -1;
    }
    else{
        event.merchantId = [[RecentShopModel instance] getSimpleShopInfoByIndex:indexPath.row].merchant_id.integerValue;
        event.areaId = [[RecentShopModel instance] getSimpleShopInfoByIndex:indexPath.row]._id.integerValue;
    }
    [self lyPostEvent:event];
}


#pragma mark - notify


@end
