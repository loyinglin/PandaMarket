//
//  IndexDetailSixCell.h
//  Supermark
//
//  Created by 林伟池 on 15/9/9.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailGoodsView.h"

@interface IndexDetailSixCell : UITableViewCell

@property(nonatomic, strong) IBOutlet UIButton* catagoryName;
@property(nonatomic, strong) IBOutlet UIButton* moreDetail;
@property(nonatomic, strong) IBOutlet DetailGoodsView* product0;
@property(nonatomic, strong) IBOutlet DetailGoodsView* product1;
@property(nonatomic, strong) IBOutlet DetailGoodsView* product2;
@property(nonatomic, strong) IBOutlet DetailGoodsView* product3;
@property(nonatomic, strong) IBOutlet DetailGoodsView* product4;
@property(nonatomic, strong) IBOutlet DetailGoodsView* product5;

-(void)viewInit:(long)indexOfView;

-(IBAction)seeMore:(id)sender;

@end
