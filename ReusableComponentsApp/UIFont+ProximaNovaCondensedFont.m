//
//  UIFont+ProximaNovaCondensedFont.m
//  ReusableComponentsApp
//
//  Created by Mathieu Skulason on 03/09/16.
//  Copyright © 2016 Konta ehf. All rights reserved.
//

#import "UIFont+ProximaNovaCondensedFont.h"

@implementation UIFont (ProximaNovaCondensedFont)

+(UIFont *)c_proximaNovaCondensedLightWithSize:(float)theSize {
    
    return [UIFont fontWithName:@"ProximaNovaCond-Light" size:theSize];
}

+(UIFont *)c_proximaNovaCondensedLightItalicWithSize:(float)theSize {
    
    return [UIFont fontWithName:@"ProximaNovaCond-LightIt" size:theSize];
}

+(UIFont *)c_proximaNovaCondensedRegularWithSize:(float)theSize {
    
    return [UIFont fontWithName:@"ProximaNovaCond-Regular" size:theSize];
}

+(UIFont *)c_proximaNovaCondensedRegularItalicWithSize:(float)theSize {
    
    return [UIFont fontWithName:@"ProximaNovaCond-RegularIt" size:theSize];
}

+(UIFont *)c_proximaNovaCondensedSemiboldWithSize:(float)theSize {
    
    return [UIFont fontWithName:@"ProximaNovaCond-Semibold" size:theSize];
}

+(UIFont *)c_proximaNovaCondensedSemiboldItalicWithSize:(float)theSize {
    
    return [UIFont fontWithName:@"ProximaNovaCond-SemiboldIt" size:theSize];
}

@end
