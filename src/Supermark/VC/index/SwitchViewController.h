//
//  SwitchViewController.h
//  Supermark
//
//  Created by 林伟池 on 15/8/24.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwitchViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic , strong) IBOutlet UITableView* shopView;
@property (nonatomic , strong) IBOutlet UIView* backView;

@end
