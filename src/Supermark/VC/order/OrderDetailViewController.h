//
//  OrderDetailViewController.h
//  Supermark
//
//  Created by 林伟池 on 15/8/18.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullTableView.h"
#import "OrderDetailHeadCell.h"

@interface OrderDetailViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, PhoneCallDelegate, PullTableViewDelegate, UIAlertViewDelegate>

@property (nonatomic , strong) IBOutlet PullTableView* detailView;

-(void)setOrderId:(long)order;

-(void)viewInitFromPay;
@end
