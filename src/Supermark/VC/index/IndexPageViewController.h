//
//  IndexPageViewController.h
//  Supermark
//
//  Created by 林伟池 on 15/9/8.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+Shadow.h"

@interface IndexPageViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, LYShadowDelegate, UIAlertViewDelegate>

@property(nonatomic, strong) IBOutlet UITableView* myIndexView;

@property(nonatomic, strong) IBOutlet UIView* bottomView;

@property (nonatomic , strong) IBOutlet UILabel* shopName;

@property (nonatomic , strong) IBOutlet UITableView* myServiceView;

@property (nonatomic , strong) NSArray<UIImage *>* imageArr;


-(IBAction)rightClick:(id)sender;
@end
