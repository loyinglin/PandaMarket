//
//  ProductListCell.h
//  Supermark
//
//  Created by 林伟池 on 15/8/5.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopModel.h"
#import "DetailGoodsView.h"

@interface ProductListCell : UICollectionViewCell

@property (nonatomic , strong) IBOutlet DetailGoodsView* detail;

-(void)viewInitWith:(DetailGoods*)goods;

@end
