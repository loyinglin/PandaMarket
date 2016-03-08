//
//  IndexBottomBarView.h
//  Supermark
//
//  Created by 林伟池 on 15/8/2.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartDetailCell : UITableViewCell

@property(nonatomic, strong) IBOutlet UILabel* name;
@property(nonatomic, strong) IBOutlet UILabel* money;
@property(nonatomic, strong) IBOutlet UIButton* count;
@property(nonatomic, strong) IBOutlet UIButton* add;
@property(nonatomic, strong) IBOutlet UIButton* del;


@property int indexOfView;

-(void)initViewWithIndex:(int)index;

-(IBAction)numAdd:(id)sender;

-(IBAction)numMinus:(id)sender;

@end
