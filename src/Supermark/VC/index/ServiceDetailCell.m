//
//  ServiceDetailCell.m
//  Supermark
//
//  Created by 林伟池 on 15/9/16.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "ServiceDetailCell.h"
#import "ServiceModel.h"
#import "ShopModel.h"
#import "UIImageView+AFNetworking.h"

@implementation ServiceDetailCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - view init
-(void)ViewInitWithIndex:(long)index
{
    NSString* prefix = [[ShopModel instance] getCurrentPrefix];
    
    SimpleService* service = [[ServiceModel instance] getSimpleSericeByIndex:index];
    if (service) {
        [self.img setImageWithURL:[NSURL URLWithString:[prefix stringByAppendingString:service.img]]];
        self.name.text = service.name;
        self.areaId = service.server_id.integerValue;
    }
    
}

#pragma mark - ui


#pragma mark - delegate

#pragma mark - notify

@end
