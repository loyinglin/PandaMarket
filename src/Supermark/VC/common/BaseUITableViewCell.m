//
//  BaseUITableViewCell.m
//  Supermark
//
//  Created by 林伟池 on 15/9/15.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "BaseUITableViewCell.h"

@implementation BaseUITableViewCell

- (void)awakeFromNib {
    // Initialization code
    if (!self.bNotAutoClear) {
        self.backgroundColor = [UIColor clearColor];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
