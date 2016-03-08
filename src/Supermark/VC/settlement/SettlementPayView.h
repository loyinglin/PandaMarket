//
//  SettlementPayView.h
//  Supermark
//
//  Created by 林伟池 on 15/8/13.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettlementPayView : UIView

@property (nonatomic , strong) IBOutlet UILabel* pay;
@property (nonatomic , strong) IBOutlet UIButton* select;

-(void)unChoose;

-(void)setChoose;

@end
