//
//  SettingViewController.h
//  Supermark
//
//  Created by 林伟池 on 15/8/31.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic , strong) IBOutlet UITableView* myTableView;

@end
