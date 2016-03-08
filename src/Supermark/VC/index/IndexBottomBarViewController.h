//
//  IndexBottomBarView.h
//  Supermark
//
//  Created by 林伟池 on 15/7/29.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+Shadow.h"

@interface IndexBottomBarViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) IBOutlet UIImageView* cartView;
@property(nonatomic, strong) IBOutlet UIButton* cartCount;
@property(nonatomic, strong) IBOutlet UIButton* cartSend;
@property(nonatomic, strong) IBOutlet UILabel* cartTotalCost;

@property(nonatomic, strong) IBOutlet UIView* cartDetailView;
@property(nonatomic, strong) IBOutlet UITableView* cartDetailTableView;
@property(nonatomic, strong) IBOutlet UIView* cartDetailTop;

@property (nonatomic , strong) IBOutlet UILabel* shipping;


@property (nonatomic , strong) IBOutlet UIView* backView;
@property (nonatomic , strong) IBOutlet UIView* frontView;

@property (nonatomic, weak) UIViewController<LYShadowDelegate>* controller; //拥有购物车现在的controller

- (IBAction)clearCart:(id)sender;

- (IBAction)clickSend:(id)sender;

- (void)initConstraint;

@end
