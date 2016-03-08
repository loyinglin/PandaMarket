//
//  ServiceHeadCell.h
//  Supermark
//
//  Created by 林伟池 on 15/9/16.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceView.h"

@interface ServiceHeadCell : UITableViewCell

@property (nonatomic , strong) IBOutlet ServiceView*     service0;
@property (nonatomic , strong) IBOutlet ServiceView*     service1;
@property (nonatomic , strong) IBOutlet ServiceView*     service2;
@property (nonatomic , strong) IBOutlet ServiceView*     service3;

-(IBAction)onSelectSupermark:(id)sender;

- (void)viewInit;

@end
