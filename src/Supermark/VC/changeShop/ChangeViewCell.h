//
//  ChangeViewCell.h
//  Supermark
//
//  Created by 林伟池 on 15/8/24.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeViewCell : UITableViewCell

@property (nonatomic , strong) IBOutlet UILabel* name;
@property (nonatomic , strong) IBOutlet UILabel* detail;
@property (nonatomic , strong) IBOutlet UILabel* distance;

- (void)viewInitWithName:(NSString*)name Detail:(NSString*)detail Distance:(float)dist;

@end
