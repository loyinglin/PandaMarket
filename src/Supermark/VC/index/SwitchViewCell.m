//
//  SwitchViewCell.m
//  Supermark
//
//  Created by 林伟池 on 15/8/24.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "SwitchViewCell.h"
#import "RecentShopModel.h"

@implementation SwitchViewCell
{

}
- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - view init

-(void)viewInitIndex:(long)index
{
    ShopLocation* info = [[RecentShopModel instance] getSimpleShopInfoByIndex:index];
    if (info) {
        self.name.text = info.name;
    }

}

#pragma mark - ui

#pragma mark - delegate

#pragma mark - notify

@end
