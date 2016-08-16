//
//  MAXChartView.h
//  ReusableComponentsApp
//
//  Created by Mathieu Skulason on 19/06/16.
//  Copyright © 2016 Konta ehf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MAXChartView;
@class MAXChartColumn;
@class MAXChartIndexPath;

@protocol MAXChartViewDataSource <NSObject>

@required

/**
 @description The number of rows in the given section.
 
 @param theChartView The chart view that is currently reloading its data.
 @param theSection The section that is being reloaded for the chart.
 
 */
-(NSUInteger)MAXChartView:(MAXChartView *)theChartView numberOfColumnsInSection:(NSUInteger)theSection;

/**
 @description The vertical value for the column at a given index path.
 
 @param theChartView The chart view that is currently reloading its data.
 @param theIndexPath The index path for the column that is being reloaded.
 */
-(double)MAXChartView:(MAXChartView *)theChartView valueAtIndexPath:(MAXChartIndexPath *)theIndexPath;

@optional

/**
 @description The number of sections the chart view sohuld have, if it is not defined it defaults to one.
 
 @param theChartView The chart view that is curreny reloading its data.
 */
-(NSUInteger)MAXNumberOfSectionsInChartView:(MAXChartView *)theChartView;


@end

@protocol MAXChartViewDelegate <NSObject>

@optional

/**
 @descirption This method is used to set the color of the column at the given index path.
 
 @param theChartView the chart view that is currently reloading its data
 @param theIndexPath The index path of the column that is having its color set.
 */
-(UIColor *)MAXChartView:(MAXChartView *)theChartView colorForColumnAtIndexPath:(MAXChartIndexPath *)theIndexPath;

/**
 @description defines the width of the column for the chart view. If this method is defined the chart view can expand out of bounds if the width and the space for rows and sections is too large. If it is not defined it will shrink the size of the columns to match the amount of space available based on the space defined between the columns and sections.
 
 */
-(CGFloat)MAXChartView:(MAXChartView *)theChartView widthForColumnAtIndexPath:(MAXChartIndexPath *)theIndexPath;

/**
 @description If you want to have dynamic width between columns use this delegate call back. When you get an index path it always indicates the width that will come after that said column. That is if we have section 0 and column 1, we are declaring the space between column 1 and column 2. There is no space added when we are at the last column in the section as there is a section space and not a row space between the two.
 */
-(CGFloat)MAXChartView:(MAXChartView *)theChartView spaceForColumnAtIndexPath:(MAXChartIndexPath *)theIndexPath;

/**
 @description
 */
-(double)MAXChartView:(MAXChartView *)theChartView spaceForSectionAtIndexPath:(MAXChartIndexPath *)theIndexPath;

/**
 @description Used to predefine the highest possible value that will be displayed to normalize the data. If this value is not higher that the highest value of any of the columns it will be cut.
 */
-(double)MAXHighestValueForChartView:(MAXChartView *)theChartView;

/**
 @description Used to define the lowest value, if not defined it will be zero. Currently no used.
 */
-(double)MAXLowestValueForChartView:(MAXChartView *)theChartView;

@end

@interface MAXChartView : UIView

/**
 @description The datasource for the chart view.
 */
@property (nonatomic, weak, nullable) id <MAXChartViewDataSource> datasource;

/**
 @description The delegate for the chart view.
 */
@property (nonatomic, weak, nullable) id <MAXChartViewDelegate> delegate;

/**
 @description The default space for rows if the dynamic row spacing delegate is not used. Its value defaults to 5 if not set.
 @warning The default row space will only be used if MAXChartView:spaceForColumnAtIndexPath: is not implemented in the delegate for the chart view.
 */
@property (nonatomic) double columnSpace;

/**
 @description The defaults space for sections if the dymanic spacing delegate is not used. Its value defaults to 10 if not set.
 @warning The defaul section space will only be used if MAXChartView:spaceForSectionAtIndexPath: is not implemented in the delegate for the chart view.
 */
@property (nonatomic) double sectionSpace;

/**
 @description Reloads the data for the chart view.
 */
-(void)reloadData;

@end

NS_ASSUME_NONNULL_END
