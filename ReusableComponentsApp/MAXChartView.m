//
//  MAXChartView.m
//  ReusableComponentsApp
//
//  Created by Mathieu Skulason on 19/06/16.
//  Copyright © 2016 Konta ehf. All rights reserved.
//

#import "MAXChartView.h"
#import "MAXChartColumn.h"
#import "MAXChartIndexPath.h"

@interface MAXChartView () {
    
    NSInteger _numSections;
    NSInteger _numRows;
    
    NSMutableArray <MAXChartColumn *> *_reusableBarViews;
    
    NSArray <NSArray <NSNumber *> *> *_chartData;
    
    
    
}

@end

@implementation MAXChartView

-(id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame: frame]) {
        
    }
    
    return self;
}

-(void)p_setup {
    
}

-(void)reloadData {
    
    _chartData = [self p_populateChartData];
    _chartData = [self p_normalizeChartData: _chartData];
    
}

#pragma mark - Chart Data Population

-(NSArray <NSArray <NSNumber *> *> *)p_populateChartData {
    
    NSMutableArray *tmpChartData = [NSMutableArray array];
    
    NSUInteger numSections = [self p_numberOfSections];
    
    
    for (int section = 0; section < numSections; section++) {
        
        NSUInteger numColumnsInSection = [self p_numberOfColumnsInSection: section];
        NSMutableArray *tmpSectionData = [NSMutableArray array];
        
        for (int column = 0; column < numColumnsInSection; column++) {
            
            double columnValue = [self.datasource MAXChartView: self valueAtIndexPath: [MAXChartIndexPath MAXChartIndexPathWithSection: section column: column] ];
            NSNumber *columnNumber = [NSNumber numberWithDouble: columnValue];
            [tmpSectionData addObject: columnNumber];
            
        }
        
        [tmpChartData addObject: tmpSectionData];
        
    }
    
    return tmpChartData;
}

/**
 @description This function normalizes the chart data based on a maximum value from delegation, or if the delegate method is not implemented it uses the highest value in the chart data as the normalizing value. All values will be in the range [0, 1]
 */
-(NSArray <NSArray <NSNumber *> *> *)p_normalizeChartData:(NSArray *)theChartData {
    
    double highestValue = 0;
    
    if ([self.delegate respondsToSelector: @selector(MAXHighestValueForChartView:)] == YES) {
        highestValue = [self.delegate MAXHighestValueForChartView: self];
    }
    else {
        highestValue = [self p_findHighestValueInChartData: theChartData];
    }
    
    NSMutableArray *tmpChartData = [NSMutableArray array];
    
    for (NSArray *section in theChartData) {
        
        NSMutableArray *newSection = [NSMutableArray array];
        
        for (NSNumber *columnValue in section) {
            
            double oldValue = [columnValue doubleValue];
            double newValue = oldValue / highestValue;
            
            if (newValue > 1.0) {
                newValue = 1.0;
            }
            
            NSNumber *newNumber = [NSNumber numberWithDouble: newValue];
            [newSection addObject: newNumber];
        }
        
        [tmpChartData addObject: newSection];
    }
    
    return tmpChartData;
}

-(NSUInteger)p_numberOfSections {
    
    if ([self.datasource respondsToSelector:@selector(MAXNumberOfSectionsInChartView:)] == YES) {
        
        return [self.datasource MAXNumberOfSectionsInChartView: self];
    }
    
    return 1;
}

-(NSUInteger)p_numberOfColumnsInSection:(NSUInteger)theSection {
    
    return [self.datasource MAXChartView: self numberOfColumnsInSection: theSection];
}

-(double)p_findHighestValueInChartData:(NSArray <NSArray <NSNumber *> *> *)theChartData {
    
    double highestValue = 0;
    for (NSArray <NSNumber *> *section in theChartData) {
        
        for (NSNumber *columnValue in section) {
            
            if (highestValue < [columnValue doubleValue]) {
                highestValue = [columnValue doubleValue];
            }
            
        }
        
    }
    
    return highestValue;
}

#pragma mark - Column Views Creation & Positioning

-(void)p_updateReusableViews:(NSMutableArray <MAXChartColumn *> *)theReusableViews {
    
    NSUInteger numColumns = [self p_numColumnsInChart];
    
    if (theReusableViews.count < numColumns) {
        NSInteger diff = numColumns - theReusableViews.count;
        for (int i = 0; i < diff; i++) {
            MAXChartColumn *column = [[MAXChartColumn alloc] init];
            [self addSubview: column];
            [theReusableViews addObject: column];
        }
    }
}

-(void)p_hideUnusedReusableViews:(NSMutableArray <MAXChartColumn *> *)theReusableViews {
    
    NSUInteger numColumns = [self p_numColumnsInChart];
    
    if (theReusableViews.count >= numColumns) {
        
        for (int i = (int)numColumns - 1; i < theReusableViews.count; i++) {
            MAXChartColumn *column = [theReusableViews objectAtIndex: i];
            column.hidden = YES;
        }
        
    }
    
}

#pragma mark - Private helpers

-(NSUInteger)p_numColumnsInChart {
    
    NSUInteger numColumns = 0;
    for (NSArray *sections in _chartData) {
        numColumns += sections.count;
    }
    
    return numColumns;
}

/**
 @description if the chart has not got fixed row and section space it has dynamic spacing between them. This checks to see if the delegate responds to dynamic row or section space.
 */
-(BOOL)isDynamicChart {
    
    /*
    if ([self.dele]) {
        <#statements#>
    }
    */
    return NO;
}

@end
