//
//  UIColor+ProximaNovaFont.m
//  ReusableComponentsApp
//
//  Created by Mathieu Skulason on 01/09/16.
//  Copyright © 2016 Konta ehf. All rights reserved.
//

#import "UIColor+ProximaNovaFont.h"

@implementation UIColor (ProximaNovaFont)

+(UIFont *)c_proximaNovaBlackWithSize:(float)theSize {
    
    return [UIFont fontWithName:@"ProximaNova-Black" size:theSize];
}

+(UIFont *)c_proximaNovaBoldWithSize:(float)theSize {
    
    return [UIFont fontWithName:@"ProximaNova-Bold" size:theSize];
}

+(UIFont *)c_proximaNovaBoldItalicWithSize:(float)theSize {
    
    return [UIFont fontWithName:@"ProximaNova-BoldIt" size:theSize];
}

+(UIFont *)c_proximaNovaExtraBoldWithSize:(float)theSize {
    
    return [UIFont fontWithName:@"ProximaNova-Extrabold" size:theSize];
}

+(UIFont *)c_proximaNovaLightWithSize:(float)theSize {
    
    return [UIFont fontWithName:@"ProximaNova-Light" size:theSize];
}

+(UIFont *)c_proximaNovaLightItalicWithSize:(float)theSize {
    
    return [UIFont fontWithName:@"ProximaNova-LightItalic" size:theSize];
}

+(UIFont *)c_proximaNovaRegularWithSize:(float)theSize {
    
    return [UIFont fontWithName:@"ProximaNova-Regular" size:theSize];
}

+(UIFont *)c_proximaNovaRegularItalicWithSize:(float)theSize {
    
    return [UIFont fontWithName:@"ProximaNova-RegularItalic" size:theSize];
}

+(UIFont *)c_proximaNovaSemiboldWithSize:(float)theSize {
    
    return [UIFont fontWithName:@"ProximaNova-Semibold" size:theSize];
}

+(UIFont *)c_proximaNovaSemiboldItalicWithSize:(float)theSize {
    
    return [UIFont fontWithName:@"ProximaNova-SemiboldItalic" size:theSize];
}

@end
