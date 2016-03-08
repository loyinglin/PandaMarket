//
//  ChooseShopAddressViewController.h
//  Supermark
//
//  Created by 林伟池 on 15/8/24.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseShopAddressViewController : UIViewController

@property (nonatomic , strong) IBOutlet UITextField* address;
@property (nonatomic , strong) IBOutlet UIButton* sure;

-(IBAction)onClickSure:(id)sender;

@end
