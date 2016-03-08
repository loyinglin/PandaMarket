//
//  ColorViewController.m
//  RevealControllerStoryboardExample
//
//  Created by Nick Hodapp on 1/9/13.
//  Copyright (c) 2013 CoDeveloper. All rights reserved.
//

#import "OrderViewController.h"
#import "SWRevealViewController.h"
#import "OrderViewCell.h"
#import "AllModel.h"
#import "AllMessage.h"
#import "OrderDetailViewController.h"
#import "BaseTableViewDataSource.h"

@interface OrderViewController ()
@property (nonatomic) IBOutlet UIBarButtonItem* revealButtonItem;
@end

@implementation OrderViewController
{
    __block long open_order_id;
    Order* myOpenOrder;
    BaseTableViewDataSource* dataSource;
}

static OrderViewController* now;

- (void)viewDidLoad
{
    now = self;
    [super viewDidLoad];
    [self customSetup];
    
    [[OrderModel instance] updateModel];
    
    [self initTable];
    
    [self lyObserveNotification:NOTIFY_ORDER_DATA_CHANGE];
}

- (void)dealloc
{
    LYLog(@"%@ dealloc", [self class]);
    [self lyRemoveAllObserveNotification];
}

- (void)customSetup
{
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.revealButtonItem setTarget: revealViewController];
        [self.revealButtonItem setAction: @selector( revealToggle: )];
        
        [self.navigationController.view addGestureRecognizer: self.revealViewController.panGestureRecognizer];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
#pragma mark - view init

- (void)initTable
{
    dataSource = [[BaseTableViewDataSource alloc] initWithItems:[[OrderModel instance] getOrderArr] Identifier:@"order"];

    [dataSource setEmptyTips:@"没有任何订单" TableView:self.ordersView];
    
    __weak __typeof(self) controller = self;
    [dataSource setSelectCallBack:^(long index, id data) {
        UIViewController* dance = controller;
        Order* order = (Order*)data;
        [controller test:order];
//        open_order_id = order.order_id.integerValue; 会产生问题。
        [dance performSegueWithIdentifier:@"open_order_detail" sender:dance];
    }];
    self.ordersView.dataSource = dataSource;
    self.ordersView.delegate = dataSource;
}

- (void)test:(Order*)order{
    open_order_id = order.order_id.integerValue;
}
#pragma mark - ui

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: @"open_order_detail"]) {
        OrderDetailViewController* controller = (OrderDetailViewController*)segue.destinationViewController;
        if (controller) {
            [controller setOrderId:open_order_id];
        }
    }
}

-(IBAction)onLeft:(id)sender{
    SWRevealViewController *revealViewController = self.revealViewController;
    if (revealViewController && [revealViewController respondsToSelector:@selector(revealToggle:)]) {
        [revealViewController performSelector:@selector(revealToggle:) withObject:nil];
    }
}

#pragma mark - PullTableViewDelegate

- (void)pullTableViewDidTriggerRefresh:(PullTableView *)pullTableView
{
//    [self performSelector:@selector(refreshTable) withObject:nil afterDelay:
    [[OrderModel instance] requestGetNewOrder];
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView
{
//    [self performSelector:@selector(loadMoreDataToTable) withObject:nil afterDelay:3.0f];
    [[OrderModel instance] requestGetMoreOrder];
}

- (void) refreshTable
{
    /*
     
     Code to actually refresh goes here.
     
     */
    [self initTable];
    [self.ordersView reloadData]; //应该紧接着 否则在下面的状态改变会有bug
    self.ordersView.pullLastRefreshDate = [NSDate date];
    self.ordersView.pullTableIsRefreshing = NO;
    self.ordersView.pullTableIsLoadingMore = NO;
}


#pragma mark - notify
-(void)lyHandleNotification:(NSNotification *)notify
{
    if ([notify.name isEqualToString:NOTIFY_ORDER_DATA_CHANGE]) {
        [self refreshTable];
    }
}


@end
