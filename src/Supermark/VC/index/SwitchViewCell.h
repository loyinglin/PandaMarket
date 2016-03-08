//
//  SwitchViewCell.h
//  Supermark
//
//  Created by 林伟池 on 15/8/24.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwitchViewCell : UITableViewCell

@property (nonatomic , strong) IBOutlet UIImageView* img;
@property (nonatomic , strong) IBOutlet UILabel*    name;


-(void)viewInitIndex:(long)index;

@end
