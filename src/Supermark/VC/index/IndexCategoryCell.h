//
//  IndexCategroyCell.h
//  Supermark
//
//  Created by 林伟池 on 15/9/9.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IndexCategoryCell : UITableViewCell

@property(nonatomic, strong)IBOutlet UIView* view0;
@property(nonatomic, strong)IBOutlet UIImageView* image0;
@property(nonatomic, strong)IBOutlet UILabel* labelName0;


@property(nonatomic, strong)IBOutlet UIView* view1;
@property(nonatomic, strong)IBOutlet UIImageView* image1;
@property(nonatomic, strong)IBOutlet UILabel* labelName1;

-(void)viewInit:(long)indexOfView;

@end
