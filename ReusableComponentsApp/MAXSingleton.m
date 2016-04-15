//
//  MAXSingleton.m
//  ReusableComponentsApp
//
//  Created by Mathieu Skulason on 05/03/16.
//  Copyright © 2016 Konta ehf. All rights reserved.
//

#import "MAXSingleton.h"

@implementation MAXSingleton

+(instancetype)sharedInstance {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}


@end
