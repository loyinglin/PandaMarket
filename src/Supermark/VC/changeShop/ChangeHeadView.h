//
//  ChangeHeadView.h
//  Supermark
//
//  Created by 林伟池 on 15/8/24.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeHeadView : UITableViewCell

@property (nonatomic , strong) IBOutlet UIButton* modify;

-(IBAction)onClickModify:(id)sender;

@end
