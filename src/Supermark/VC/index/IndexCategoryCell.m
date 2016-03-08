//
//  IndexCategroyCell.m
//  Supermark
//
//  Created by 林伟池 on 15/9/9.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "IndexCategoryCell.h"
#import "AllModel.h"
#import "UIImageView+AFNetworking.h"

@implementation IndexCategoryCell
{
    
    NSNumber* categoryIDview0;
    NSNumber* categoryIDview1;
}

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
    
    UITapGestureRecognizer* tapView0 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onView0Click:)];
    [self.view0 addGestureRecognizer:tapView0];
    
    
    UITapGestureRecognizer* tapView1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onView1Click:)];
    [self.view1 addGestureRecognizer:tapView1];
    
    categoryIDview0 = 0;
    categoryIDview1 = 0;
    self.view0.hidden = YES;
    self.view1.hidden = YES;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - view init
-(void)viewInit:(long)indexOfView
{
    categoryIDview0 = 0;
    categoryIDview1 = 0;
    NSString* prefix = [[ShopModel instance] getCurrentPrefix];
    
    if (indexOfView * 2 < [[ShopModel instance] getCurrentCategoryCount]) { //real index
        IndexCategory* category = [[ShopModel instance] getIndexCategoryByIndex:indexOfView * 2];
        self.view0.hidden = NO;
        [self.image0 setImageWithURL:[[NSURL alloc] initWithString:[prefix stringByAppendingString:category.img]]];
        [self.labelName0 setText:category.name];
        categoryIDview0 = category.id;
    }
    
    if (indexOfView * 2 + 1 < [[ShopModel instance] getCurrentCategoryCount]) { //real index
        IndexCategory* category = [[ShopModel instance] getIndexCategoryByIndex:indexOfView * 2 + 1];
        self.view1.hidden = NO;
        [self.image1 setImageWithURL:[[NSURL alloc] initWithString:[prefix stringByAppendingString:category.img]]];
        [self.labelName1 setText:category.name];
        categoryIDview1 = category.id;
    }

}

#pragma mark - ui


-(void)onView0Click:(UITapGestureRecognizer *)tap
{
    if(categoryIDview0)
    {
        [self lyPostNotificationWithSender:NOTIFY_UI_OPEN_PRODUCT_LIST withData:[[NSDictionary alloc] initWithObjectsAndKeys:categoryIDview0, @"category_id", nil]];
    }
}


-(void)onView1Click:(UITapGestureRecognizer *)tap
{
    if(categoryIDview1)
    {
        [self lyPostNotificationWithSender:NOTIFY_UI_OPEN_PRODUCT_LIST withData:[[NSDictionary alloc] initWithObjectsAndKeys:categoryIDview1, @"category_id", nil]];
    }
}

#pragma mark - delegate

#pragma mark - notify

@end
