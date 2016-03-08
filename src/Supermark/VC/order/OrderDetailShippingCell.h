//
//  OrderDetailShippingCell.h
//  Supermark
//
//  Created by 林伟池 on 15/8/18.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Supermark.h"

@interface OrderDetailShippingCell : UITableViewCell

@property (nonatomic , strong) IBOutlet UILabel* order_number;
@property (nonatomic , strong) IBOutlet UILabel* order_create;
@property (nonatomic , strong) IBOutlet UILabel* merchant_response;

@property (nonatomic , strong) IBOutlet UILabel* phone;
@property (nonatomic , strong) IBOutlet UILabel* address;

@property (nonatomic , strong) IBOutlet UILabel* order_complete;

@property (nonatomic , strong) IBOutlet UIButton* cancel;

-(void)viewInitWithOrder:(Order*)order;

@end
