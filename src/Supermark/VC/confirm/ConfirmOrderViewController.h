//
//  ConfireOrderViewController.h
//  Supermark
//
//  Created by 林伟池 on 15/8/10.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfirmOrderViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic , strong) IBOutlet UITableView *confirmView;

@end
