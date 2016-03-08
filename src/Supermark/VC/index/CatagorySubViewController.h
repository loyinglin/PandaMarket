//
//  CatagorySubTableViewCell.h
//  Supermark
//
//  Created by 林伟池 on 15/7/28.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CatagorySubViewController : UIViewController

@property(nonatomic, strong)IBOutlet UIView* view0;
@property(nonatomic, strong)IBOutlet UIImageView* image0;
@property(nonatomic, strong)IBOutlet UILabel* labelName0;


@property(nonatomic, strong)IBOutlet UIView* view1;
@property(nonatomic, strong)IBOutlet UIImageView* image1;
@property(nonatomic, strong)IBOutlet UILabel* labelName1;

@property int indexOfView;
@end
