//
//  ChangeViewController.h
//  Supermark
//
//  Created by 林伟池 on 15/8/24.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreLocation/CoreLocation.h>

@interface ChangeViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate, UIAlertViewDelegate>

@property (nonatomic , strong) IBOutlet UITableView* changeView;

@end
