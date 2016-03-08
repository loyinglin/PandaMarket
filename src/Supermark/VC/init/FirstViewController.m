//
//  FirstViewController.m
//  Supermark
//
//  Created by 林伟池 on 15/8/27.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "FirstViewController.h"
#import "AppDelegate.h"
#import "NSObject+LYNotification.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.scroll.alwaysBounceHorizontal = YES;//横向一直可拖动
    self.scroll.pagingEnabled = YES;//关键属性，打开page模式。
    self.scroll.showsHorizontalScrollIndicator = NO;//不要显示滚动条~
    
    [self lyObserveNotification:[UISelectShopEvent notifyName]];
}

-(void)dealloc
{
    LYLog(@"%@ dealloc", [self description]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(IBAction)onClick:(id)sender
{
    UIViewController* contorller = [self.storyboard instantiateViewControllerWithIdentifier:@"ChangeViewController"];
    [self presentViewController:contorller animated:YES completion:^{
        
    }];
//    [UIView animateWithDuration:1 animations:^{
//        [[UIApplication sharedApplication] keyWindow].rootViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
//    } completion:^(BOOL finished) {
//        LYLog(@"end");
//    }];
}

#pragma mark - view init

#pragma mark - ui

#pragma mark - delegate

#pragma mark - notify
-(void)lyHandleEvent:(BaseEvent *)event
{
    if ([event isKindOfClass:[UISelectShopEvent class]]) {
        AppDelegate* delegate = [UIApplication sharedApplication].delegate;
        [delegate showSupermark];
    }
}
@end
