//
//  ShopModelTest.m
//  Supermark
//
//  Created by 林伟池 on 15/9/14.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "ShopModel.h"

@interface ShopModelTest : XCTestCase

@end

@implementation ShopModelTest
{
    BOOL bDataBack;
}
- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    [self lyObserveNotification:NOTIFY_INDEX_DATA];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testShopModelNil{
    NSRunLoop* current = [NSRunLoop currentRunLoop];
    NSRunLoop* main = [NSRunLoop mainRunLoop];
    //    [NSDate distantFuture]
//    while (!bDataBack) {
//        LYLog(@"while waiting data");
//        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
//        
//    }
//    XCTAssertNotNil([[ShopModel instance] getCurrentMerchantBase], @"ShopModel should not be nil");
}


#pragma mark - notify

-(void)lyHandleNotification:(NSNotification *)notify
{
    if ([notify.name isEqualToString:NOTIFY_INDEX_DATA]) {
        bDataBack = YES;
    }
}

@end
