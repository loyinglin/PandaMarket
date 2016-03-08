//
//  ProductList.h
//  Supermark
//
//  Created by 林伟池 on 15/7/30.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+Shadow.h"
#import "ChooseSubCateogryView.h"

@interface ProductListViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UITabBarDelegate, LYShadowDelegate>


@property(nonatomic, strong) IBOutlet UICollectionView* productList;

@property(nonatomic, strong) IBOutlet UIScrollView* scrollCatagory;
@property(nonatomic, strong) IBOutlet UITabBar* tabbar;

@property (nonatomic , strong) IBOutlet UIButton* button;

@property (nonatomic , strong) IBOutlet ChooseSubCateogryView* subCategoryView;

@property(nonatomic) NSNumber* categoryID; //主分类的ID
-(IBAction)returnToFirstPage:(id)sender;


@end
