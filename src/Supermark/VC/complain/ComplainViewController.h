//
//  ComplainViewController.h
//  Supermark
//
//  Created by 林伟池 on 15/9/11.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComplainViewController : UIViewController<UITextViewDelegate>

-(void)setOrderId:(long)orderId;

@property (nonatomic , strong) IBOutlet UIButton* button0;
@property (nonatomic , strong) IBOutlet UIButton* button1;
@property (nonatomic , strong) IBOutlet UIButton* button2;
@property (nonatomic , strong) IBOutlet UIButton* button3;
@property (nonatomic , strong) IBOutlet UIButton* button4;
@property (nonatomic , strong) IBOutlet UIButton* button5;
@property (nonatomic , strong) IBOutlet UIButton* button6;
@property (nonatomic , strong) IBOutlet UIButton* button7;
@property (nonatomic , strong) IBOutlet UIButton* button8;
@property (nonatomic , strong) IBOutlet UIButton* button9;
@property (nonatomic , strong) IBOutlet UIButton* button10;
@property (nonatomic , strong) IBOutlet UIButton* button11;

@property (nonatomic , strong) IBOutlet UITextView* suggestion;

@property (nonatomic , strong) IBOutlet UILabel* toSuggest;
@end
