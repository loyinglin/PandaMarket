//
//  OrderDetailShippingCell.m
//  Supermark
//
//  Created by 林伟池 on 15/8/18.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "OrderDetailShippingCell.h"
#import "UIConstant.h"

@implementation OrderDetailShippingCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - view init
-(void)viewInitWithOrder:(Order *)order
{
    
//    @property (nonatomic , strong) IBOutlet UILabel* order_number;
//    @property (nonatomic , strong) IBOutlet UILabel* order_create;
//    @property (nonatomic , strong) IBOutlet UILabel* merchant_response;
//    
//    @property (nonatomic , strong) IBOutlet UILabel* phone;
//    @property (nonatomic , strong) IBOutlet UILabel* address;
//    
//    @property (nonatomic , strong) IBOutlet UILabel* order_complete;

    if (order) {
        self.order_number.text = [NSString stringWithFormat:@"%@", order.order_id];
        
        
        NSDate* date = [[NSDate alloc] initWithTimeIntervalSince1970:order.create_time.integerValue];
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm:ss"];
        self.order_create.text = [dateFormatter stringFromDate:date];


        if (order.rsp_time.integerValue == 0) {
            self.merchant_response.text = @"商家未响应";
        }
        else{
            date = [[NSDate alloc] initWithTimeIntervalSince1970:order.rsp_time.integerValue];
            self.merchant_response.text = [dateFormatter stringFromDate:date];
        }
        
        self.phone.text = order.phone;
        self.address.text = [NSString stringWithFormat:@"我是地址：  %@", order.address];
        
        if (order.complete_time.integerValue == 0) {
            self.order_complete.text = @"订单未完成";
        }
        else{
            date = [[NSDate alloc] initWithTimeIntervalSince1970:order.complete_time.integerValue];
            self.order_complete.text = [dateFormatter stringFromDate:date];
        }
        
        self.cancel.hidden = !(order.status.integerValue == order_status_waiting_response);
    }
}

#pragma mark - ui

#pragma mark - delegate

#pragma mark - notify

@end
