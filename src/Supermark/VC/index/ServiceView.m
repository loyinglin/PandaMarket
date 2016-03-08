//
//  ServiceView.m
//  Supermark
//
//  Created by 林伟池 on 15/9/17.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "ServiceView.h"
#import "ServiceModel.h"
#import "ShopModel.h"
#import "UIButton+AFNetworking.h"

@implementation ServiceView
{
    long myIndex;
}

-(void)awakeFromNib
{
//    LYLog(@"nib");
//    LYLog(@"img %@", self.img);
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
//    LYLog(@"init with frame");
//    LYLog(@"img %@", self.img);
    
    return self;
}

- (instancetype)init
{
    self = [super init];
    
//    LYLog(@"init");
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
//    LYLog(@"init with coder");
    
//    LYLog(@"img %@", self.img);
    
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)viewInitByIndex:(long)index
{
    SimpleService* service = [[ServiceModel instance] getSimpleSericeByIndex:index];
    if (service) {
        NSString* prefix = [[ShopModel instance] getCurrentPrefix];
        [self.img setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:[prefix stringByAppendingString:service.img]]];
        self.name.text = service.name;
        self.service_id = service.server_id.integerValue;
        myIndex = index;
    }
    
}

- (IBAction)onClick:(id)sender
{
    UIOpenServiceDetailBoardEvent* event = [UIOpenServiceDetailBoardEvent instance];
    event.index = myIndex;
    [self lyPostEvent:event];
}

@end
