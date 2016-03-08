//
//  AddressAddViewController.h
//  Supermark
//
//  Created by 林伟池 on 15/8/11.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressAddViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic , strong) IBOutlet UITextField* area;
@property (nonatomic , strong) IBOutlet UITextField* phone;
@property (nonatomic , strong) IBOutlet UITextField* addr;

@property long address_id;

-(IBAction)clickSave:(id)sender;

-(IBAction)clickDelete:(id)sender;

@end
