//
//  ChangeViewCell.m
//  Supermark
//
//  Created by 林伟池 on 15/8/24.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "ChangeViewCell.h"

@implementation ChangeViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - view init
-(void)viewInitWithName:(NSString *)name Detail:(NSString *)detail Distance:(float)dist
{
    self.name.text = name;
    self.detail.text = detail;
    if (dist >= 1000) {
        self.distance.text = [NSString stringWithFormat:@"%.2fkm", dist / 1000];
    }
    else{
        self.distance.text = [NSString stringWithFormat:@"%.2fm", dist];
    }
}
#pragma mark - ui

#pragma mark - delegate

#pragma mark - notify

@end
