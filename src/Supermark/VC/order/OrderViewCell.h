//
//  OrderViewCell.h
//  Supermark
//
//  Created by 林伟池 on 15/8/18.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderViewCell : UITableViewCell

@property (nonatomic , strong) IBOutlet UILabel* shop;
@property (nonatomic , strong) IBOutlet UILabel* money;
@property (nonatomic , strong) IBOutlet UILabel* time;
@property (nonatomic , strong) IBOutlet UILabel* status;

@property (nonatomic , strong) IBOutlet UIImageView* img0;
@property (nonatomic , strong) IBOutlet UIImageView* img1;
@property (nonatomic , strong) IBOutlet UIImageView* img2;
@property (nonatomic , strong) IBOutlet UIImageView* img3;
@property (nonatomic , strong) IBOutlet UIImageView* imgMore;
@property (nonatomic , strong) IBOutlet UILabel* goodsDesc;


@end
