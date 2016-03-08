//
//  IndexPageViewController.m
//  Supermark
//
//  Created by 林伟池 on 15/9/8.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "IndexPageViewController.h"
#import "SWRevealViewController.h"
#import "ProductListViewController.h"
#import "ServiceViewController.h"
//#import "ChangeViewController.h"
#import "GoodsDetailController.h"
#import "IndexBottomBarViewController.h"
#import "IndexHeadCell.h"
#import "IndexCategoryCell.h"
#import "IndexDetailSixCell.h"
#import "ServiceDetailCell.h"
#import "ServiceHeadCell.h"
#import "AllModel.h"
#import "AllMessage.h"
#import "LYColor.h"
#import "UIConstant.h"

@interface IndexPageViewController ()

@property (nonatomic) IBOutlet UIBarButtonItem* revealButtonItem;
@end

@implementation IndexPageViewController
{
    
    NSNumber* category_id;
    
    UITapGestureRecognizer* titleTap;
    
    IndexBottomBarViewController* cartViewController;
    
    UIView* shadowView;
    OnShadowClose closeCallBack;
    
    long myServiceIndex;
    
    DetailGoods* myGoods;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customSetup];

    
    titleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleClick:)];
    [self.shopName addGestureRecognizer:titleTap];//when to unLoad
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onLeft:)];
    [self.navigationItem.leftBarButtonItem.customView addGestureRecognizer:tap];
    
    /************    bottomView 布局  start **********/
    cartViewController = [[IndexBottomBarViewController alloc] initWithNibName:[[IndexBottomBarViewController class] description] bundle:nil];
    [self addChildViewController:cartViewController];
    [self.view addSubview:cartViewController.view];
    cartViewController.controller = self;
    [cartViewController initConstraint];
    /************    bottomView 布局  end **********/

    [[ShopModel instance] updateMerchantInfo];
    
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
    [self lyObserveNotification:[UIOpenServiceDetailBoardEvent notifyName]];
    [self lyObserveNotification:[DataServiceModelEvent notifyName]];
    [self lyObserveNotification:[UIPressGoodsViewEvent notifyName]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - view init
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
-(void)titleClick:(id)sender
{
    UIViewController* controller = [self.storyboard instantiateViewControllerWithIdentifier:@"abc_de"];
    [self presentViewController:controller animated:YES completion:nil];
}


-(IBAction)onLeft:(id)sender{
    SWRevealViewController *revealViewController = self.revealViewController;
    if (revealViewController && [revealViewController respondsToSelector:@selector(revealToggle:)]) {
        [revealViewController performSelector:@selector(revealToggle:) withObject:nil];
    }
}

-(IBAction)rightClick:(id)sender
{
    [self performSegueWithIdentifier:@"open_search" sender:self];
}
#pragma mark - ui

-(void)onSelectSupermark
{
    self.myIndexView.contentOffset = CGPointZero; //滚到顶部
    self.myIndexView.hidden = NO;
    self.myServiceView.hidden = YES;
    [UIView animateWithDuration:0.5 animations:^{
        cartViewController.view.alpha = 1;
    } completion:^(BOOL finished) {
    }];
}

-(void)onSelectService
{
    [[ServiceModel instance] updateServiceWithAreaId:[[ShopModel instance] getAreaId]];
    self.myServiceView.contentOffset = CGPointZero;
    self.myIndexView.hidden = YES;
    self.myServiceView.hidden = NO;
    [UIView animateWithDuration:0.5 animations:^{
        cartViewController.view.alpha = 0;
    } completion:^(BOOL finished) {
    }];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.destinationViewController isKindOfClass:[ProductListViewController class]])
    {
        ProductListViewController* controller = segue.destinationViewController;
        controller.categoryID = category_id;
    }
    if ([segue.identifier isEqualToString:@"open_change_supermark"]) {
//        UIViewController* controller = segue.destinationViewController;
////        controller.modalPresentationStyle = UIModalPresentationOverCurrentContext;
////        controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    }
    if ([segue.identifier isEqualToString:@"open_service_detail_board"]){
        ServiceViewController* controller = segue.destinationViewController;
        controller.index = myServiceIndex;
    }
    if ([segue.identifier isEqualToString:@"open_goods_detail_board"]) {
        GoodsDetailController* controller = segue.destinationViewController;
        controller.goods = myGoods;
    }
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

#pragma mark - delegate shadow

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
#pragma mark - delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    long ret;
    if (tableView == self.myIndexView) {
        ret = 3;
    }
    else{
        ret = 1;
    }
    
    ShopLocation* location = [[RecentShopModel instance] getShopLocationByMerchantId:[[ShopModel instance] getCurrentMerchantId]];
    self.shopName.text = location.name;
    if (!self.shopName.text) {
        self.shopName.text = @"点击切换小区";
    }
    
    return ret;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    long ret = 0;
    if (tableView == self.myIndexView) {
        
        long kind = [[ShopModel instance] getCurrentCategoryCount];
        if ([[ShopModel instance] getCurrentMerchantId]) {
            switch (section) {
                case 0:
                    ret = 1;
                    break;
                case 1:
                    ret = (kind + 1) / 2;
                    break;
                case 2:
                    ret = kind;
                    break;
                default:
                    break;
            }
        }
    }
    else{
        ret = [[ServiceModel instance] getSimpleServiceCount] - 4 + 1; //首页固定占四个
        if (ret < 1) {
            ret = 1;
        }
    }
    return ret;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *ret;

    if (tableView == self.myIndexView) {
        
        switch (indexPath.section) {
            case 0:
            {
                IndexHeadCell* cell = [tableView dequeueReusableCellWithIdentifier:@"head" forIndexPath:indexPath];
                [cell viewInit];
                ret = cell;
                break;
                
            }
            case 1:
            {
                IndexCategoryCell* cell = [tableView dequeueReusableCellWithIdentifier:@"category" forIndexPath:indexPath];
                [cell viewInit:indexPath.row];
                ret = cell;
                break;
            }
            case 2:
            {
                NSString* str;
                if ([[ShopModel instance] getGoodsCountByIndex:indexPath.row] > 3) {
                    str = @"detailSix";
                }
                else{
                    str = @"detailThree";
                }
                IndexDetailSixCell* cell = [tableView dequeueReusableCellWithIdentifier:str forIndexPath:indexPath];
                [cell viewInit:indexPath.row];
                ret = cell;
                
                break;
            }
            default:
                break;
        }
    }
    else{
        if (indexPath.row == 0) {
            ServiceHeadCell* cell = [tableView dequeueReusableCellWithIdentifier:@"head" forIndexPath:indexPath];
            [cell viewInit];
            ret = cell;
        }
        else{
            ServiceDetailCell* cell = [tableView dequeueReusableCellWithIdentifier:@"detail" forIndexPath:indexPath];
            [cell ViewInitWithIndex:indexPath.row + 3];
            ret = cell;
        }
    }
    return ret;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float ret = 0;
    if (tableView == self.myIndexView) {
        switch (indexPath.section) {
            case 0:
                ret = 102;
                break;
                
            case 1:
                ret = 55;
                break;
                
            case 2:
                
                if ([[ShopModel instance] getGoodsCountByIndex:indexPath.row] > 3) {
                    ret = 360;
                }
                else{
                    ret = 210;
                }
                break;
                
                
            default:
                break;
        }
    }
    else{
        if (indexPath.row == 0) {
            ret = 150;
        }
        else{
            ret = 58;
        }
    }
    return ret;
}


- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.myServiceView) {

        if (indexPath.row == 0) { //顶上四个不从这里打开
            return nil;
        }
        myServiceIndex = indexPath.row + 3;
        [self performSegueWithIdentifier:@"open_service_detail_board" sender:self];
        return nil;
    }
    else{
        return indexPath;
    }
}

#pragma mark - notify
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
        [self.myIndexView reloadData];
    }
}

-(void)lyHandleEvent:(BaseEvent *)event
{
    if ([event isKindOfClass:[UIChangeShopSelectEvent class]]) {
        UIChangeShopSelectEvent* changeEvent = (UIChangeShopSelectEvent*)event;
        if (changeEvent.merchantId == -1) {
            [self performSegueWithIdentifier:@"open_change_handle" sender:self];
        }
        else{
            [[ShopModel instance] setDefaultIdAndRquest:changeEvent.merchantId Area:changeEvent.areaId Update:YES]; //手动切换商店，需要update信息
        }
    }
    else if ([event isKindOfClass:[UIRequestPhoneCallEvent class]]) {
        
        NSString * str=[[NSString alloc] initWithFormat:@"tel:%@", NUMBER_CUSTOMER_SERVICE];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [self.view addSubview:callWebview];
    }
    else if ([event isKindOfClass:[UIIndexSelectServiceEvent class]]) {
        if (((UIIndexSelectServiceEvent*)event).selectedSerivce) {
            [self onSelectService];
        }
        else{
            [self onSelectSupermark];
        }
    }
    else if ([event isKindOfClass:[UIOpenServiceDetailBoardEvent class]]) {
        UIOpenServiceDetailBoardEvent* serviceEvent = (UIOpenServiceDetailBoardEvent*)event;
        myServiceIndex = serviceEvent.index;
        [self performSegueWithIdentifier:@"open_service_detail_board" sender:self];
    }
    else if ([event isKindOfClass:[DataServiceModelEvent class]]){
        [self.myServiceView reloadData];
    }
    else if ([event isKindOfClass:[UIPressGoodsViewEvent class]]){
        if (self.navigationController.visibleViewController == self) {
            UIPressGoodsViewEvent* pressEvent = (UIPressGoodsViewEvent*)event;
            myGoods = pressEvent.goods;
            [self performSegueWithIdentifier:@"open_goods_detail_board" sender:self];
        }
    }
}

@end
