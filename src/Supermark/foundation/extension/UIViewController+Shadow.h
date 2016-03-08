//
//  UIViewController+Shadow.h
//  Supermark
//
//  Created by 林伟池 on 15/8/29.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^OnShadowClose)(void);

@protocol LYShadowDelegate <NSObject>
@required
-(void)shadowCloseFrom:(id)sender;

-(void)setShadowWithView:(UIView*)view OnshadowClose:(OnShadowClose)onClose;
@end

@interface UIViewController (Shadow)
-(UIView*)lySetShadowWithView:(UIView*)view;
-(void)lyCloseShadowWithView:(UIView*)view OnShadowClose:(OnShadowClose)onClose;
@end
