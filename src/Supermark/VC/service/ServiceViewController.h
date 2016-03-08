//
//  ServiceViewController.h
//  PandaMarket
//
//  Created by 林伟池 on 15/10/6.
//  Copyright © 2015年 林伟池. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServiceViewController : UIViewController

@property(nonatomic) long index;
@property (nonatomic , strong) IBOutlet UILabel* name;
@property (nonatomic , strong) IBOutlet UILabel* desc;
@property (nonatomic , strong) IBOutlet UILabel* address;
@property (nonatomic , strong) IBOutlet UILabel* phone;


@end
