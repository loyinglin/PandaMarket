//
//  ServiceViewController.m
//  PandaMarket
//
//  Created by 林伟池 on 15/10/6.
//  Copyright © 2015年 林伟池. All rights reserved.
//

#import "ServiceViewController.h"
#import "ServiceModel.h"

@interface ServiceViewController ()

@end

@implementation ServiceViewController
{
    NSString* myPhone;
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    SimpleService* service = [[ServiceModel instance] getSimpleSericeByIndex:self.index];
    if (service) {
        [self setTitle:service.name];
        self.name.text = service.user_name;
        self.address.text = service.address;
        self.desc.text = [NSString stringWithFormat:@"    %@", service.server_desc];
        self.phone.text = service.phone;
        myPhone = service.phone;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ui
-(IBAction)onClick:(id)sender
{
    if (myPhone) {
        NSString * str=[[NSString alloc] initWithFormat:@"tel:%@", myPhone];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [self.view addSubview:callWebview];
    }

}
#pragma mark - delegate

#pragma mark - notify


@end
