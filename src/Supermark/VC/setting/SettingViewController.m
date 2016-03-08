//
//  SettingViewController.m
//  Supermark
//
//  Created by 林伟池 on 15/8/31.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "SettingViewController.h"
#import "SWRevealViewController.h"
#import "AllModel.h"
#import "NSObject+LYUITipsView.h"
#import "UIConstant.h"

@interface SettingViewController ()
@property (nonatomic) IBOutlet UIBarButtonItem* revealButtonItem;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customStep];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)customStep
{
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.revealButtonItem setTarget: revealViewController];
        [self.revealButtonItem setAction: @selector( revealToggle: )];
        
        [self.navigationController.view addGestureRecognizer: self.revealViewController.panGestureRecognizer];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - view init

#pragma mark - ui
-(void)onTap
{
    [self performSegueWithIdentifier:@"open_suggestion_board" sender:self];

}

-(void)onCall
{
    LYLog(@"call");
    
    NSString * str=[[NSString alloc] initWithFormat:@"tel:%@", NUMBER_CUSTOMER_SERVICE];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
}

- (void)onCopyRight
{
    [self performSegueWithIdentifier:@"open_copyright_board" sender:self];
}
#pragma mark - delegate


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellIdentifier;
    
    switch (indexPath.row) {
        case 0:
            cellIdentifier = @"feedback";
            break;
            
        case 1:
            cellIdentifier = @"contact";
            break;
            
        case 2:
            cellIdentifier = @"comment";
            break;
            
        case 3:
            cellIdentifier = @"clear";
            break;
            
        default:
            cellIdentifier = @"service";
            break;
    }
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    return cell;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            [self onTap];
            break;
            
        case 1:
            [self onCall];
            break;
            
        case 2:
            LYLog(@"comment");
            [self onComment];
            break;
            
        case 3:
            [self onClear];
//            [self onCopyRight];
            break;
            
            
        default:
            break;
    }
    
    return nil;
}


- (void)onComment
{
    int appid = 1044568294;
    NSString *str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=%d", appid];
    

    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:str]];
    
}

- (void)onClear
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"清除缓存" message:@"清除商店、购物车等的缓存" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != 0) {
        [self presentLoadingTips:@"清理缓存中"];
        
        [[ShopModel instance] clearCache];
        [[CartModel instance] clearCache];
        [[RecentShopModel instance] clearCache];
        [[LocationModel instance] clearCache];
        [[ServiceModel instance] clearCache];
        [[OrderModel instance] clearCache];

        [NSTimer scheduledTimerWithTimeInterval:0.5f
                                         target:self
                                       selector:@selector(dismissTips)
                                       userInfo:nil
                                        repeats:NO];
    }
}

#pragma mark - notify


@end
