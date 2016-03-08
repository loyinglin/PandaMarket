//
//  SettlementViewController.h
//  Supermark
//
//  Created by 林伟池 on 15/8/13.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettlementDetailView.h"
#import "SettlementPayView.h"

@interface SettlementViewController : UIViewController

@property (nonatomic , strong) IBOutlet SettlementDetailView* detail;
@property (nonatomic , strong) IBOutlet SettlementPayView* weixin;
@property (nonatomic , strong) IBOutlet SettlementPayView* alipay;
@property (nonatomic , strong) IBOutlet SettlementPayView* cash;

@property (nonatomic , strong) IBOutlet UILabel* total;

-(IBAction)clickSubmit:(id)sender;

@end
