//
//  SettlementDetailView.h
//  Supermark
//
//  Created by 林伟池 on 15/8/13.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettlementDetailView : UIView
@property (nonatomic , strong) IBOutlet UILabel* phone;
@property (nonatomic , strong) IBOutlet UILabel* address;
@property (nonatomic , strong) IBOutlet UILabel* money;
@property (nonatomic , strong) IBOutlet UILabel* ship;
@property (nonatomic , strong) IBOutlet UILabel* area;

@property (nonatomic , strong) IBOutlet UILabel* total;


-(void)viewInitWithAddress;

@end
