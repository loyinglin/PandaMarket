//
//  AddressManageCell.h
//  Supermark
//
//  Created by 林伟池 on 15/8/12.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressManageCell : UITableViewCell

@property (nonatomic , strong) IBOutlet UIButton* select;
@property (nonatomic , strong) IBOutlet UILabel* addr;
@property (nonatomic , strong) IBOutlet UILabel* phone;

@property long indexOfView;

-(void)viewInitWithIndex:(long)index;

-(IBAction)clickModify:(id)sender;

@end
