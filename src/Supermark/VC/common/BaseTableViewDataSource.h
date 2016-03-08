//
//  BaseDataSource.h
//  PandaMarket
//
//  Created by 林伟池 on 15/10/14.
//  Copyright © 2015年 林伟池. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^ConfigCallback)(UITableViewCell* cell, id data);
typedef void(^SelectCallback)(long index, id data);

/**
    一个标准的tableView
    只有常用的操作可以放在这里面
 */
@interface BaseTableViewDataSource : NSObject<UITableViewDataSource, UITableViewDelegate>




-(instancetype)initWithItems:(NSArray*)arr  Identifier:(NSString*)identifier;

/**
 *  设置选择中的回调block  这里持有的是弱引用
 *
 *  @param callback <#callback description#>
 */
- (void)setSelectCallBack:(SelectCallback)callback;

- (void)setConfigCallBack:(ConfigCallback)callback;

- (void)setEmptyTips:(NSString *)emptyTips TableView:(__weak UITableView*)tableView;

@end
