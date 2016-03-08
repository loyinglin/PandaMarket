//
//  ProductList.m
//  Supermark
//
//  Created by 林伟池 on 15/7/30.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "ProductListViewController.h"
#import "GoodsDetailController.h"
#import "ProductListCell.h"
#import "UIConstant.h"
#import "AllModel.h"
#import "IndexBottomBarViewController.h"
#import "NSObject+LYNotification.h"
#import "LYColor.h"

@implementation ProductListViewController
{
    IndexBottomBarViewController* cartViewController;
    bool categoryShow;
    
    OnShadowClose closeCallBack;
    UIView* shadowView;
}
static long TITLE_WIDTH = 80;
static long COLLECTION_HEIGHT = 170;
static long COLLECTION_WIDTH_COUNT = 3;

- (IBAction)returnToFirstPage:(id)sender {
    LYLog(@"dismiss");
    [self dismissViewControllerAnimated:YES completion:^{}];
}

#pragma mark - view init

-(void)viewDidLoad
{
    [super viewDidLoad];
    categoryShow = NO;
    [self.productList registerNib:[UINib nibWithNibName:@"ProductListCell" bundle:nil] forCellWithReuseIdentifier:@"ProductListCell"];
    [self initScrollCatagory];
    
    UIPanGestureRecognizer* pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPanGes:)];
    [self.view addGestureRecognizer:pan];
    
    /************    bottomView 布局  start **********/
    cartViewController = [[IndexBottomBarViewController alloc] initWithNibName:[[IndexBottomBarViewController class] description] bundle:nil];
    [self addChildViewController:cartViewController];
    [self.view addSubview:cartViewController.view];
    cartViewController.controller = self;
    [cartViewController initConstraint];
    /************    bottomView 布局  end **********/
    UITabBarItem* item = [self.tabbar.items firstObject];
    [self.tabbar setSelectedItem:item];
    [self tabBar:self.tabbar didSelectItem:item];
//    [self.tabbar setBackgroundColor:UIColorFromRGB(LY_COLOR_BACKGROUND)];
    
    UIView* itemBackground = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tabbar.itemWidth, 50)];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 39, self.tabbar.itemWidth, 2)];
    line.backgroundColor = UIColorFromRGB(LY_COLOR_RED);
    
    [itemBackground addSubview:line];
    
    UIGraphicsBeginImageContext(itemBackground.bounds.size);
    [itemBackground.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.tabbar.selectionIndicatorImage = img;
    [self lyObserveNotification:NOTIFY_LIST_DATA];
    [self lyObserveEvent:[UISubCategoryChooseEvent instance]];
    [self lyObserveNotification:[UIPressGoodsViewEvent notifyName]];
    
    __weak typeof(self) controller = self;
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidChangeStatusBarOrientationNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        
        [controller.productList reloadData];
    }];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

//- (void)viewWillLayoutSubviews {
//    CGRect tabFrame = self.tabbar.frame;
//    tabFrame.size.height = 80;
//    tabFrame.origin.y = self.view.frame.size.height - 80;
//    self.tabbar.frame = tabFrame;
//}

-(void)dealloc
{
//    NSLog(@"abc");
    [self lyRemoveAllObserveNotification];
}

-(void)onPanGes:(UIPanGestureRecognizer*)sender
{
    CGPoint movePoint = [sender translationInView:self.view];
//    LYLog(@"%ld %@", (long)[sender state], NSStringFromCGPoint(movePoint));
    if ([sender state] == UIGestureRecognizerStateEnded && movePoint.x <= -80) {
        long index = [self.tabbar.items indexOfObject:self.tabbar.selectedItem];
        if (index + 1 < self.tabbar.items.count) {
            UITabBarItem* item = [self.tabbar.items objectAtIndex:index + 1];
            [self.tabbar setSelectedItem:item];
            [self tabBar:self.tabbar didSelectItem:item]; //manul
            [sender setTranslation:CGPointMake(0, 0) inView:self.productList];
        }
    }
    else if ([sender state] == UIGestureRecognizerStateEnded && movePoint.x >= 80){
        long index = [self.tabbar.items indexOfObject:self.tabbar.selectedItem];
        if (index - 1 >= 0){
            UITabBarItem* item = [self.tabbar.items objectAtIndex:index - 1];
            [self.tabbar setSelectedItem:item];
            [self tabBar:self.tabbar didSelectItem:item]; //manul
            [sender setTranslation:CGPointMake(0, 0) inView:self.productList];
        }

    }
    
}
#pragma mask - delegate shadow

-(void)shadowCloseFrom:(id)sender
{
    if ([sender isKindOfClass:[UITapGestureRecognizer class]]) {
        [self lyCloseShadowWithView:shadowView OnShadowClose:closeCallBack];
    }else{
        [self lyCloseShadowWithView:shadowView OnShadowClose:nil];
    }
}

-(void)setShadowWithView:(UIView*)view OnshadowClose:(OnShadowClose)onClose
{
    closeCallBack = onClose;
    shadowView = [self lySetShadowWithView:view];
}

#pragma mark - more
-(IBAction)onClickMore:(id)sender{
    if (!categoryShow) {
        [self showCategory];
    }
    else{
        [self closeCategory];
    }
}


-(void)showCategory
{
    if (!self.subCategoryView.hidden) { //已经显示
        return ;
    }
    self.subCategoryView.hidden = NO;
    self.subCategoryView.category_id = self.categoryID.integerValue;
    [self.subCategoryView.category reloadData];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        for (NSLayoutConstraint* constraint in self.view.constraints) {
            if (constraint.firstItem == self.productList && constraint.firstAttribute == NSLayoutAttributeBottom && constraint.secondItem == self.subCategoryView && constraint.secondAttribute == NSLayoutAttributeBottom) {
                constraint.constant = 0;
            }
        }
        [self.view layoutIfNeeded];
         self.button.transform = CGAffineTransformMakeRotation(M_PI - 0.01);

    } completion:^(BOOL finished) {
        categoryShow = YES;
    }];
}

-(void)closeCategory
{
    if (self.subCategoryView.hidden) { //已经隐藏
        return ;
    }
    [UIView animateWithDuration:0.5 animations:^{
        for (NSLayoutConstraint* constraint in self.view.constraints) {
            if (constraint.firstItem == self.productList && constraint.firstAttribute == NSLayoutAttributeBottom && constraint.secondItem == self.subCategoryView && constraint.secondAttribute == NSLayoutAttributeBottom) {
                constraint.constant = [self.productList bounds].size.height;
            }
        }
        [self.view layoutIfNeeded];
        self.button.transform = CGAffineTransformMakeRotation(0);
    } completion:^(BOOL finished) {
        self.subCategoryView.hidden = YES;
        categoryShow = NO;
    }];
    
}
#pragma mark - scroll catagory 

-(void)initScrollCatagory
{
    NSMutableArray* titles = [[NSMutableArray alloc] init];
    NSArray* arr = [[ShopModel instance] getSubCategorysByID:self.categoryID.integerValue];
    NSString* name = [[ShopModel instance] getIndexCategoryNameByID:self.categoryID.integerValue];
    [self setTitle:name];
    
    for (int i = 0; i < arr.count; ++i) {
        SubCategory* subCategory = arr[i];
        UITabBarItem* item = [[UITabBarItem alloc] initWithTitle:[NSString stringWithFormat:@"%@", subCategory.name] image:nil tag:subCategory.sub_category_id.integerValue];
        
        //未选中字体颜色
        [item setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18], NSForegroundColorAttributeName:UIColorFromRGB(LY_COLOR_BLACK)} forState:UIControlStateNormal];
        
        //选中字体颜色
        [item setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18], NSForegroundColorAttributeName:UIColorFromRGB(LY_COLOR_RED)} forState:UIControlStateSelected];

        [item setTitlePositionAdjustment:UIOffsetMake(0, -18)];
        
        [titles addObject:item];
    }

    CGRect rect = self.tabbar.frame;
    rect.size.width = TITLE_WIDTH * arr.count;
    [self.tabbar setFrame:rect];
    [self.tabbar setItemWidth:TITLE_WIDTH];
    [self.tabbar setItems:titles animated:NO];
    
    for (NSLayoutConstraint* constraint in self.tabbar.constraints) {
        if ([constraint.identifier isEqualToString: @"WIDTH"]) {
            constraint.constant = rect.size.width;
        }
    }
    
}


- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    [[CategoryDetailModel instance] updateCategoryDetailGoodsById:item.tag];
    [self closeCategory];
    [self adjustScroll];
}

- (void)adjustScroll
{
    long currentIndex = [self.tabbar.items indexOfObject:self.tabbar.selectedItem];
    float screenWidth = [[UIScreen mainScreen] bounds].size.width;
    float currentY = currentIndex * self.tabbar.itemWidth;
    float posY;
    if (currentY > screenWidth / 2) {
        posY = currentY - screenWidth / 2;
    }
    else{
        posY = 0;
    }
    float maxPos = self.scrollCatagory.contentSize.width - self.scrollCatagory.frame.size.width;
    if (posY > maxPos && maxPos > 0) {
        posY = maxPos;
    }
    CGPoint pos = CGPointMake(posY, 0);
    [self.scrollCatagory setContentOffset:pos animated:YES];
}
#pragma mark - collection

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    long count = 0;
    if ([[CategoryDetailModel instance] getGoodsCount]) {
        count = [[CategoryDetailModel instance] getGoodsCount];
    }
    return count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProductListCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ProductListCell"forIndexPath:indexPath];
    
    if (indexPath.row < [[CategoryDetailModel instance] getGoodsCount]) {
        DetailGoods* goods = [[CategoryDetailModel instance] getDetailGoodsByIndex:indexPath.row];
        [cell viewInitWith:goods];
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = CGSizeZero;
    
    size.width = [[UIScreen mainScreen] bounds].size.width / COLLECTION_WIDTH_COUNT - 1;
    
    size.height = COLLECTION_HEIGHT;
    
    return size;
}
//
//-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    ProductListCell * cell = (ProductListCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    
//    LYLog(@"点击%@", [cell description]);
//}

#pragma mask - notify

-(void)lyHandleNotification:(NSNotification *)notify
{
    if ([notify.name isEqualToString:NOTIFY_LIST_DATA]) {
        [self.productList reloadData];
    }
}

-(void)lyHandleEvent:(BaseEvent *)event
{
    if ([event isKindOfClass:[UISubCategoryChooseEvent class]]) {
        UISubCategoryChooseEvent* subEvent = (UISubCategoryChooseEvent*)event;
        for (UITabBarItem* item in self.tabbar.items) {
            if (item.tag == subEvent.sub_category_id) {
                [self.tabbar setSelectedItem:item];
                [self tabBar:self.tabbar didSelectItem:item]; //manul
                break;
            }
        }
    }
    else if([event isKindOfClass:[UIPressGoodsViewEvent class]]){
        if (self.navigationController.visibleViewController == self) {
            
            UIPressGoodsViewEvent* pressEvent = (UIPressGoodsViewEvent*)event;
            GoodsDetailController* controller = [self.storyboard instantiateViewControllerWithIdentifier:@"GoodsDetailController"];
            if (controller) {
                controller.goods = pressEvent.goods;
                [self presentViewController:controller animated:YES completion:^{
//                    LYLog(@"end");
                }];
            }

        }
    }
}

@end
