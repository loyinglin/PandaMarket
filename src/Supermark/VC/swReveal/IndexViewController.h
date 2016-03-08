//
//  MapViewController.h
//  RevealControllerStoryboardExample
//
//  Created by Nick Hodapp on 1/9/13.
//  Copyright (c) 2013 CoDeveloper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+Shadow.h"

@interface IndexViewController : UIViewController<UIScrollViewDelegate, LYShadowDelegate>

@property(nonatomic, strong) IBOutlet UIScrollView* scrollView;

@property(nonatomic, strong) IBOutlet UIView* bottomView;

@property (nonatomic , strong) IBOutlet UILabel* shopName;

@property(nonatomic, strong) IBOutlet UIView* segment;


-(IBAction)unwindSegueToIndex:(UIStoryboardSegue*)sender;


-(IBAction)leftClick:(id)sender;
-(IBAction)rightClick:(id)sender;
-(IBAction)titleClick:(id)sender;

-(IBAction)itemSelected:(id)sender;
@end
