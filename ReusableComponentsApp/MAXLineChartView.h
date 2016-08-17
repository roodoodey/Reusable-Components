//
//  MAXLineChartView.h
//  ReusableComponentsApp
//
//  Created by Mathieu Grettir Skulason on 8/17/16.
//  Copyright © 2016 Konta ehf. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MAXLineChartView;

@protocol MAXLineChartViewDataSource < NSObject >

@required

/**
 @description The number of lines to draw in the chart view.
 
 @param theChartView Chart view that is requesting the number of lines for it.
 */
-(NSUInteger)MAXNumberOfLinesForChart:(MAXLineChartView *)theChartView;

/**
 @description The number of values for the line on the x scale of the line chart.
 */

-(NSUInteger)MAXLineChart:(MAXLineChartView *)theChartView numberOfXValuesForLine:(NSUInteger)theLine;

/**
 @description The Y value for the given x position for a specific line. This is used to determine all the points of the line.
 
 @param theChartView The chart that is requesting the y value.
 
 @param theX The x position for the y value being requested.
 
 @param theLine The line that is requesting the Y value.
 */
-(double)MAXLineChart:(MAXLineChartView *)theChartView YValueAtX:(NSUInteger)theX line:(NSUInteger)theLine;


@end

@protocol MAXLineChartDelegate < NSObject >

@optional

-(double)MAXhighestYValueForChart:(MAXLineChartView *)theLineChart;

-(double)MAXHighestXValueForChart:(MAXLineChartView *)theLineChart;

@end

@interface MAXLineChartView : UIView

@property (nonatomic, weak) id <MAXLineChartViewDataSource> datasource;

@property (nonatomic, weak) id <MAXLineChartDelegate> delegate;

-(void)reloadData;

@end
