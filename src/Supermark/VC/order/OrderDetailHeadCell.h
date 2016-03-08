//
//  OrderDetailCell.h
//  Supermark
//
//  Created by 林伟池 on 15/8/18.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PhoneCallDelegate <NSObject>

@required
-(void)onPhoneCall;

@end

@interface OrderDetailHeadCell : UITableViewCell
@property (nonatomic , strong) IBOutlet UILabel* status;

@property (nonatomic , strong) IBOutlet UILabel*    shop;
@property (nonatomic , strong) IBOutlet UILabel*    area;

-(IBAction)clickCall:(id)sender;

-(void)viewInitWithStatus:(long)status Area:(NSString*)area_name Shop:(NSString*)shop_name Reason:(NSString*)reason PhoneCall:(id<PhoneCallDelegate>)delegate;


@end
