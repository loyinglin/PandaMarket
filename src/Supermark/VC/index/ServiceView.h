//
//  ServiceView.h
//  Supermark
//
//  Created by 林伟池 on 15/9/17.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServiceView : UIView

@property (nonatomic , strong) IBOutlet UIButton* img;
@property (nonatomic , strong) IBOutlet UILabel*    name;
@property (nonatomic) long service_id;


- (void)viewInitByIndex:(long)index;

@end
