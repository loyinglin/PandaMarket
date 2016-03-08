//
//  IndexDetailSixCell.m
//  Supermark
//
//  Created by 林伟池 on 15/9/9.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "IndexDetailSixCell.h"
#import "AllModel.h"

@implementation IndexDetailSixCell
{
    NSArray* goodViews;
    NSNumber* categoryID;
}

- (void)awakeFromNib {
    // Initialization code
//    self.backgroundColor = [UIColor clearColor];
    
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - view init

-(IBAction)seeMore:(id)sender{
    
    if(categoryID)
    {
        [self lyPostNotificationWithSender:NOTIFY_UI_OPEN_PRODUCT_LIST withData:[[NSDictionary alloc] initWithObjectsAndKeys:categoryID, @"category_id", nil]];
    }
}

-(void)viewInit:(long)indexOfView
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

#pragma mark - ui

#pragma mark - delegate

#pragma mark - notify


@end
