//
//  CatagoryTableViewCell.h
//  Supermark
//
//  Created by 林伟池 on 15/7/28.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailGoodsView.h"

@class DetailGoodsView;

@interface CatagoryDetailViewController : UIViewController

@property(nonatomic, strong) IBOutlet UIButton* catagoryName;
@property(nonatomic, strong) IBOutlet UIButton* moreDetail;
@property(nonatomic, strong) IBOutlet DetailGoodsView* product0;
@property(nonatomic, strong) IBOutlet DetailGoodsView* product1;
@property(nonatomic, strong) IBOutlet DetailGoodsView* product2;
@property(nonatomic, strong) IBOutlet DetailGoodsView* product3;
@property(nonatomic, strong) IBOutlet DetailGoodsView* product4;
@property(nonatomic, strong) IBOutlet DetailGoodsView* product5;

@property(nonatomic, strong) IBOutlet UIView* contentView;

-(void)viewInitByIndex:(long)indexOfView;

-(IBAction)seeMore:(id)sender;

@end
