//
//  OrderDetailViewController.m
//  Supermark
//
//  Created by 林伟池 on 15/8/18.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "OrderDetailGoodsCell.h"
#import "OrderDetailHeadCell.h"
#import "OrderDetailMoneyCell.h"
#import "AllModel.h"
#import "AllMessage.h"
#import "UIConstant.h"
#import "OrderDetailShippingCell.h"
#import "ComplainViewController.h"
#import "UIConstant.h"
#import "LYTicker.h"
#import "NSObject+LYUITipsView.h"

@implementation OrderDetailViewController
{
    long order_id;
}

-(void)setOrderId:(long)order
{
    order_id = order;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self lyObserveNotification:NOTIFY_ORDER_DATA_CHANGE];
    [self lyObserveNotification:[ServerCancelUserOrderEvent notifyName]];
}
#pragma mark - view init
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.detailView reloadData];
}

-(void)viewInitFromPay
{
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backToIndex)];

    self.navigationItem.leftBarButtonItem = barButtonItem;
    
    [[OrderMessage instance] requestGetUserOrderById:order_id];
}

-(void)backToIndex
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)dealloc
{
//    LYLog(@"%@ dealloc", [self class]);
}
#pragma mark - ui

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"open_complain_board"]) {
        ComplainViewController* controller = (ComplainViewController*)segue.destinationViewController;
        if (controller) {
            [controller setOrderId:order_id];
        }
    }
}


- (IBAction)onCancelOrder:(id)sender{

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"取消订单" message:@"取消这次订单" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        [[OrderMessage callbackInstance:^{
            [[OrderMessage backgroundInstance] requestGetUserOrderById:order_id];
            [self presentMessageTips:@"取消订单成功"];
        }] requestCancelUserOrder:order_id];

        
    }];
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self getTotalCount];
}

- (long)getTotalCount
{
    
    long ret = 0;
    Order* order = [[OrderModel instance] getOrderById:order_id];
    if (order) {
        ret = order.goods_list.count + 4;
    }
    return ret;
    
}
// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *CellIdentifier;
    UITableViewCell *ret;
    Order* order = [[OrderModel instance] getOrderById:order_id];
    long money = [self getTotalCount] - 2;
    long shipping = [self getTotalCount] - 1;
    
    if (indexPath.row == 0) {
        CellIdentifier = @"head";
        OrderDetailHeadCell* cell = (OrderDetailHeadCell*)[tableView dequeueReusableCellWithIdentifier: CellIdentifier forIndexPath: indexPath];
        
        [cell viewInitWithStatus:order.status.integerValue Area:order.community_name Shop:order.shop_name Reason:order.reason PhoneCall:self];
        
        ret = cell;
    }
    else if (indexPath.row == 1){
        
        CellIdentifier = @"buy";
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier forIndexPath: indexPath];
        ret = cell;

    }
    else if (indexPath.row == money){
        
        CellIdentifier = @"money";
        OrderDetailMoneyCell* cell = (OrderDetailMoneyCell*)[tableView dequeueReusableCellWithIdentifier: CellIdentifier forIndexPath: indexPath];
        [cell viewInitWithGoodsMoney:[order getTotalMoney] PayType:order.pay_type.integerValue];
        ret = cell;
    }
    else if (indexPath.row == shipping){
        
        CellIdentifier = @"shipping";
        OrderDetailShippingCell* cell = (OrderDetailShippingCell*)[tableView dequeueReusableCellWithIdentifier: CellIdentifier forIndexPath: indexPath];
        [cell viewInitWithOrder:order];
        ret = cell;
    }
    else{
        
        CellIdentifier = @"goods";
        OrderDetailGoodsCell* cell = (OrderDetailGoodsCell*)[tableView dequeueReusableCellWithIdentifier: CellIdentifier forIndexPath: indexPath];
        
        NSArray* param = [order getParamsByIndex:indexPath.row - 2];
        if (param && param.count >= 3) {
            NSNumber* goods_id = param[0];
            NSNumber* price = param[1];
            NSNumber* count = param[2];
            [cell viewInitWithGoodsId:goods_id.integerValue Price:price.floatValue Count:count.integerValue];
        }
        else{
            [cell viewInitWithGoodsId:0 Price:0 Count:0];
        }
        
        ret = cell;
    }
    
    return ret;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat ret;
    
    long money = [self getTotalCount] - 2;
    long shipping = [self getTotalCount] - 1;
    
    if (indexPath.row == 0) {
        ret = 106;
    }
    else if (indexPath.row == 1){
        ret = 40;
        
    }
    else if (indexPath.row == money){
        ret = 50;
        
    }
    else if (indexPath.row == shipping){
        ret = 270;
    }
    else{
        ret = 50;
    }
    
    return ret;
}


- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

-(void)onPhoneCall
{
    LYLog(@"onPhoneCall");
    NSString * str=[[NSString alloc] initWithFormat:@"tel:%@", NUMBER_CUSTOMER_SERVICE];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
}

#pragma mark - pull

/* After one of the delegate methods is invoked a loading animation is started, to end it use the respective status update property */
- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView
{
    if (order_id) {
        [[OrderMessage instance] requestGetUserOrderById:order_id];
    }
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView
{
    
    if (order_id) {
        [[OrderMessage instance] requestGetUserOrderById:order_id];
    }
//    [self performSelector:@selector(refreshTable) withObject:nil afterDelay:0.5f];
}


- (void) refreshTable
{
    /*
     
     Code to actually refresh goes here.
     
     */
    self.detailView.pullLastRefreshDate = [NSDate date];
    self.detailView.pullTableIsRefreshing = NO;
    self.detailView.pullTableIsLoadingMore = NO;
    [self.detailView reloadData];
}



#pragma mark - notify
-(void)lyHandleNotification:(NSNotification *)notify
{
    if ([notify.name isEqualToString:NOTIFY_ORDER_DATA_CHANGE]) {
        [self refreshTable];
    }
}

-(void)lyHandleEvent:(BaseEvent *)event
{
}

@end
