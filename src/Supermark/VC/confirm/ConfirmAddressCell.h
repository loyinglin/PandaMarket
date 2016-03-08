//
//  ConfireAddressCell.h
//  Supermark
//
//  Created by 林伟池 on 15/8/10.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfirmAddressCell : UITableViewCell

@property (nonatomic , strong) IBOutlet UILabel* userPhone;
@property (nonatomic , strong) IBOutlet UILabel* userAddress;
@property (nonatomic , strong) IBOutlet UILabel* phone;
@property (nonatomic , strong) IBOutlet UILabel* address;
@property (nonatomic , strong) IBOutlet UILabel* modify;
@property (nonatomic , strong) IBOutlet UILabel* nothing;


-(void)viewInitWithAddress;

@end
