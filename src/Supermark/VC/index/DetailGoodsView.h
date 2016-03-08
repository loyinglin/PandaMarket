//
//  CatagoryDetailSubView.h
//  Supermark
//
//  Created by 林伟池 on 15/7/29.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Supermark.h"
#import "BaseView.h"

@interface DetailGoodsView : BaseView

@property(nonatomic, strong) IBOutlet UIButton* button;

@property(nonatomic, strong) IBOutlet UIImageView* image;

@property(nonatomic, strong) IBOutlet UILabel* name;

@property(nonatomic, strong) IBOutlet UILabel* sell;

@property(nonatomic, strong) IBOutlet UILabel* money;

@property(nonatomic, strong) IBOutlet UIButton* count;

@property (nonatomic , strong) IBOutlet UIView* view;

-(void)viewInitWithGoods:(DetailGoods*)goods;

@end
