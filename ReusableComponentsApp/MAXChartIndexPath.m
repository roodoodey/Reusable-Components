//
//  MAXChartIndexPath.m
//  ReusableComponentsApp
//
//  Created by Mathieu Skulason on 20/06/16.
//  Copyright © 2016 Konta ehf. All rights reserved.
//

#import "MAXChartIndexPath.h"

@implementation MAXChartIndexPath

+(instancetype)MAXChartIndexPathWithSection:(NSUInteger)theSection column:(NSUInteger)theColumn {
    
    MAXChartIndexPath *indexPath = [[MAXChartIndexPath alloc] initWithSection: theSection column: theColumn];
    
    return indexPath;
}

-(id)initWithSection:(NSUInteger)theSection column:(NSUInteger)theColumn {
    
    if (self = [super init]) {
        _section = theSection;
        _column = theColumn;
    }
    
    return self;
}

@end
