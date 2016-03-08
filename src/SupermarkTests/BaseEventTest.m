//
//  BaseEventTest.m
//  Supermark
//
//  Created by 林伟池 on 15/9/15.
//  Copyright (c) 2015年 林伟池. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "AllEvent.h"

@interface BaseEventTest : XCTestCase

@end

@implementation BaseEventTest

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
//    XCTAssert(YES, @"Pass");
//    ErrorRequestTimedOutEvent* event = [ErrorRequestTimedOutEvent instance];
//    XCTAssertEqual([event class], [ErrorRequestTimedOutEvent class], @"event instance应该返回实例");
//    
//    XCTAssert([[event toNotifyString] isEqualToString:[[ErrorRequestTimedOutEvent class] description]], @"notifyName 应该返回类名");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
