//
//  ColorViewController.h
//  RevealControllerStoryboardExample
//
//  Created by Nick Hodapp on 1/9/13.
//  Copyright (c) 2013 CoDeveloper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullTableView.h"

@interface OrderViewController : UIViewController<PullTableViewDelegate>

@property (nonatomic , strong) IBOutlet PullTableView* ordersView;

@end
