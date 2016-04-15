//
//  MAXSystemFontsCategoryTests.m
//  ReusableComponentsApp
//
//  Created by Mathieu Skulason on 28/02/16.
//  Copyright © 2016 Konta ehf. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UIFont+MAXSystemFonts.h"

@interface MAXSystemFontsCategoryTests : XCTestCase

@end

@implementation MAXSystemFontsCategoryTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark - Arial

- (void)testArialFont {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    UIFont *arialBold = [UIFont c_arialBoldWithSize:15.0];
    
    XCTAssertNotNil(arialBold);
    
    UIFont *arial = [UIFont c_arialWithSize:15.0];
    
    XCTAssertNotNil(arial);
    
    UIFont *arialItalic = [UIFont c_arialItalicWithSize:15.0];
    
    XCTAssertNotNil(arialItalic);
    
    UIFont *arialBoldItalic = [UIFont c_arialBoldItalicWithSize:15.0];
    
    XCTAssertNotNil(arialBoldItalic);
    
}

-(void)testHelveticaNeueFont {
    
    UIFont *helveticaNeue = [UIFont c_helveticaNeueWithSize:15.0];
    UIFont *helveticaNeueItalic = [UIFont c_helveticaNeueItalicWithSize:15.0];
    UIFont *helveticaNeueBold = [UIFont c_helveticaNeueBoldWithSize:15.0];
    UIFont *helveticaNeueBoldItalic = [UIFont c_helveticaNeueBoldItalicWithSize:15.0];
    UIFont *helveticaNeueMedium = [UIFont c_helveticaNeueMediumWitihSize:15.0];
    UIFont *helveticaNeueMediumItalic = [UIFont c_helveticaNeueMediumItalicWithSize:15.0];
    UIFont *helveticaNeueLight = [UIFont c_helveticaNeueLightWithSize:15.0];
    UIFont *helveticaNeueLightItalic = [UIFont c_helveticaNeueLightItalicWithSize:15.0];
    UIFont *helveticaNeueUltraLight = [UIFont c_helveticaNeueUltraLightItalicWithSize:15.0];
    UIFont *helveticaNeueUltraLightItalic = [UIFont c_helveticaNeueUltraLightItalicWithSize:15.0];
    UIFont *helveticaNeueThin = [UIFont c_helveticaNeueThinWithSize:15.0];
    UIFont *helveticaNeueThinItalic = [UIFont c_helveticaNeueThinItalicWithSize:15.0];
    
    XCTAssertNotNil(helveticaNeue);
    XCTAssertNotNil(helveticaNeueItalic);
    XCTAssertNotNil(helveticaNeueBold);
    XCTAssertNotNil(helveticaNeueBoldItalic);
    XCTAssertNotNil(helveticaNeueMedium);
    XCTAssertNotNil(helveticaNeueMediumItalic);
    XCTAssertNotNil(helveticaNeueLight);
    XCTAssertNotNil(helveticaNeueLightItalic);
    XCTAssertNotNil(helveticaNeueUltraLight);
    XCTAssertNotNil(helveticaNeueUltraLightItalic);
    XCTAssertNotNil(helveticaNeueThin);
    XCTAssertNotNil(helveticaNeueThinItalic);
    
}

-(void)testNoteWorthyFont {
    
    UIFont *noteworthyLight = [UIFont c_noteworthyLightWithSize:15.0];
    UIFont *noteworthyBold = [UIFont c_noteworthyBoldWithSize:15.0];
    
    XCTAssertNotNil(noteworthyLight);
    XCTAssertNotNil(noteworthyBold);
    
}

-(void)testAppleSDGothicNeoFont {
    
    UIFont *appleSDGothicNeoBold = [UIFont c_appleSDGothicNeoBoldWithSize:15.0];
    UIFont *appleSDGothicNeoSemiBold = [UIFont c_appleSDGothicNeoSemiBoldWithSize:15.0];
    UIFont *appleSDGothicNeoMedium = [UIFont c_appleSDGothicNeoMediumWithSize:15.0];
    UIFont *appleSDGothicNeoRegular = [UIFont c_appleSDGothicNeoRegularWithSize:15.0];
    UIFont *appleSDGothicNeoLight = [UIFont c_appleSDGothicNeoLightWithSize:15.0];
    UIFont *appleSDGothicNeoThin = [UIFont c_appleSDGothicNeoThinWithSize:15.0];
    
    XCTAssertNotNil(appleSDGothicNeoBold);
    XCTAssertNotNil(appleSDGothicNeoSemiBold);
    XCTAssertNotNil(appleSDGothicNeoMedium);
    XCTAssertNotNil(appleSDGothicNeoRegular);
    XCTAssertNotNil(appleSDGothicNeoLight);
    XCTAssertNotNil(appleSDGothicNeoThin);
    
}

@end
