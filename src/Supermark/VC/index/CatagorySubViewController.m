//
//  CatagorySubTableViewCell.m
//  Supermark
//
//  Created by 林伟池 on 15/7/28.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "CatagorySubViewController.h"
#import "NSObject+LYNotification.h"
#import "UIImageView+AFNetworking.h"
#import "ShopModel.h"

@implementation CatagorySubViewController
{
    UITapGestureRecognizer* tapView0;
    UITapGestureRecognizer* tapView1;
    
    NSNumber* categoryIDview0;
    NSNumber* categoryIDview1;
}


/**
 *  addsubview 的时候调用，考虑到reload的时候，会不会调用这个？
 */
-(void)viewDidLoad
{
    [super viewDidLoad];
    tapView0 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onView0Click:)];
    [self.view0 addGestureRecognizer:tapView0];
    
    
    tapView1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onView1Click:)];
    [self.view1 addGestureRecognizer:tapView1];
    
    categoryIDview0 = 0;
    categoryIDview1 = 0;
    self.view0.hidden = YES;
    self.view1.hidden = YES;
}

-(void)dealloc
{
    [self.view0 removeGestureRecognizer:tapView0];
    [self.view1 removeGestureRecognizer:tapView1];
}


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

-(void)viewWillAppear:(BOOL)animated
{
    NSString* prefix = [[ShopModel instance] getCurrentPrefix];

    if (self.indexOfView * 2 < [[ShopModel instance] getCurrentCategoryCount]) { //real index
        IndexCategory* category = [[ShopModel instance] getIndexCategoryByIndex:self.indexOfView * 2];
        self.view0.hidden = NO;
        [self.image0 setImageWithURL:[[NSURL alloc] initWithString:[prefix stringByAppendingString:category.img]]];
        [self.labelName0 setText:category.name];
        categoryIDview0 = category.id;
    }
    
    if (self.indexOfView * 2 + 1 < [[ShopModel instance] getCurrentCategoryCount]) { //real index
        IndexCategory* category = [[ShopModel instance] getIndexCategoryByIndex:self.indexOfView * 2 + 1];
        self.view1.hidden = NO;
        [self.image1 setImageWithURL:[[NSURL alloc] initWithString:[prefix stringByAppendingString:category.img]]];
        [self.labelName1 setText:category.name];
        categoryIDview1 = category.id;
    }
    [super viewWillAppear:animated];
}

@end
