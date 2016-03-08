//
//  GoodsDetailController.m
//  PandaMarket
//
//  Created by 林伟池 on 15/10/12.
//  Copyright © 2015年 林伟池. All rights reserved.
//

#import "GoodsDetailController.h"
#import "UIImageView+AFNetworking.h"
#import "GoodsModel.h"
#import "ShopModel.h"

@interface GoodsDetailController ()

@end

@implementation GoodsDetailController
{
    UITapGestureRecognizer* tap;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onBackClick:)];
    [self.backView addGestureRecognizer:tap];
    
    [self showGoodsDetail];
    [self lyObserveNotification:NOTIFY_GOODS_DATA_CHANGE];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
#pragma mark - ui

-(void)onBackClick:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)showGoodsDetail
{
    if (self.goods) {
        [self.goodsDetailView setImageWithURL:[[NSURL alloc] initWithString:[[[ShopModel instance] getCurrentPrefix] stringByAppendingString:self.goods.img]]];
        self.name.text = self.goods.name;
        self.money.text = [NSString stringWithFormat:@"￥%.2f", self.goods.price.floatValue];
    }
}


#pragma mark - delegate

#pragma mark - notify
-(void)lyHandleNotification:(NSNotification *)notify
{
    if ([NOTIFY_GOODS_DATA_CHANGE isEqualToString:notify.name]) {
        [self showGoodsDetail];
    }
}

@end
