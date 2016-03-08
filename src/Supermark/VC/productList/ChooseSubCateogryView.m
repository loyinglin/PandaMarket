//
//  ChooseSubCateogryView.m
//  Supermark
//
//  Created by 林伟池 on 15/8/31.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import "ChooseSubCateogryView.h"
#import "ShopModel.h"
#import "NSObject+LYNotification.h"
#import "UIConstant.h"

@implementation ChooseSubCateogryView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

static long COLLECTION_HEIGHT = 50;
static long COLLECTION_WIDTH_COUNT = 2;

#pragma mark - view init

#pragma mark - ui

#pragma mark - delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return ([[ShopModel instance] getSubCategorysByID:self.category_id].count);
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = CGSizeZero;
    
    size.width = [[UIScreen mainScreen] bounds].size.width / COLLECTION_WIDTH_COUNT - 1;
    
    size.height = COLLECTION_HEIGHT;
    
    return size;
}


// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"sub_category" forIndexPath:indexPath];
    
    UILabel* label = (UILabel*)[cell viewWithTag:DEFAULT_VIEW_TAG];
    if (label) {
        NSArray* arr = [[ShopModel instance] getSubCategorysByID:self.category_id];
        if (arr && arr.count > indexPath.row) {
            label.text = ((SubCategory*)arr[indexPath.row]).name;
        }
        else{
            label.text = [NSString stringWithFormat:@"暂无详情%ld", indexPath.row];
        }
    }
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UISubCategoryChooseEvent* event = [UISubCategoryChooseEvent instance];
    
    NSArray* arr = [[ShopModel instance] getSubCategorysByID:self.category_id];
    SubCategory* category = [arr objectAtIndex:indexPath.row];
    event.sub_category_id = category.sub_category_id.integerValue;
    [self lyPostEvent:event];
    LYLog(@"click %ld", (long)indexPath.row);
}

#pragma mark - notify

@end
