//
//  OrderDetailGoodsCellTableViewCell.h
//  Supermark
//
//  Created by 林伟池 on 15/8/18.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailGoodsCell : UITableViewCell

@property (nonatomic , strong) IBOutlet UIImageView* img;
@property (nonatomic , strong) IBOutlet UILabel*    name;
@property (nonatomic , strong) IBOutlet UILabel*    money;
@property (nonatomic , strong) IBOutlet UILabel*    count;

-(void)viewInitWithGoodsId:(long)goods_id Price:(float)price Count:(long)count;

@end
