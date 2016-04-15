//
//  MAXRobotoFontTests.m
//  ReusableComponentsApp
//
//  Created by Mathieu Skulason on 28/02/16.
//  Copyright © 2016 Konta ehf. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UIFont+MAXRobotoExtension.h"

@interface MAXRobotoFontTests : XCTestCase

@end

@implementation MAXRobotoFontTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testRoboto {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    UIFont *robotoUltraBold = [UIFont c_robotoUltraBoldWithSize:15.0];
    UIFont *robotoUltraBoldItalic = [UIFont c_robotoUltraBoldItalicWithSize:15.0];
    UIFont *robotoBold = [UIFont c_robotoBoldWithSize:15.0];
    UIFont *robotoBoldItalic = [UIFont c_robotoBoldItalicWithSize:15.0];
    UIFont *robotoMedium = [UIFont c_robotoMediumWithSize:15.0];
    UIFont *robotoMediumItalic = [UIFont c_robotoMediumItalicWithSize:15.0];
    UIFont *roboto = [UIFont c_robotoWithSize:15.0];
    UIFont *robotoItalic = [UIFont c_robotoItalicWithSize:15.0];
    UIFont *robotoLight = [UIFont c_robotoLightWithSize:15.0];
    UIFont *robotoLightItalic = [UIFont c_robotoLightItalicWithSize:15.0];
    UIFont *robotoThin = [UIFont c_robotoThinWithSize:15.0];
    UIFont *robotoThinItalic = [UIFont c_robotoThinItalicWithSize:15.0];
    
    XCTAssertNotNil(robotoUltraBold);
    XCTAssertNotNil(robotoUltraBoldItalic);
    XCTAssertNotNil(robotoBold);
    XCTAssertNotNil(robotoBoldItalic);
    XCTAssertNotNil(robotoMedium);
    XCTAssertNotNil(robotoMediumItalic);
    XCTAssertNotNil(roboto);
    XCTAssertNotNil(robotoItalic);
    XCTAssertNotNil(robotoLight);
    XCTAssertNotNil(robotoLightItalic);
    XCTAssertNotNil(robotoThin);
    XCTAssertNotNil(robotoThinItalic);
    
}

@end
