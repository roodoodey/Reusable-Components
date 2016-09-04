//
//  MAXExo2FontTests.m
//  ReusableComponentsApp
//
//  Created by Mathieu Skulason on 04/09/16.
//  Copyright © 2016 Konta ehf. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UIFont+Exo2.h"

@interface MAXExo2FontTests : XCTestCase

@end

@implementation MAXExo2FontTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExo2 {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    UIFont *exo2Black = [UIFont c_exo2BlackWithSize: 15.0];
    UIFont *exo2BlackIt = [UIFont c_exo2BlackItalicWithSize: 15.0];
    UIFont *exo2Bold = [UIFont c_exo2BoldWithSize: 15.0];
    UIFont *exo2BoldIt = [UIFont c_exo2BoldItalicWithSize: 15.0];
    UIFont *exo2ExtraBold = [UIFont c_exo2ExtraBoldWithSize: 15.0];
    UIFont *exo2ExtraBoldIt = [UIFont c_exo2ExtraBoldItalicWithSize: 15.0];
    UIFont *exo2ExtraLight = [UIFont c_exo2ExtraLightWithSize: 15.0];
    UIFont *exo2ExtraLightIt = [UIFont c_exo2ExtraLightItalicWithSize: 15.0];
    UIFont *exo2It = [UIFont c_exo2ItalicWithSize: 15.0];
    UIFont *exo2Light = [UIFont c_exo2LightWithSize: 15.0];
    UIFont *exo2LightIt = [UIFont c_exo2LightItalicWithSize: 15.0];
    UIFont *exo2Medium = [UIFont c_exo2MediumWithSize: 15.0];
    UIFont *exo2MediumIt = [UIFont c_exo2MediumItalicWithSize: 15.0];
    UIFont *exo2Regular = [UIFont c_exo2RegularWithSize: 15.0];
    UIFont *exo2SemiBold = [UIFont c_exo2SemiBoldWithSize: 15.0];
    UIFont *exo2SemiBoldIt = [UIFont c_exo2SemiBoldItalicWithSize: 15.0];
    UIFont *exo2Thin = [UIFont c_exo2ThinWithSize: 15.0];
    UIFont *exo2ThinIt = [UIFont c_exo2ThinItalicWithSize: 15.0];
    
    XCTAssertNotNil( exo2Black );
    XCTAssertNotNil( exo2BlackIt );
    XCTAssertNotNil( exo2Bold );
    XCTAssertNotNil( exo2BoldIt );
    XCTAssertNotNil( exo2ExtraBold );
    XCTAssertNotNil( exo2ExtraBoldIt );
    XCTAssertNotNil( exo2ExtraLight );
    XCTAssertNotNil( exo2ExtraLightIt );
    XCTAssertNotNil( exo2It );
    XCTAssertNotNil( exo2Light );
    XCTAssertNotNil( exo2LightIt );
    XCTAssertNotNil( exo2Medium );
    XCTAssertNotNil( exo2MediumIt );
    XCTAssertNotNil( exo2Regular );
    XCTAssertNotNil( exo2SemiBold );
    XCTAssertNotNil( exo2SemiBoldIt );
    XCTAssertNotNil( exo2Thin );
    XCTAssertNotNil( exo2ThinIt );
    
}



@end
