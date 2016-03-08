//
//  ServiceDetailCell.h
//  Supermark
//
//  Created by 林伟池 on 15/9/16.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServiceDetailCell : UITableViewCell

@property (nonatomic , strong) IBOutlet UIImageView* img;
@property (nonatomic , strong) IBOutlet UILabel*    name;
@property (nonatomic) long areaId;

-(void)ViewInitWithIndex:(long)index;

@end

