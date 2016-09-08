//
//  MAXLineChartView.h
//  ReusableComponentsApp
//
//  Created by Mathieu Grettir Skulason on 8/17/16.
//  Copyright © 2016 Konta ehf. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MAXLineChartView;

typedef NS_ENUM(NSInteger, MAXLineJoinStyle) {
    kMAXLineJoinStyleMiter,
    kMAXLineJoinStyleRound,
    kMAXLineJoinStyleBevel
};

typedef NS_ENUM(NSInteger, MAXLineCapStyle) {
    kMAXLineCapStyleButt,
    kMAXLineCapStyleRound,
    kMAXLineCapStyleSquare,
};

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




@optional


/////////////////////////////////////////////////
////////// Chart Line Decoration Views //////////

/**
 @description The number of decoration views to add to the line.
 */
-(NSUInteger)MAXLineChart:(MAXLineChartView *)theChartView numLineDecorationViewsForLine:(NSUInteger)theLine;

/**
 @description The X position for the given line and decoration view, as well as chart view. This value is then used to position the decorationv iew on the Y axis of the line depending on the X value.
 */
-(double)MAXLineChart:(MAXLineChartView *)theChartView decorationViewAtPositionXForLine:(NSUInteger)theLine decorationViewNum:(NSUInteger)theDecorationViewNum;

/**
 @description 
 */
-(UIView *)MAXLineChart:(MAXLineChartView *)theChartView decorationViewForLine:(NSUInteger)theLine decoartionViewNum:(NSUInteger)theDecorationViewNum decorationViewPosition:(CGPoint)theDecorationViewPosition;


////////////////////////////////////////////////////////
///////// Chart Border Axis Decoration Views ///////////


/////////// Left Border View

/**
 @descirption The decoration views to add to the border, only called if you have given the border a size.
 */
-(NSUInteger)MAXLineChartNumberOfDecorationViewsForLeftBorder:(MAXLineChartView *)theLineChart;

/**
 @description This method positions the decoration view on the left border decoration view depending on the value you give. All axis have a max and min value the value given in this method will see about its position. 
 
 @param theChartView The line chart requesting the decoration view value.
 @param theDecorationViewNumber The number of the decoration view that is requesting its value.
 
 @return The value of the current decoration view to determine its position.
 */
-(double)MAXLineChart:(MAXLineChartView *)theChartView valueForLeftBorderDecorationViewNumber:(NSUInteger)theDecorationViewNumber;

-(UIView *)MAXLineChart:(MAXLineChartView *)theChartView leftBorderDecorationViewWithCenterPosition:(CGPoint)theCenterPoint decorationViewNumber:(NSUInteger)theDecorationViewNumber;

///////// Right Border View

/**
 @descirption The decoration views to add to the border, only called if you have given the border a size otherwise it does not exist.
 */
-(NSUInteger)MAXLineChartNumberOfDecorationViewsForRightBorder:(MAXLineChartView *)theLineChart;

/**
 @description This method positions the decoration view on the right border decoration view depending on the value you give. All axis have a max and min value the value given in this method will see about its position.
 
 @param theChartView The line chart requesting the decoration view value.
 @param theDecorationViewNumber The number of the decoration view that is requesting its value.
 
 @return The value of the current decoration view to determine its position.
 */
-(double)MAXLineChart:(MAXLineChartView *)theChartView valueForRightBorderDecorationViewNumber:(NSUInteger)theDecorationViewNumber;

-(UIView *)MAXLineChart:(MAXLineChartView *)theChartView rightBorderDecorationViewWithCenterPosition:(CGPoint)theCenterPoint decorationViewNumber:(NSUInteger)theDecorationViewNumber;

/////// Upper Border View

/**
 @descirption The decoration views to add to the border, only called if you have given the border a size.
 */
-(NSUInteger)MAXLineChartNumberOfDecorationViewsForUpperBorder:(MAXLineChartView *)theLineChart;

/**
 @description This method positions the decoration view on the upper border decoration view depending on the value you give. All axis have a max and min value the value given in this method will see about its position.
 
 @param theChartView The line chart requesting the decoration view value.
 @param theDecorationViewNumber The number of the decoration view that is requesting its value.
 
 @return The value of the current decoration view to determine its position.
 */
-(double)MAXLineChart:(MAXLineChartView *)theChartView valueForUpperBorderDecorationViewNumber:(NSUInteger)theDecorationViewNumber;

-(UIView *)MAXLineChart:(MAXLineChartView *)theChartView upperBorderDecorationViewWithCenterPosition:(CGPoint)theCenterPosition decoartionViewNumber:(NSUInteger)theDecorationViewNumber;

///////// Lower Border View

/**
 @descirption The decoration views to add to the border, only called if you have given the border a size.
 */
-(NSUInteger)MAXLineChartNumberOfDecorationViewsForLowerBorder:(MAXLineChartView *)theLineChart;

/**
 @description This method positions the decoration view on the lower border decoration view depending on the value you give. All axis have a max and min value the value given in this method will see about its position.
 
 @param theChartView The line chart requesting the decoration view value.
 @param theDecorationViewNumber The number of the decoration view that is requesting its value.
 
 @return The value of the current decoration view to determine its position.
 */
-(double)MAXLineChart:(MAXLineChartView *)theChartView valueForLowerBorderDecorationViewNumber:(NSUInteger)theDecorationViewNumber;

-(UIView *)MAXLineChart:(MAXLineChartView *)theChartView lowerBorderDecorationViewWithCenterPosition:(CGPoint)theCenterPosition decorationViewNumber:(NSUInteger)theDecorationViewNumber;





@end

@protocol MAXLineChartDelegate < NSObject >


@optional

///////////////////////////////////////////////////
//////////////// Line Customization ///////////////

/**
 @description The color of used to stroke the path of the given line.
 */
-(UIColor *)MAXLineChart:(MAXLineChartView *)theLineChart strokeColorForLine:(NSUInteger)theLine;

/**
 @description The line width of the given line.
 */
-(CGFloat)MAXLineChart:(MAXLineChartView *)TheLineChart widthForLine:(NSUInteger)theLine;

/**
 @description The line join style for the line being drawn. Defaults to Round.
 */
-(MAXLineJoinStyle)MAXLineChart:(MAXLineChartView *)theLineChart lineJoinStyleForLine:(NSUInteger)theLine;

/**
 @description The line cap style for the line being drawn. Defaults to Round.
 */
-(MAXLineCapStyle)MAXLineChart:(MAXLineChartView *)theLineChart lineCapStyelForLine:(NSUInteger)theLine;

/**
 @description The line dash phase, that offsets the dash pattern.
 */
-(CGFloat)MAXLineChart:(MAXLineChartView *)theLineChart lineDashPhaseForLine:(NSUInteger)theDashPhase;

/**
 @description The line dash pattern.
 */
-(NSArray <NSNumber *> *)MAXLineChart:(MAXLineChartView *)theLineChart lineDashPatternForLine:(NSUInteger)theLine;

/**
 @description If you would like to allow antialiasing for the CALayer of the line set this to yes. Defaults YES / true.
 */
-(BOOL)MAXLineChart:(MAXLineChartView *)theLineChart allowsEdgeAntialiasingForLine:(NSUInteger)theLine;

/**
 @description Used to normalize the chart, the highest possible value to use for normalization on all other values. If the y value is not higher than the highest possible values it will move the point to the top of chart.
 */
-(double)MAXhighestYValueForLineChart:(MAXLineChartView *)theLineChart;

/**
 @descirption Highest x value for the chart to determine the lengh of the chart.
 */
-(double)MAXHighestXValueForLineChart:(MAXLineChartView *)theLineChart;

//////////////////////////////////////////////
/////////// Chart Border Lines ///////////////

-(CGFloat)MAXLineChartLeftBorderWidthForChart:(MAXLineChartView *)theLineChart;

-(CGFloat)MAXLineChartRightBorderWidthForChart:(MAXLineChartView *)theLineChart;

-(CGFloat)MAXLineChartUpperBorderWidthForChart:(MAXLineChartView *)theLineChart;

-(CGFloat)MAXLineChartLowerBorderWidthForChart:(MAXLineChartView *)theLineChart;

/**
 @description The color for the chart border, defaults to black if not specified.
 */
-(UIColor*)MAXLineChartColorsForBordersForChart:(MAXLineChartView *)theLineChart;

//////////////////////////////////////////////
//////////// Chart Margin Size ///////////////

/**
 @description The purpose of the margin is dual, if you want to have a margin on some specific side of the chart we give you the option to do so, but it also determines the size of the axis decoration views, that is if you have added any border decoration views and register MAXLineChart:leftAxisDecorationViews:atIndex: delegate we will automatically create decoration views correctly positioned and size to add values under the border decoration views. This is so that you can provide values for the chart with ease.
 */
-(CGFloat)MAXLineChartLeftMarginWidth:(MAXLineChartView *)theLineChart;

-(CGFloat)MAXLineChartRightMarginWidth:(MAXLineChartView *)theLineChart;

-(CGFloat)MAXLineChartUpperMarginHeight:(MAXLineChartView *)theLineChart;

-(CGFloat)MAXLineChartLowerMarginHeight:(MAXLineChartView *)theLineChart;

////////////////////////////////////////////////////////
///////////// Chart Axis Decoration Views //////////////

-(void)MAXLineChart:(MAXLineChartView *)theLineChart leftAxisDecorationView:(UIView *)theDecorationView atIndex:(NSUInteger)theIndex;

-(void)MAXLineChart:(MAXLineChartView *)theLineChart rightAxisDecorationView:(UIView *)theDecorationView atIndex:(NSUInteger)theIndex;

-(void)MAXLineChart:(MAXLineChartView *)theLineChart upperAxisDecorationView:(UIView *)theDecoartionView atIndex:(NSUInteger)theIndex;

-(void)MAXLineChart:(MAXLineChartView *)theLineChart lowerAxisDecorationView:(UIView *)theDecoartionView atIndex:(NSUInteger)theIndex;

@end

@interface MAXLineChartView : UIView

@property (nonatomic, weak) id <MAXLineChartViewDataSource> datasource;

@property (nonatomic, weak) id <MAXLineChartDelegate> delegate;

-(void)reloadData;

@end
