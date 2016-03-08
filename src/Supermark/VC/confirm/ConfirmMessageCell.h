//
//  ConfireMessageCell.h
//  Supermark
//
//  Created by 林伟池 on 15/8/10.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfirmMessageCell : UITableViewCell
@property (nonatomic , strong) IBOutlet UILabel *left;
@property (nonatomic , strong) IBOutlet UILabel *detail;


-(void)viewInitWithMessage:(NSString*)msg;


@end
