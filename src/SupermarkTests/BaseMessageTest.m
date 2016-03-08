//
//  BaseMessageTest.m
//  Supermark
//
//  Created by 林伟池 on 15/9/15.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
//#import "AllMessage.h"

@interface BaseMessageTest : XCTestCase

@end

@implementation BaseMessageTest

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
    
//    ShopMessage* message = [ShopMessage instance];
//    XCTAssertEqual([message class], [ShopMessage class], @"instance 应该返回类实例");
//    
//    message = [ShopMessage backgroundInstance];
//    XCTAssertEqual(message.background, YES, @"backgroundInstance 返回background实例");
    
        
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
