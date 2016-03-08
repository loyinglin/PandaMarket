//
//  ProductListCell.m
//  Supermark
//
//  Created by 林伟池 on 15/8/5.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "ProductListCell.h"
#import "NSObject+LYNotification.h"
#import "UIImageView+AFNetworking.h"
#import "CartModel.h"

@implementation ProductListCell
{
}

-(void)awakeFromNib
{
//    LYLog(@"$#");
}

-(void)viewInitWith:(DetailGoods *)goods
{
    [self.detail viewInitWithGoods:goods];
}
@end
