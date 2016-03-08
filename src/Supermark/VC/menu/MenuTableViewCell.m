//
//  MenuTableViewCell.m
//  Supermark
//
//  Created by 林伟池 on 15/8/31.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "MenuTableViewCell.h"
#import "LYColor.h"

@implementation MenuTableViewCell

- (void)awakeFromNib {
    self.backgroundColor = [UIColor clearColor];
        //    [self setTranslatesAutoresizingMaskIntoConstraints:NO];

//    self.selectedBackgroundView
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    [self.img setHighlighted:selected];
    
    if (selected) {
        self.backgroundColor = UIColorFromRGB(0x3b4452);
    }else{
        self.backgroundColor = [UIColor clearColor];
    }
    
    // Configure the view for the selected state
}

@end
