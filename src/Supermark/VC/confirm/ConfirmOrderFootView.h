//
//  ConfirmOrderFootView.h
//  Supermark
//
//  Created by 林伟池 on 15/8/11.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfirmOrderFootView : UIView
@property (nonatomic , strong) IBOutlet UILabel* money;
@property (nonatomic , strong) IBOutlet UILabel* send;
@property (nonatomic , strong) IBOutlet UILabel* total;
@property (nonatomic , strong) IBOutlet UIButton* confirm;

-(IBAction) buttonClick:(id)sender;

@end
