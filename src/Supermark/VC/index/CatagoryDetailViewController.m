//
//  CatagoryTableViewCell.m
//  Supermark
//
//  Created by 林伟池 on 15/7/28.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "CatagoryDetailViewController.h"
#import "CatagorySubViewController.h"
#import "ShopModel.h"
#import "NSObject+LYNotification.h"


@implementation CatagoryDetailViewController
{
    NSArray* goodViews;
    NSNumber* categoryID;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    goodViews = [[NSArray alloc] initWithObjects:
                 self.product0,
                 self.product1,
                 self.product2,
                 self.product3,
                 self.product4,
                 self.product5,
                 nil];
    self.product0.hidden = true;
    self.product1.hidden = true;
    self.product2.hidden = true;
    self.product3.hidden = true;
    self.product4.hidden = true;
    self.product5.hidden = true;
}

- (void)onClick:(id)sender
{
    LYLog(@"on Click %@", sender);
    
}

-(IBAction)seeMore:(id)sender{
    
    if(categoryID)
    {
        [self lyPostNotificationWithSender:NOTIFY_UI_OPEN_PRODUCT_LIST withData:[[NSDictionary alloc] initWithObjectsAndKeys:categoryID, @"category_id", nil]];
    }
}

-(void)viewInitByIndex:(long)indexOfView
{
    if (indexOfView < [[ShopModel instance] getCurrentCategoryCount]) {
        IndexCategory* category = [[ShopModel instance] getIndexCategoryByIndex: indexOfView];
        categoryID = category.id;
        NSArray* goods = category.goods;

        for (int i = 0; i < goodViews.count && i < goods.count; ++i) {
            DetailGoodsView* view = goodViews[i];
            if (view) {
                [view viewInitWithGoods:(DetailGoods*)goods[i]];
                view.hidden = NO;
            }
        }
        
        [self.catagoryName setTitle:category.name forState:UIControlStateNormal];
    }
    
    
}
@end
