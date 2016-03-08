//
//  LoginViewController.h
//  Supermark
//
//  Created by 林伟池 on 15/8/13.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic , strong) IBOutlet UITextField* phone;
@property (nonatomic , strong) IBOutlet UITextField* code;
@property (nonatomic , strong) IBOutlet UIButton* get_code;

-(IBAction)clickBack:(id)sender;

-(IBAction)clickSave:(id)sender;

-(IBAction)clickGetCode:(id)sender;
@end
