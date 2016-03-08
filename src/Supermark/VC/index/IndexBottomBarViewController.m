//
//  IndexBottomBarView.m
//  Supermark
//
//  Created by 林伟池 on 15/7/29.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "IndexBottomBarViewController.h"
#import "UIConstant.h"
#import "NSObject+LYNotification.h"
#import "CartDetailCell.h"
#import "ShopModel.h"
#import "CartModel.h"
#import "NSObject+LYUITipsView.h"

@implementation IndexBottomBarViewController
{
    BOOL CART_OPEN;
    BOOL MOVING;
    UITapGestureRecognizer* recognizer;
    UITapGestureRecognizer* backTap;
}
#pragma mask - view init
-(void)viewDidLoad
{
    [super viewDidLoad];
    MOVING = NO;
    CART_OPEN = NO;
    self.automaticallyAdjustsScrollViewInsets = false;
    self.cartDetailView.hidden = true;
    
    self.cartCount.hidden = YES;
    
    
    
    
    [self.cartDetailTableView registerNib:[UINib nibWithNibName:@"CartDetailCell" bundle:nil] forCellReuseIdentifier:@"CartDetailCell"];
    [self.cartDetailTableView setContentOffset:CGPointMake(CONST_ZERO, CONST_ZERO) animated:YES];
    [self.cartDetailTableView setContentInset:UIEdgeInsetsZero];
    
    
    recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cartViewClick:)];
    [self.cartView addGestureRecognizer:recognizer];
    
    
    
    backTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backClick:)];
    [self.backView addGestureRecognizer:backTap];
    
    
    [self lyObserveNotification:NOTIFY_CART_DATA_CHANGE];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showBottomBar];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[CartModel instance] clearEmptyGoods];
}

-(void)dealloc
{
    [self.cartView removeGestureRecognizer:recognizer];
    [self lyRemoveAllObserveNotification];
}

-(void)initConstraint
{
    NSLayoutConstraint* constraint;
    [self.view setTranslatesAutoresizingMaskIntoConstraints:false];
    
    constraint = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view.superview attribute:NSLayoutAttributeBottom multiplier:1.0f constant:CONST_ZERO];
    [self.view.superview addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view.superview attribute:NSLayoutAttributeLeading multiplier:1.0f constant:CONST_ZERO];
    [self.view.superview addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view.superview attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:CONST_ZERO];
    [self.view.superview addConstraint:constraint];
    
    
    constraint = [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:CONST_HIDE_CART_HEIGHT];
    [constraint setIdentifier:@"height"];
    [self.view addConstraint:constraint];
}
#pragma mask - delegate tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[CartModel instance] getCartCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellIdentifier = @"CartDetailCell";
    CartDetailCell* cell = (CartDetailCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    [cell initViewWithIndex:(int)indexPath.row];
    return cell;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewCell* cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
//    return cell.frame.size.height;
//}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

#pragma mask - event

-(void)backClick:(id)sender{
    [self cartViewClick:sender];
}

-(void)openCart
{
    if (MOVING) {
        return;
    }
    
    MOVING = YES;
    
    if(self.controller){
        
        [self.controller setShadowWithView:self.view OnshadowClose:^{

            [self closeCart];
        }];
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        
        for (NSLayoutConstraint* constraint in self.view.constraints) {
            if([constraint.identifier isEqualToString: @"height"])
            {
                self.cartDetailView.hidden = NO;
                
                constraint.constant = CONST_SHOW_CART_HEIGHT + [[CartModel instance] getCartCount] * CONST_CART_ITEM_HEIGHT;
                
                if (constraint.constant > CONST_MAX_CART_HEIGHT) {
                    constraint.constant = CONST_MAX_CART_HEIGHT;
                }
                
            }
        }
        
        for (NSLayoutConstraint* constraint in self.frontView.constraints) {
            if (constraint.firstItem == self.shipping && constraint.firstAttribute == NSLayoutAttributeLeading) {
                constraint.constant = 10;
                
            }
        }
        [self.cartDetailTableView reloadData];
        [self.view layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        if (finished) {
            MOVING = NO;
            if (CART_OPEN) {
                self.cartDetailView.hidden = YES;
            }
            CART_OPEN = !CART_OPEN;
            
        }
    }];
    
}

-(void)closeCart
{
    if (MOVING) {
        return;
    }
    
    MOVING = YES;
    
    [self backRemove];
    [UIView animateWithDuration:0.5 animations:^{
        
        for (NSLayoutConstraint* constraint in self.view.constraints) {
            if([constraint.identifier isEqualToString: @"height"])
            {
                constraint.constant = CONST_HIDE_CART_HEIGHT;
            }
        }
        
        for (NSLayoutConstraint* constraint in self.frontView.constraints) {
            if (constraint.firstItem == self.shipping && constraint.firstAttribute == NSLayoutAttributeLeading) {
                constraint.constant = 100;
            }
        }
        
        [self.cartDetailTableView reloadData];
        [self.view layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        if (finished) {
            MOVING = NO;
            if (CART_OPEN) {
                self.cartDetailView.hidden = YES;
            }
            CART_OPEN = !CART_OPEN;
            
        }
    }];
    
}

-(void)backRemove
{
    if (self.controller) {
        [self.controller shadowCloseFrom:self];
    }
    
}

-(void)cartViewClick:(id)sender{
    
    if (CART_OPEN) {
        //现在是打开
        [self closeCart];
    }else{
        [self openCart];
    }
    
    return ;
}

-(void)clickSend:(id)sender
{
    float needPrice = [[ShopModel instance] getCurrentShippingPrice];
    float totalPrice = [[CartModel instance] getTotalCostInCart];
    
    if (needPrice <= totalPrice) {
        [self lyPostNotification:NOTIFY_UI_OPEN_CONFIRM_ORDER];
    }
    else{
        
        //        UIAlertView* view = [[UIAlertView alloc] initWithTitle:@"确认订单" message:[NSString stringWithFormat:@"还差%.2f元", needPrice - totalPrice]
        //                                                       delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
        //        [view show];
        [[LYUITipsCenter instance] setMessageIcon:[UIImage imageNamed:@"amap_man"]];
        [self.navigationController presentMessageTips:[NSString stringWithFormat:@"还差%.2f元", needPrice - totalPrice]];
    }
}

/**
 *  点击清除购物车
 *
 *  @param sender button
 */
- (void)clearCart:(id)sender
{
    [[CartModel instance] clearCartGoods];
    [self closeCart];
    
}


#pragma mask - notify
-(void)lyHandleNotification:(NSNotification *)notify
{
    if ([notify.name isEqualToString:NOTIFY_CART_DATA_CHANGE]) {
        [self showBottomBar];
    }
}

-(void)showBottomBar
{
    float needPrice = [[ShopModel instance] getCurrentShippingPrice];
    float totalPrice = [[CartModel instance] getTotalCostInCart];
    if (totalPrice < needPrice) {
        [self.cartSend setTitle:[NSString stringWithFormat:@"还差%.0f元", needPrice - totalPrice] forState:UIControlStateNormal];
    }
    else
    {
        [self.cartSend setTitle:@"选好了" forState:UIControlStateNormal];
    }
    [self.cartCount setTitle:[NSString stringWithFormat:@"%ld", [[CartModel instance] getGoodsCount]] forState:UIControlStateNormal];
    if ([[CartModel instance] getGoodsCount]) {
        self.cartCount.hidden = NO;
    }
    else{
        self.cartCount.hidden = YES;
    }
    self.cartTotalCost.text = [NSString stringWithFormat:@"￥%.2f", totalPrice];
    
    if (CART_OPEN) {
        [self.cartDetailTableView reloadData];
    }
}


@end
