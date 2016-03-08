//
//  OrderDetailMoneyCell.m
//  Supermark
//
//  Created by 林伟池 on 15/8/18.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "OrderDetailMoneyCell.h"
#import "UIConstant.h"

@implementation OrderDetailMoneyCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark - view init
-(void)viewInitWithGoodsMoney:(float)money PayType:(long)payType
{
    self.pay_type.text = [UIConstant getPayTypeDesc:payType];
    
    self.total.text = [NSString stringWithFormat:@"￥%.2f", money];
}

#pragma mark - ui

#pragma mark - delegate

#pragma mark - notify


@end
