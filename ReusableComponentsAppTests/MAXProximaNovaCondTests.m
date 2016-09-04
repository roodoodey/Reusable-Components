//
//  MAXProximaNovaCondTests.m
//  ReusableComponentsApp
//
//  Created by Mathieu Skulason on 03/09/16.
//  Copyright © 2016 Konta ehf. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UIFont+ProximaNovaCondensedFont.h"

@interface MAXProximaNovaCondTests : XCTestCase

@end

@implementation MAXProximaNovaCondTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testProximaNovaCond {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    UIFont *proximaLight = [UIFont c_proximaNovaCondensedLightWithSize: 15.0];
    UIFont *proximaLightIt = [UIFont c_proximaNovaCondensedLightItalicWithSize: 15.0];
    UIFont *proximaRegular = [UIFont c_proximaNovaCondensedRegularWithSize: 15.0];
    UIFont *proximaRegularIt = [UIFont c_proximaNovaCondensedRegularItalicWithSize: 15.0];
    UIFont *proximaSemibold = [UIFont c_proximaNovaCondensedSemiboldWithSize: 15.0];
    UIFont *proximaSemiboldIt = [UIFont c_proximaNovaCondensedSemiboldItalicWithSize: 15.0];
    
    XCTAssertNotNil(proximaLight);
    XCTAssertNotNil(proximaLightIt);
    XCTAssertNotNil(proximaRegular);
    XCTAssertNotNil(proximaRegularIt);
    XCTAssertNotNil(proximaSemibold);
    XCTAssertNotNil(proximaSemiboldIt);
    
}


@end
