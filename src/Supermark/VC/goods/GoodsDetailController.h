//
//  GoodsDetailController.h
//  PandaMarket
//
//  Created by 林伟池 on 15/10/12.
//  Copyright © 2015年 林伟池. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Supermark.h"

@interface GoodsDetailController : UIViewController

@property (nonatomic , strong) IBOutlet UIImageView* goodsDetailView;
@property (nonatomic , strong) IBOutlet UIView* backView;
@property (nonatomic , strong) IBOutlet UILabel* name;
@property (nonatomic , strong) IBOutlet UILabel* money;

@property (nonatomic , strong) DetailGoods* goods;


@end
