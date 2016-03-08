//
//  ServiceHeadCell.m
//  Supermark
//
//  Created by 林伟池 on 15/9/16.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "ServiceHeadCell.h"
#import "ServiceModel.h"
#import "NSObject+LYNotification.h"

@implementation ServiceHeadCell
{
    NSArray* arrView;
}

- (void)awakeFromNib {
    // Initialization code
    arrView = [NSArray arrayWithObjects:self.service0, self.service1, self.service2, self.service3, nil];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - view init

- (void)viewInit
{
    for (ServiceView* view in arrView) {
        view.hidden = YES;
    }
    long count = [[ServiceModel instance] getSimpleServiceCount];
    for (int i = 0; i < count && i < arrView.count; ++i) {
        ServiceView* view = arrView[i];
        [view viewInitByIndex:i];
        view.hidden = NO;
    }
}

#pragma mark - ui

-(void)onSelectSupermark:(id)sender
{
    UIIndexSelectServiceEvent* event = [UIIndexSelectServiceEvent instance];
    event.selectedSerivce = NO;
    [self lyPostEvent:event];

}

#pragma mark - delegate

#pragma mark - notify

@end
