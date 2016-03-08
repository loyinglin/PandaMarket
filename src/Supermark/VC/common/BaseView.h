//
//  BaseView.h
//  PandaMarket
//
//  Created by 林伟池 on 15/10/9.
//  Copyright © 2015年 林伟池. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LYUserOperation){
    LYUserClick,
    LYUserLongPress,
};

@class BaseView;

@protocol LYUIViewDelegate <NSObject>

- (id)getUserData:(BaseView*)lyView Param:(id)viewParam;

- (void)onUserOperation:(BaseView*)lyView Operation:(LYUserOperation)operationParam;

@end

@interface BaseView : UIView

#pragma mark - init

@property (nonatomic, weak)IBOutlet id<LYUIViewDelegate> delegate;

#pragma mark - set



#pragma mark - get



#pragma mark - update



#pragma mark - message

@end
