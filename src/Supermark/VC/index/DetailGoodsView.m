//
//  CatagoryDetailSubView.m
//  Supermark
//
//  Created by 林伟池 on 15/7/29.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "DetailGoodsView.h"
#import "UIConstant.h"
#import "ShopModel.h"
#import "CartModel.h"
#import "NSObject+LYNotification.h"
#import "UIImageView+AFNetworking.h"

@implementation DetailGoodsView
{
    UITapGestureRecognizer* tap;
    UILongPressGestureRecognizer* press;
    DetailGoods* detail_goods;
}



#pragma mask - view init <#mask#>

-(void) awakeFromNib
{
    UIView* contentView = [[[NSBundle mainBundle] loadNibNamed:[[self class] description] owner:self options:nil] lastObject];
    
    [self addSubview:contentView];

    
    NSLayoutConstraint* constraint;
    
    //必不可少** 这里不是self 是从nib添加过来的nib需要f
    [contentView setTranslatesAutoresizingMaskIntoConstraints:false];
    
    //添加上 约束
    constraint = [NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0f constant:CONST_ZERO];
    [self addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0f constant:CONST_ZERO];
    [self addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:CONST_ZERO];
    [self addConstraint:constraint];
    
    
    constraint = [NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0f constant:CONST_ZERO];
    [self addConstraint:constraint];
    
    
    [self.button setHidden:true];
    [self.count setHidden:true];
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onAdd:)];
    [self addGestureRecognizer:tap];
    
    press = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(onPress:)];
    [self addGestureRecognizer:press];
    
    [self lyObserveNotification:NOTIFY_CART_DATA_CHANGE];
}

-(void)viewInitWithGoods:(DetailGoods*)goods
{
    detail_goods = goods;
    NSString* prefix = [[ShopModel instance] getCurrentPrefix];
    [self.image setImageWithURL:[[NSURL alloc] initWithString:[prefix stringByAppendingString:goods.img]]];
    
    self.name.text = goods.name;
    self.sell.text = [NSString stringWithFormat:@"月售：%d", goods.month_sell.intValue];

    self.money.text = [NSString stringWithFormat:@"￥%.2f", goods.price.floatValue];
    [self showCount];
}


-(void)dealloc
{
    [self removeGestureRecognizer:tap];
    
    [self lyRemoveAllObserveNotification];
}



#pragma mask - ui

-(void)onAdd:(id)sender
{
    if (detail_goods) {
        [[CartModel instance] addWithGoods:detail_goods];
    }
}

-(void)onPress:(UILongPressGestureRecognizer*)sender
{
    if (detail_goods && sender.state == UIGestureRecognizerStateBegan) {
//        LYLog(@"present press's event");
        UIPressGoodsViewEvent* event = [UIPressGoodsViewEvent instance];
        event.goods = detail_goods;
        [self lyPostEvent:event];
    }
}

-(IBAction)onDelete:(id)sender
{
    if (detail_goods) {
        [[CartModel instance] removeWithGoods:detail_goods];
    }
}




#pragma mask - delegate

#pragma mark - notify
-(void)lyHandleNotification:(NSNotification *)notify
{
    if ([notify.name isEqual:NOTIFY_CART_DATA_CHANGE]) {
        [self showCount];
    }
}

-(void)showCount
{
    CartGoods *cart_goods = [[CartModel instance] getCartGoodsById:detail_goods.goods_id.integerValue];
    if (cart_goods && cart_goods.count > 0) {
        self.button.hidden = NO;
        self.count.hidden = NO;
        [self.count setTitle:[NSString stringWithFormat:@"%ld", (long)cart_goods.count.integerValue]forState:UIControlStateNormal];
    }
    else
    {
        [self.button setHidden:true];
        [self.count setHidden:true];
    }
}

@end
