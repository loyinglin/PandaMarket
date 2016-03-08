//
//  IndexTopView.h
//  Supermark
//
//  Created by 林伟池 on 15/7/29.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IndexTopViewController : UIViewController

@property(nonatomic, strong) IBOutlet UILabel* time;

@property(nonatomic, strong) IBOutlet UILabel* shipping;

@property(nonatomic, strong) IBOutlet UILabel* shopName;

@property (nonatomic , strong) IBOutlet UISegmentedControl* segment;

-(IBAction)onPhoneCall:(id)sender;

@end
