//
//  SettlementViewController.m
//  Supermark
//
//  Created by 林伟池 on 15/8/13.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "SettlementViewController.h"
#import "AllMessage.h"
#import "NSObject+LYUITipsView.h"
#import "NSObject+Ticker.h"
#import "OrderDetailViewController.h"
#import "Alipay.h"
#import "WeixinPay.h"

@interface SettlementViewController ()
{
    SettlementPayView* chooseView;
    
    NSArray* arr;
    
    NSMutableArray* taps;
}
@end

@implementation SettlementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    arr = [[NSArray alloc] initWithObjects:self.cash, self.alipay, self.weixin, nil];
    taps = [[NSMutableArray alloc] init];
    for (UIView* view in arr) {
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapView:)];
        [view addGestureRecognizer:tap];
        [taps addObject:tap];
    }
    
    [self lyObserveEvent:[ServerPayUserOrderEvent instance]];
    [self lyObserveEvent:[UIPaySuccessEvent instance]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    for (int i = 0; i < arr.count; i++) {
        UITapGestureRecognizer* tap = taps[i];
        UIView* view = arr[i];
        [view removeGestureRecognizer:tap];
    }
    
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
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.detail viewInitWithAddress];
    [self choose:arr[0]];
    self.total.text = [NSString stringWithFormat:@"￥%.2f", [[CartModel instance] getTotalCostInCart]];

}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: @"open_order_detail_from_pay"]) {
        OrderDetailViewController* controller = (OrderDetailViewController*)segue.destinationViewController;
        if (controller) {
            
            UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
            self.navigationItem.backBarButtonItem = barButtonItem;
            
            [controller setOrderId:[SettlementModel instance].orderId];
            [controller viewInitFromPay];
        }
    }
}
#pragma mark - ui

-(void)unChooseAll
{
    for (SettlementPayView* view in arr) {
        [view unChoose];
    }
}

-(void)choose:(SettlementPayView*)payView
{
    chooseView = payView;
    [self unChooseAll];
    [payView setChoose];
}

-(void)onTapView:(UITapGestureRecognizer*)tap
{
    [self choose:(SettlementPayView*)tap.view];
}

-(IBAction)clickSubmit:(id)sender
{
    //0 货到付款, 1 微信支付, 2 支付宝

    if (chooseView == self.alipay) {
        [[OrderMessage instance] requestPayUserOrder:PAY_TYPE_ALIPAY];
//        [[Alipay instance] sendPay];
    }
    else if (chooseView == self.weixin){
//        [[WeixinPay instance] sendPay];
        [[OrderMessage instance] requestPayUserOrder:PAY_TYPE_WEIXIN];
    }
    else{
        //    [[WeixinPay instance] sendPay];
        [self presentLoadingTips:@"提交订单中"];
        [[OrderMessage instance] requestPayUserOrder:PAY_TYPE_CASH];
    }
    
}
#pragma mark - delegate

-(void)lyHandleTick:(NSTimeInterval)elapsed
{
    LYLog(@"%lf", elapsed);
}

#pragma mark - notify

-(void)lyHandleEvent:(BaseEvent *)event
{
    if ([event isKindOfClass:[ServerPayUserOrderEvent class]]) {
        ServerPayUserOrderEvent* payEvent = (ServerPayUserOrderEvent*)event;
        [self dismissTips];
        if (payEvent.success && payEvent.myPayType == PAY_TYPE_CASH) {
            [self onPaySuccess];
        }
        if (payEvent.success && payEvent.myPayType == PAY_TYPE_WEIXIN) {
            [[WeixinPay instance] sendPay];
        }
        if (payEvent.success && payEvent.myPayType == PAY_TYPE_ALIPAY) {
            [[Alipay instance] sendPay];
        }
    }
    else if ([event isKindOfClass:[UIPaySuccessEvent class]]){
        [self onPaySuccess];
    }
}

- (void)onPaySuccess
{
    [[CartModel instance] clearCache];
    [self performSegueWithIdentifier:@"open_order_detail_from_pay" sender:self];
}
@end
