//
//  IndexTopCell.h
//  Supermark
//
//  Created by 林伟池 on 15/9/9.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IndexHeadCell : UITableViewCell

@property(nonatomic, strong) IBOutlet UILabel* time;

@property(nonatomic, strong) IBOutlet UILabel* shipping;

@property(nonatomic, strong) IBOutlet UILabel* shopName;

-(IBAction)onPhoneCall:(id)sender;

-(void)viewInit;

@end
