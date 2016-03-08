//
//  OrderDetailMoneyCell.h
//  Supermark
//
//  Created by 林伟池 on 15/8/18.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailMoneyCell : UITableViewCell

@property (nonatomic , strong) IBOutlet UILabel*    pay_type;
@property (nonatomic , strong) IBOutlet UILabel*    total;

-(void)viewInitWithGoodsMoney:(float)money PayType:(long)payType;

@end
