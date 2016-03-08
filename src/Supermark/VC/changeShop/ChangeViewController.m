//
//  ChangeViewController.m
//  Supermark
//
//  Created by 林伟池 on 15/8/24.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "ChangeViewController.h"
#import "NSObject+LYNotification.h"
#import "NSObject+LYUITipsView.h"
#import "ShopModel.h"
#import "LocationModel.h"
#import "LocationMessage.h"
#import "ChangeViewCell.h"
@interface ChangeViewController ()

@end

@implementation ChangeViewController
{
    CLLocationManager* locationManager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.changeView setTableHeaderView:[self viewForHeaderInSection]];
    
  

    [self lyObserveNotification:[UIModifyShopEvent notifyName]];
    [self lyObserveNotification:[DataLocationModelEvent notifyName]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [self lyRemoveAllObserveNotification];
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


- (void)needLocation
{
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse) {
        //有权限
        [self startLocation];
    }
    else{
        if ([[ShopModel instance] getAlertAble]) { //首次打开有提示
            [self showAlert];
        }
    }
}


-(void)startLocation
{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = 1000.0f;
    [locationManager startUpdatingLocation];
    [self presentLoadingTips:@"定位中"];
}


- (void)showAlert
{
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"权限获取" message:@"是否通过定位获取最近的小区" delegate:self cancelButtonTitle:@"不需要" otherButtonTitles:@"好的", nil];
    [alertView show];
}

#pragma mark - delegate UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1){
        locationManager = [CLLocationManager new];
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.distanceFilter = 1000.0f;
        [locationManager requestWhenInUseAuthorization];
        [locationManager startUpdatingLocation];
    }
}


#pragma mark - CLLocationManagerDelegate

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    LYLog(@"%@ %@", [NSString stringWithFormat:@"%3.5f",newLocation.coordinate.latitude], [NSString stringWithFormat:@"%3.5f",newLocation.coordinate.longitude]);
    [locationManager stopUpdatingLocation];
    [self dismissTips];
    [[LocationMessage instance] requestGetNearMerchant:newLocation.coordinate.longitude Lat:newLocation.coordinate.latitude Num:3];
    LYLog(@"location ok");
}

#pragma mark - delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[LocationModel instance] getArrShopCount];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChangeViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"detail" forIndexPath:indexPath];
    ShopLocation* shop = [[LocationModel instance] getShopLocationByIndex:indexPath.row];
    [cell viewInitWithName:shop.name Detail:shop.address Distance:shop.dis.floatValue];
    
    return cell;
}

- (UIView *)viewForHeaderInSection
{
    
    UITableViewCell* cell = [self.changeView dequeueReusableCellWithIdentifier:@"head"];
    
    return cell;
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopLocation* shop = [[LocationModel instance] getShopLocationByIndex:indexPath.row];
    if (shop) {
        [[ShopModel instance] setDefaultIdAndRquest:shop.merchant_id.integerValue Area:shop._id.integerValue Update:![[ShopModel instance] getNeedLocation]]; //需要定位情况，只在第一次打开app，那时候不需要拉取信息
        
        UISelectShopEvent* event = [UISelectShopEvent instance];
        [self lyPostEvent:event];
        if (self.navigationController) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        else{
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        

    }
    return nil;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    
//    UITableViewCell* cell = [self.changeView dequeueReusableCellWithIdentifier:@"head"];
//    
//    
//    return cell;
//}

#pragma mark - notify
-(void)lyHandleEvent:(BaseEvent *)event
{
    if ([event isKindOfClass:[UIModifyShopEvent class]]) {
        [self needLocation];
//        [self performSegueWithIdentifier:@"open_choose_shop_address" sender:self];
    }
    if ([event isKindOfClass:[DataLocationModelEvent class]]) {
        [self.changeView reloadData];
    }
}
@end
