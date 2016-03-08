//
//  BaseDataSource.m
//  PandaMarket
//
//  Created by 林伟池 on 15/10/14.
//  Copyright © 2015年 林伟池. All rights reserved.
//

#import "BaseTableViewDataSource.h"


@implementation BaseTableViewDataSource
{
    NSArray* myDataItems;
    NSString* myIdentififer;
    ConfigCallback myConfig;
    SelectCallback mySelect;
    __weak UITableView* myTableView;
    NSString* myEmptyTips;
    
}

- (instancetype)initWithItems:(NSArray *)arr Identifier:(NSString *)identifier{
    self = [super init];
    myDataItems = arr;
    myIdentififer = identifier;
    return self;
}

- (void)setConfigCallBack:(ConfigCallback)callback{
    myConfig = callback;
}

- (void)setSelectCallBack:(SelectCallback)callback{
    mySelect = callback;
}

- (void)setEmptyTips:(NSString *)emptyTips TableView:(__weak UITableView *)tableView
{
    myEmptyTips = emptyTips;
    myTableView = tableView;
}

- (NSInteger)tableView:(UITableView*)tableView
 numberOfRowsInSection:(NSInteger)section {
    if (myEmptyTips && myTableView) {
        [self lyShowEmptyTips];
    }
    return myDataItems.count;
}

- (void)lyShowEmptyTips
{
    if (myDataItems.count) {
        myTableView.backgroundView = nil;
    }
    else{
        UILabel* messageLabel = [UILabel new];
        messageLabel.text = myEmptyTips;
        messageLabel.textColor = [UIColor lightGrayColor];
        messageLabel.textAlignment = NSTextAlignmentCenter;
        [messageLabel sizeToFit];
        
        myTableView.backgroundView = messageLabel;
    }
}

- (UITableViewCell*)tableView:(UITableView*)tableView
        cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:myIdentififer
                                              forIndexPath:indexPath];
    if (indexPath.row < myDataItems.count) {
        if (myConfig) {
            myConfig(cell, myDataItems[indexPath.row]);
        }
        else if ([cell respondsToSelector:@selector(lyInit:)]) {
            [cell performSelector:@selector(lyInit:) withObject:myDataItems[indexPath.row]];
        }
    }
    else{
        LYLog(@"%@没有初始化", [cell description]); 
    }
    return cell;
}


- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (mySelect) {
        LYLog(@"%d", indexPath.row);
        LYLog(@"%@", myDataItems[indexPath.row]);
        mySelect(indexPath.row, myDataItems[indexPath.row]);
    }
    return nil;
}

@end
