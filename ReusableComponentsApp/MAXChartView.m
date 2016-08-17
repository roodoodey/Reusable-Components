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
    
    NSMutableArray <UIView *> *columnDecorationViews;
    NSMutableArray <UIView *> *sectionSpaceDecorationViews;
    NSMutableArray <UIView *> *columnSpaceDecorationViews;
    
    NSArray <NSArray <NSNumber *> *> *_chartData;
    
}

@end

@implementation MAXChartView

-(id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame: frame]) {
        
        _reusableBarViews = [NSMutableArray array];
        
    }
    
    return self;
}

-(void)p_setup {
    
}

-(void)reloadData {
    
    _chartData = [self p_populateChartData];
    _chartData = [self p_normalizeChartData: _chartData];
    
    // creation of decoration views
    [self p_setupSectionSpaceDecorationViews: sectionSpaceDecorationViews chartData: _chartData];
    
    // creation and column view setup
    [self p_updateReusableViews: _reusableBarViews];
    [self p_hideUnusedReusableViews: _reusableBarViews];
    
    
    [self p_positionViews:_reusableBarViews sectionSpaceDecorationViews: sectionSpaceDecorationViews chartData: _chartData];
    
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
-(NSArray <NSArray <NSNumber *> *> *)p_normalizeChartData:(NSArray <NSArray <NSNumber *> *> *)theChartData {
    
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

#pragma mark - Column and view creation

-(void)p_setupSectionSpaceDecorationViews:(NSMutableArray <UIView *> *)theSectionSpaceDecorationViews chartData:(NSArray <NSArray <NSNumber *> *> *)theChartData {
    
    if ([self.delegate respondsToSelector:@selector(MAXChartView:sectionSpaceDecorationView:section:)] == YES) {
        
        for (UIView *view in theSectionSpaceDecorationViews) {
            [view removeFromSuperview];
        }
        
        theSectionSpaceDecorationViews = [NSMutableArray array];
        
        for (int section = 0; section < theChartData.count + 1; section++) {
            
            UIView *newView = [[UIView alloc] init];
            [self addSubview: newView];
            
            [theSectionSpaceDecorationViews addObject: newView];
            
        }
        
    }
    
}

-(void)p_setupColumnSpaceDecorationViews:(NSMutableArray <UIView *> *)theColumnSpaceDecorationViews chartData:(NSArray <NSArray <NSNumber *> *> *)theChartData {
    
    if ([self.delegate respondsToSelector:@selector(MAXChartView:columnSpaceDecorationView:indexPath:)] == YES) {
        
        for (UIView *view in theColumnSpaceDecorationViews) {
            [view removeFromSuperview];
        }
        
        int numColumnSpaces = 0;
        for (int section = 0; section < theChartData.count ; section++) {
            
            NSArray *sectionData = [theChartData objectAtIndex: section];
            numColumnSpaces += sectionData.count - 1;
            
        }
        
        theColumnSpaceDecorationViews = [NSMutableArray array];
        
        for (int columns = 0; columns < numColumnSpaces; columns++) {
            
            UIView *newView = [[UIView alloc] init];
            [self addSubview: newView];
            
            [theColumnSpaceDecorationViews addObject: newView];
            
        }
        
    }
    
}

-(void)p_setupColumnDecorationViews:(NSMutableArray <UIView *> *)theColumnDecorationViews chartData:(NSArray <NSArray <NSNumber *> *> *)theChartData {
    
    if ([self.delegate respondsToSelector:@selector(MAXChartView:columnDecorationView:atIndexPath:)] == YES) {
        
        for (UIView *view in theColumnDecorationViews) {
            [view removeFromSuperview];
        }
        
        NSUInteger numColumns = [self p_numColumnsInChart];
        
        theColumnDecorationViews = [NSMutableArray array];
        
        for (int column = 0; column < numColumns; column++) {
            
            UIView *newView = [[UIView alloc] init];
            [self addSubview: newView];
            
            [theColumnDecorationViews addObject: newView];
            
        }
        
    }
    
}

-(void)p_updateReusableViews:(NSMutableArray <MAXChartColumn *> *)theReusableViews {
    
    NSUInteger numColumns = [self p_numColumnsInChart];
    
    if (theReusableViews.count < numColumns) {
        NSInteger diff = numColumns - theReusableViews.count;
        for (int i = 0; i < diff; i++) {
            
            MAXChartColumn *column = [[MAXChartColumn alloc] init];
            [self addSubview: column.backgroundView];
            [self addSubview: column.view];
            
            [theReusableViews addObject: column];
            
        }
    }
    
    
    
}

// MARK: Should unhide those that are not in use
-(void)p_hideUnusedReusableViews:(NSMutableArray <MAXChartColumn *> *)theReusableViews {
    
    NSUInteger numColumns = [self p_numColumnsInChart];
    
    if (theReusableViews.count >= numColumns) {
        
        for (int i = (int)numColumns - 1; i < theReusableViews.count; i++) {
            
            MAXChartColumn *column = [theReusableViews objectAtIndex: i];
            column.view.hidden = YES;
            column.backgroundView.hidden = YES;
            
        }
        
    }
    
    for (int i = 0; i < numColumns; i++) {
        
        MAXChartColumn *column = [theReusableViews objectAtIndex: i];
        column.view.hidden = NO;
        column.backgroundView.hidden = NO;
        
    }
    
}

#pragma mark - Positioning

-(void)p_positionViews:(NSArray <MAXChartColumn *> *)theReusableViews sectionSpaceDecorationViews:(NSMutableArray <UIView *> *)theSectionSpaceDecorationViews chartData:(NSArray <NSArray <NSNumber *> *> *)theChartData {
    
    CGFloat cumulatedPosition = 0;
    NSUInteger numColumn = 0;
    
    // MARK: Add the ability to offset the first column and the last by adding width.
    
    for (int section = 0; section < theChartData.count; section++) {
        
        NSArray *sectionData = [theChartData objectAtIndex: section];
        
        // add space right away before the section
        CGFloat sectionSize = [self.delegate MAXChartView: self spaceForSection: section];
        
        
        cumulatedPosition += sectionSize;
        
        for (int column = 0; column < sectionData.count; column++) {
            
            MAXChartIndexPath *indexPath = [MAXChartIndexPath MAXChartIndexPathWithSection: section column: column];
            
            // position column views
            cumulatedPosition += [self p_positionColumnView: [theReusableViews objectAtIndex: numColumn] value: [[sectionData objectAtIndex: column] doubleValue] cumulatedPos: cumulatedPosition atIndexPath: indexPath];
            
            
            // add space between columns
            if (column != sectionData.count - 1) {
                cumulatedPosition += [self.delegate MAXChartView: self spaceForColumnAtIndexPath: indexPath];
            }
            
            // holds track of the column in the reusable views
            numColumn += 1;
        }
        
        // add space after the last section
        if (section != theChartData.count - 1) {
            
            cumulatedPosition += [self.delegate MAXChartView: self spaceForSection: section + 1];
            
        }
        
    }
    
}

-(void)p_positionSectionDecorationView:(UIView *)theSectionDecorationView cumulatedPos:(CGFloat)theCumulatedPos forSection:(NSInteger)theSection {
    
}


// MARK: In the positioning we will have a specific object that positions the views depending on an enum
-(CGFloat)p_positionColumnView:(MAXChartColumn *)theColumnView value:(double)theValue cumulatedPos:(CGFloat)theCumulatedPos atIndexPath:(MAXChartIndexPath *)theIndexPath {
    
    CGFloat columnWidth = [self.delegate MAXChartView: self widthForColumnAtIndexPath: theIndexPath];
    
    theColumnView.view.frame = CGRectMake(theCumulatedPos, [self p_chartHeight] * (1 - theValue) + [self p_lowerView], columnWidth, [self p_chartHeight] * theValue);
    theColumnView.backgroundView.frame = CGRectMake(theCumulatedPos, [self p_upperView], columnWidth, [self p_chartHeight]);
    
    theColumnView.view.frame = [self p_repositionFrameForChartDirect:theColumnView.view.frame];
    theColumnView.backgroundView.frame = [self p_repositionFrameForChartDirect:theColumnView.backgroundView.frame];
    
    // allow the user to customize the views/buttons for touch events, animations and whatever else they can think of.
    if ([self.delegate respondsToSelector:@selector(MAXChartView:customizeColumnView:columnBackgroundView:atIndexPath:)] == YES) {
        
        [self.delegate MAXChartView: self customizeColumnView: theColumnView.view columnBackgroundView: theColumnView.backgroundView atIndexPath: theIndexPath];
        
    }
    
    return columnWidth;
    
}

-(CGRect)p_repositionFrameForChartDirect:(CGRect)theFrame {
    
    if (self.chartDirection == kMAXChartDirectionVerticalUp) {
        
        return theFrame;
    }
    else if(self.chartDirection == kMAXChartDirectionVerticalDown) {
        
        return CGRectMake(theFrame.origin.x, [self p_upperView], theFrame.size.width, theFrame.size.height);
    }
    else if(self.chartDirection == kMAXChartDirectionHorizontalRight) {
        
        return CGRectMake([self p_sizeLeftView], theFrame.origin.x, theFrame.size.height, theFrame.size.width);
    }
    else {
        
        return CGRectMake([self p_chartWidth] + [self p_sizeLeftView] - theFrame.size.height, theFrame.origin.x, theFrame.size.height, theFrame.size.width);
    }
    
    return CGRectZero;
}

#pragma mark - Private helpers

// These will be changed in future implementations to contain logic
-(CGFloat)p_chartHeight {
    
    return self.frame.size.height;
}

-(CGFloat)p_upperView {
    
    return 0;
}

-(CGFloat)p_lowerView {
    
    return 0;
}

// these will be changed in future impelementation to contain logic
-(CGFloat)p_chartWidth {
    
    return self.frame.size.width;
}

// the size of the left part of the view with images
-(CGFloat)p_sizeLeftView {
    
    return  0;
}

-(CGFloat)p_sizeRightView {
    
    return 0;
}

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
