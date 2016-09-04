//
//  MAXProximaNoveFontTests.m
//  ReusableComponentsApp
//
//  Created by Mathieu Skulason on 03/09/16.
//  Copyright © 2016 Konta ehf. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UIFont+ProximaNovaFont.h"

@interface MAXProximaNoveFontTests : XCTestCase

@end

@implementation MAXProximaNoveFontTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testProxima {
    
    UIFont *proximaBlack = [UIFont c_proximaNovaBlackWithSize:15.0];
    UIFont *proximaBold = [UIFont c_proximaNovaBoldWithSize:15.0];
    UIFont *proximaBoldIt = [UIFont c_proximaNovaBoldItalicWithSize:15.0];
    UIFont *proximaExtrabold = [UIFont c_proximaNovaExtraBoldWithSize:15.0];
    UIFont *proximaLight = [UIFont c_proximaNovaLightWithSize:15.0];
    UIFont *proximaLightIt = [UIFont c_proximaNovaLightItalicWithSize:15.0];
    UIFont *proximaRegular = [UIFont c_proximaNovaRegularWithSize:15.0];
    UIFont *proximaRegularIt = [UIFont c_proximaNovaRegularItalicWithSize:15.0];
    UIFont *proximaNovaSemibold = [UIFont c_proximaNovaSemiboldWithSize:15.0];
    UIFont *proximaNovaSemiboldIt = [UIFont c_proximaNovaSemiboldItalicWithSize:15.0];
    
    XCTAssertNotNil(proximaBlack);
    XCTAssertNotNil(proximaBold);
    XCTAssertNotNil(proximaBoldIt);
    XCTAssertNotNil(proximaExtrabold);
    XCTAssertNotNil(proximaLight);
    XCTAssertNotNil(proximaLightIt);
    XCTAssertNotNil(proximaRegular);
    XCTAssertNotNil(proximaRegularIt);
    XCTAssertNotNil(proximaNovaSemibold);
    XCTAssertNotNil(proximaNovaSemiboldIt);
    
}

@end
