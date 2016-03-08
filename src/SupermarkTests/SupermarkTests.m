//
//  SupermarkTests.m
//  SupermarkTests
//
//  Created by 林伟池 on 15/7/26.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "AllModel.h"
#import "AppDelegate.h"

@interface SupermarkTests : XCTestCase

@end

@implementation SupermarkTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
   // LYLog(@"%@", [[CartModel instance] getCartGoodsByIndex:0]);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testInput{
    AppDelegate* delegate = [[UIApplication sharedApplication] delegate];
    UIWindow *window = delegate.window;
    UIViewController* viewController = [self getCurrentVC];
//    viewController.textField.placeholder = @"请输入...";
    [NSDate distantPast];
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:10]];
    XCTAssertTrue([[ShopModel instance] getCurrentCategoryCount]>0, @"textField had not input");
}


- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}
@end
