//
//  MapViewController.m
//  RevealControllerStoryboardExample
//
//  Created by Nick Hodapp on 1/9/13.
//  Copyright (c) 2013 CoDeveloper. All rights reserved.
//

#import "IndexViewController.h"
#import "SWRevealViewController.h"
#import "CatagoryDetailViewController.h"
#import "IndexBottomBarViewController.h"
#import "IndexTopViewController.h"
#import "CatagorySubViewController.h"
#import "UIConstant.h"
#import "ProductListViewController.h"
#import "NSObject+LYNotification.h"
#import "ShopModel.h"
#import "AllMessage.h"
#import "LYColor.h"

@interface IndexViewController ()
@property (nonatomic) IBOutlet UIBarButtonItem* revealButtonItem;
@end
@implementation IndexViewController
{
    NSMutableArray* catagorySubArray;
    NSMutableArray* catagoryDetailArray;
    IndexTopViewController* indexTopController;
    IndexBottomBarViewController* cartViewController;
    NSLayoutConstraint* test;
    
    UIView* lastLayoutView;
    NSNumber* category_id;
    
    UITapGestureRecognizer* titleTap;
    
    UIView* shadowView;
    OnShadowClose closeCallBack;
}

static IndexViewController* index_now;
- (void)viewDidLoad
{
    index_now = self;
    if ([self conformsToProtocol:@protocol(LYShadowDelegate)]) {

    }
    [super viewDidLoad];
    [self customSetup];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    titleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleClick:)];
    [self.navigationItem.titleView addGestureRecognizer:titleTap];//when to unLoad
    
    
    [[ShopMessage instance] requestGetMerchantInfo:0];//注意，此处不应该在view appear发，因为push完返回的时候会出发appear
    
    [self.navigationController.navigationBar setBarTintColor:UIColorFromRGB(LY_COLOR_RED)];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:[[NSDictionary alloc] initWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil]];
    [self setTitle:@"首页"];
    
    //这里监听在did
    [self lyObserveNotification:NOTIFY_INDEX_DATA];
    [self lyObserveNotification:NOTIFY_UI_OPEN_PRODUCT_LIST];
    [self lyObserveNotification:NOTIFY_UI_OPEN_CONFIRM_ORDER];
    [self lyObserveNotification:[UIChangeShopSelectEvent notifyName]];
    [self lyObserveNotification:[UIRequestPhoneCallEvent notifyName]];
    [self lyObserveNotification:[UIIndexSelectServiceEvent notifyName]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
//    [self lyRemoveAllObserveNotification];
}

//- (void)dealloc
//{
//    [self lyRemoveAllObserveNotification];
//}

- (void)customSetup
{
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.revealButtonItem setTarget: self.revealViewController];
        [self.revealButtonItem setAction: @selector( revealToggle: )];
//        [self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];
        [self.navigationController.view addGestureRecognizer: self.revealViewController.panGestureRecognizer];
    }
}

-(IBAction)onLeft:(id)sender{
    SWRevealViewController *revealViewController = self.revealViewController;
    if (revealViewController && [revealViewController respondsToSelector:@selector(revealToggle:)]) {
        [revealViewController performSelector:@selector(revealToggle:) withObject:nil];
    }
}

#pragma mark autolayout constraint

/**
 给 view添加和scrollview 视图一样大的约束 
 左右边界 和 元素宽
 
 */
- (void) autolayoutToScrollViewItem:(UIView*)view
{
    NSLayoutConstraint* constraint;
    
    //必不可少
    [view setTranslatesAutoresizingMaskIntoConstraints:false];
    
    
    //添加上 约束
    if(lastLayoutView)
    {
        constraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:lastLayoutView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:CONST_SPLIT_INTERVAL];
    [self.scrollView addConstraint:constraint];
        
    }
    
    
    constraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeLeading multiplier:1.0f constant:CONST_ZERO];
    [self.scrollView addConstraint:constraint];

    constraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:CONST_ZERO];
    [self.scrollView addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0f constant:CONST_ZERO];
    [self.view addConstraint:constraint];
    
    lastLayoutView = view;
}


#pragma mark state preservation / restoration

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder
{
    LYLog(@"%s", __PRETTY_FUNCTION__);
    
    // Save what you need here
    
    [super encodeRestorableStateWithCoder:coder];
}


- (void)decodeRestorableStateWithCoder:(NSCoder *)coder
{
    LYLog(@"%s", __PRETTY_FUNCTION__);
    
    // Restore what you need here
    
    [super decodeRestorableStateWithCoder:coder];
}


- (void)applicationFinishedRestoringState
{
    LYLog(@"%s", __PRETTY_FUNCTION__);
    
    // Call whatever function you need to visually restore
    [self customSetup];
}

#pragma mask - UI

-(IBAction)unwindSegueToIndex:(UIStoryboardSegue *)sender
{
    LYLog(@"unwindSegueToIndex from %@", [sender.sourceViewController description]);
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.destinationViewController isKindOfClass:[ProductListViewController class]])
    {
        ProductListViewController* controller = segue.destinationViewController;
        controller.categoryID = category_id;
    }
    if ([segue.identifier isEqualToString:@"open_change_supermark"]) {
        UIViewController* controller = segue.destinationViewController;
        controller.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//        
//        controller.providesPresentationContextTransitionStyle = YES;
//        controller.definesPresentationContext = YES;
    }
}

-(IBAction)leftClick:(id)sender
{
    LYLog(@"left click");
    
}

-(IBAction)rightClick:(id)sender
{

    LYLog(@"rightClick");
}

-(IBAction)titleClick:(id)sender
{
    LYLog(@"titleClick");
    
    UIViewController* controller = [self.storyboard instantiateViewControllerWithIdentifier:@"abc_de"];
//    controller.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//    controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:controller animated:YES completion:nil];
//    [self performSegueWithIdentifier:@"open_change_supermark" sender:self];
//    UIDatePicker *datePicker = [[UIDatePicker alloc] init]; datePicker.datePickerMode = UIDatePickerModeDate;
//    
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n\n" message:nil 　　preferredStyle:UIAlertControllerStyleActionSheet];
//    
//    [alert.view addSubview:datePicker];
//    
//    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        
//        NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
//        
//        //实例化一个NSDateFormatter对象
//        
//        [dateFormat setDateFormat:@"yyyy-MM-dd"];//设定时间格式
//        
//        NSString *dateString = [dateFormat stringFromDate:datePicker.date];
//        
//        //求出当天的时间字符串
//        
//        LYLog(@"%@",dateString);
//        
//    }];
//    
//    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//    }];
//    
//    [alert addAction:ok];
//    
//    [alert addAction:cancel];
//    
//    [self presentViewController:alert animated:YES completion:^{ }];
}

-(void)itemSelected:(id)sender
{
    [self onSelectSupermark];

}

-(void)onSelectSupermark
{
    self.scrollView.contentOffset = CGPointZero;
    self.scrollView.hidden = NO;
    self.segment.hidden = YES;
    [UIView animateWithDuration:0.5 animations:^{
        cartViewController.view.alpha = 1;
    } completion:^(BOOL finished) {
    }];
}

-(void)onSelectService
{
    self.scrollView.hidden = YES;
    self.segment.hidden = NO;
    [UIView animateWithDuration:0.5 animations:^{
        cartViewController.view.alpha = 0;
        
    } completion:^(BOOL finished) {
    }];
}

#pragma mask - delegate shadow

-(void)shadowCloseFrom:(id)sender
{
    if ([sender isKindOfClass:[UITapGestureRecognizer class]]) {
        [self lyCloseShadowWithView:shadowView OnShadowClose:closeCallBack];
    }else{
        [self lyCloseShadowWithView:shadowView OnShadowClose:nil];
    }
}

-(void)setShadowWithView:(UIView*)view OnshadowClose:(OnShadowClose)onClose
{
    closeCallBack = onClose;
    shadowView = [self lySetShadowWithView:view];
}

#pragma mask - notify

- (void)onNotifyIndexData
{
    NSLayoutConstraint* constraint;
    
    lastLayoutView = nil;
    
    catagorySubArray = [[NSMutableArray alloc] init];
    catagoryDetailArray = [[NSMutableArray alloc] init];
    
//    [self setTitle:[ShopModel instance].merchant.base.address];
    [self.shopName setText: [[ShopModel instance] getCurrentMerchantBase].shop_name];
    /************    scrollView 布局  start **********/
    
//    LYLog(@"%@\n%@", [self.scrollView.constraints description], [self.childViewControllers description]);
//    [self.scrollView removeConstraints:self.scrollView.constraints];
//    while (self.childViewControllers.count > 0) {
//        UIViewController* controller = self.childViewControllers[0];
//        [controller removeFromParentViewController];
//        [controller.view removeFromSuperview];
//    }
    
    if(self.scrollView.constraints.count > 100)
    {
        NSException *e = [NSException exceptionWithName: @"约束异常" reason: @"The level is above 100"userInfo: nil];
        @throw e;
    }
    
    indexTopController = [[IndexTopViewController alloc] initWithNibName:[[IndexTopViewController class] description] bundle:nil];
    [self addChildViewController:indexTopController];
    [self.scrollView addSubview:indexTopController.view];
    [self autolayoutToScrollViewItem:indexTopController.view];
    
    constraint = [NSLayoutConstraint constraintWithItem:indexTopController.view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:indexTopController.view.superview attribute:NSLayoutAttributeTop multiplier:1.0f constant:CONST_ZERO];
    [self.scrollView addConstraint:constraint];
    
    long count = [[ShopModel instance] getCurrentCategoryCount];
    
    //主分类 名字
    for (int i = 0; i < (count + 1) / 2; ++i) {
        CatagorySubViewController* controller = [[CatagorySubViewController alloc] initWithNibName:[[CatagorySubViewController class] description] bundle:nil];
        controller.indexOfView = i;
        [self addChildViewController:controller];
        [self.scrollView addSubview:controller.view];
        [catagorySubArray addObject:controller];
        [self autolayoutToScrollViewItem:controller.view];
    }
    
    //主分类 详情
    for (int i = 0; i < count; ++i) {
        CatagoryDetailViewController* controller;
        if ([[ShopModel instance] getGoodsCountByIndex:i] < 3) {
           controller = [[CatagoryDetailViewController alloc] initWithNibName: @"CategoryDetailView" bundle:nil];
        }
        else{
            controller = [[CatagoryDetailViewController alloc] initWithNibName:[[CatagoryDetailViewController class] description] bundle:nil];
        }
        
        [self addChildViewController:controller];
        [self.scrollView addSubview:controller.view];
        [controller viewInitByIndex:i]; //必须先加载
        [catagoryDetailArray addObject:controller];
        [self autolayoutToScrollViewItem:controller.view];
    }
    
    constraint = [NSLayoutConstraint constraintWithItem:lastLayoutView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:CONST_ZERO];
    [self.scrollView addConstraint:constraint];
    /************    scrollView 布局  end **********/
    
    
    
    /************    bottomView 布局  start **********/
    NSString* nibName = [[IndexBottomBarViewController class] description];
    cartViewController = [[IndexBottomBarViewController alloc] initWithNibName:nibName bundle:nil];
    cartViewController.controller = self;
    [self addChildViewController:cartViewController];
    [self.view addSubview:cartViewController.view];

    [cartViewController.view setTranslatesAutoresizingMaskIntoConstraints:false];
    
    constraint = [NSLayoutConstraint constraintWithItem:cartViewController.view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:cartViewController.view.superview attribute:NSLayoutAttributeBottom multiplier:1.0f constant:CONST_ZERO];
    [cartViewController.view.superview addConstraint:constraint];
    
    
    constraint = [NSLayoutConstraint constraintWithItem:cartViewController.view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:cartViewController.view.superview attribute:NSLayoutAttributeLeading multiplier:1.0f constant:CONST_ZERO];
    [cartViewController.view.superview addConstraint:constraint];
    
    
    constraint = [NSLayoutConstraint constraintWithItem:cartViewController.view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:cartViewController.view.superview attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:CONST_ZERO];
    [cartViewController.view.superview addConstraint:constraint];
    
    
    constraint = [NSLayoutConstraint constraintWithItem:cartViewController.view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:CONST_HIDE_CART_HEIGHT];
    [constraint setIdentifier:@"height"];
    [cartViewController.view addConstraint:constraint];
    
    [self.view setNeedsDisplay];
    [self.view setNeedsLayout];
    //    LYLog(@"%@", [INDEX_NOTIFY_DATA description]);
    // bottom 的布局只用了宽度约束，其他用 autoResize 的 RM + BM
    /************    bottomView 布局  end **********/
}


- (void)lyHandleNotification:(NSNotification *)notify
{
    if ([notify.name isEqualToString: NOTIFY_UI_OPEN_PRODUCT_LIST]) {
        category_id = [notify.userInfo objectForKey:@"category_id"];
        [self performSegueWithIdentifier:@"open_product_list" sender:self];
    }
    else if ([notify.name isEqualToString:NOTIFY_UI_OPEN_CONFIRM_ORDER])
    {
        [self performSegueWithIdentifier:@"open_confirm_order" sender:self];
    }
    else if ([notify.name isEqualToString:NOTIFY_INDEX_DATA]) {
        [self onNotifyIndexData];
    }
}

-(void)lyHandleEvent:(BaseEvent *)event
{
    if ([event isKindOfClass:[UIChangeShopSelectEvent class]]) {
        [self performSegueWithIdentifier:@"open_change_handle" sender:self];
    }
    if ([event isKindOfClass:[UIRequestPhoneCallEvent class]]) {
        
        NSString * str=[[NSString alloc] initWithFormat:@"tel:%@", NUMBER_CUSTOMER_SERVICE];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [self.view addSubview:callWebview];
    }
    if ([event isKindOfClass:[UIIndexSelectServiceEvent class]]) {
        [self onSelectService];
    }
}
@end
