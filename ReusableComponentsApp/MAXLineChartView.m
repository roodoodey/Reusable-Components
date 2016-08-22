//
//  MAXLineChartView.m
//  ReusableComponentsApp
//
//  Created by Mathieu Grettir Skulason on 8/17/16.
//  Copyright © 2016 Konta ehf. All rights reserved.
//

#import "MAXLineChartView.h"

@interface MAXLineChartView ()

@property (nonatomic, strong) NSArray <NSArray <NSNumber *> *> *chartData;

/**
 @description
 */
@property (nonatomic, strong) NSMutableArray <CAShapeLayer *> *lineShapeLayers;

@end

@implementation MAXLineChartView

-(id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame: frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        _lineShapeLayers = [NSMutableArray array];
    
    }
    
    return self;
}

-(id)init {
    return [self initWithFrame: CGRectZero];
}

-(void)reloadData {
    
    _chartData = [self p_fetchChartData];
    [self p_removeShapeLayers: _lineShapeLayers];
    [self p_drawLinesWithChartData: _chartData lineShapeLayers: _lineShapeLayers maxYValue: [self p_highestYValueForChart] maxXValue: [self p_highestXValueForChart]];
    
}

#pragma mark - Fetching Line Chart Data

-(NSArray <NSArray <NSNumber *> *> *)p_fetchChartData {
    
    NSMutableArray *lines = [NSMutableArray array];
    
    NSUInteger numLines = [self.datasource MAXNumberOfLinesForChart: self];
    
    for (int line = 0; line < numLines; line++) {
        
        NSUInteger numValuesForLine = [self.datasource MAXLineChart: self numberOfXValuesForLine: line];
        
        NSMutableArray *verticalValuesForLine = [NSMutableArray array];
        
        for (int horizontalValue = 0; horizontalValue < numValuesForLine; horizontalValue++) {
            
            double verticalValue = [self.datasource MAXLineChart: self YValueAtX: horizontalValue line: line];
            [verticalValuesForLine addObject: [NSNumber numberWithDouble: verticalValue] ];
            
        }
        
        [lines addObject: verticalValuesForLine];
        
    }
    
    return lines;
}


#pragma mark - Drawing The Lince Chart

-(void)p_drawLinesWithChartData:(NSArray <NSArray <NSNumber *> *> *)theChartData lineShapeLayers:(NSMutableArray *)theLineShapeLayers maxYValue:(double)maxYValue maxXValue:(NSUInteger)maxXValue {
    
    CGFloat horizontalStep = CGRectGetWidth(self.frame) / (maxXValue - 1);
    CGFloat height = CGRectGetHeight(self.frame);
    
    NSUInteger lineNumber = 0;
    for (NSArray *line in theChartData) {
        
        UIBezierPath *path = [[UIBezierPath alloc] init];
        path.lineWidth = 2;
        
        for (int x = 0; x < line.count; x++) {
            
            double y = [[line objectAtIndex: x] doubleValue] / maxYValue;
            double yHeight = y * height;
            
            if (x == 0) {
                [path moveToPoint:CGPointMake(0, yHeight)];
            }
            else {
                [path addLineToPoint: CGPointMake(x * horizontalStep,  yHeight)];
            }
            
        }
        
        CAShapeLayer *layer = [self p_createLayerWithPath: path forLine: lineNumber];
        [theLineShapeLayers addObject: layer];
        [self.layer addSublayer: layer];
        
        // increase the line number as we go through the line data
        lineNumber++;
    }
    
}

-(void)p_removeShapeLayers:(NSMutableArray *)theShapeLayers {
    
    for (CAShapeLayer *shapeLayer in theShapeLayers) {
        [shapeLayer removeFromSuperlayer];
    }
    
    [theShapeLayers removeAllObjects];
    
}

-(CAShapeLayer *)p_createLayerWithPath:(UIBezierPath *)thePath forLine:(NSUInteger)theLine {
    
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.path = thePath.CGPath;
    layer.strokeColor = [self p_strokeColorForLine: theLine];
    layer.lineWidth = [self p_widthForLine: theLine];
    layer.lineCap = [self p_lineCapForLine: theLine];
    layer.lineDashPhase = [self p_lineDashPhaseForLine: theLine];
    layer.lineDashPattern = [self p_lineDashPatthernForLine: theLine];
    layer.allowsEdgeAntialiasing = [self p_allowsEdgeAntialiasingForLine: theLine];

    layer.fillColor = [UIColor clearColor].CGColor;
    
    return layer;
}

#pragma mark - Getter helpers

-(BOOL)p_allowsEdgeAntialiasingForLine:(NSUInteger)theLine {
    
    if ([self.delegate respondsToSelector: @selector(MAXLineChart:allowsEdgeAntialiasingForLine:)] == YES) {
        return [self.delegate MAXLineChart: self allowsEdgeAntialiasingForLine: theLine];
    }
    
    return YES;
    
}

-(NSString *)p_lineJoinForLine:(NSUInteger)theLine {
    
    MAXLineJoinStyle lineJoin = [self p_lineJoinStyleForLine: theLine];
    
    if (lineJoin == kMAXLineJoinStyleMiter) {
        
        return kCALineJoinMiter;
    }
    else if(lineJoin == kMAXLineJoinStyleRound) {
        
        return kCALineJoinRound;
    }
    else if(lineJoin == kMAXLineJoinStyleBevel) {
        
        return kCALineJoinBevel;
    }
    
    return kCALineJoinRound;
    
}

-(MAXLineJoinStyle)p_lineJoinStyleForLine:(NSUInteger)theLine {
    
    if ([self.delegate respondsToSelector:@selector(MAXLineChart:lineJoinStyleForLine:)] == YES) {
        return [self.delegate MAXLineChart: self lineJoinStyleForLine: theLine];
    }
    else {
        return kMAXLineJoinStyleRound;
    }
    
}

-(NSString *)p_lineCapForLine:(NSUInteger)theLine {
    
    MAXLineCapStyle style = [self p_lineCapStyleForLine: theLine];
    
    if (style == kMAXLineCapStyleButt) {
        
        return kCALineCapRound;
    }
    else if(style == kMAXLineCapStyleRound) {
        
        return kCALineCapRound;
    }
    else if(style == kMAXLineCapStyleSquare) {
        
        return kCALineCapSquare;
    }
    
    return kCALineCapRound;
}

-(MAXLineCapStyle)p_lineCapStyleForLine:(NSUInteger)theLine {
    
    if ([self.delegate respondsToSelector:@selector(MAXLineChart:lineCapStyelForLine:)] == YES) {
        return [self.delegate MAXLineChart: self lineCapStyelForLine: theLine];
    }
    else {
        return kMAXLineCapStyleRound;
    }
    
}

-(CGFloat)p_lineDashPhaseForLine:(NSUInteger)theLine {
    
    if ([self.delegate respondsToSelector:@selector(MAXLineChart:lineDashPhaseForLine:)] == YES) {
        return [self.delegate MAXLineChart: self lineDashPhaseForLine: theLine];
    }
    
    return 0;
}

-(NSArray <NSNumber *> *)p_lineDashPatthernForLine:(NSUInteger)theLine {
    
    if ([self.delegate respondsToSelector: @selector(MAXLineChart:lineDashPatternForLine:)] == YES) {
        return  [self.delegate MAXLineChart: self lineDashPatternForLine: theLine];
    }
    else {
        
        return nil;
    }
    
}

-(CGFloat)p_widthForLine:(NSUInteger)theLine {
    
    if ([self.delegate respondsToSelector: @selector(MAXLineChart:widthForLine:)] == YES) {
        
        return [self.delegate MAXLineChart: self widthForLine: theLine];
    }
    else {
        
        return 2.0;
    }
    
}

-(CGColorRef)p_strokeColorForLine:(NSUInteger)theLine {
    
    if ([self.delegate respondsToSelector: @selector(MAXLineChart:strokeColorForLine:)] == YES) {
        
        return [self.delegate MAXLineChart: self strokeColorForLine: theLine].CGColor;
    }
    else {
        
        return [UIColor blackColor].CGColor;
    }
    
}

-(NSUInteger)p_highestXValueForChart {
    
    if ([self.delegate respondsToSelector: @selector(MAXHighestXValueForLineChart:)] == YES) {
        
        return [self.delegate MAXHighestXValueForLineChart: self];
    }
    else {
        
        NSInteger highestXValue = 0;
        
        for (NSArray *line in _chartData) {
            
            if (line.count > highestXValue) {
                
                highestXValue = line.count;
            }
            
        }
        
        return highestXValue;
        
    }
    
}


-(double)p_highestYValueForChart {
    
    // check if the user wants to provide his own value or if we exrtact it from the data
    if ([self.delegate respondsToSelector:@selector(MAXhighestYValueForLineChart:)] == YES) {
        
        return [self.delegate MAXhighestYValueForLineChart: self];
    }
    else {
        return [self p_findHighestYValue: _chartData];
    }
    
}


#pragma mark - Line Chart Border

-(CGFloat)p_leftBorderWidth {
    
    if ([self.delegate respondsToSelector:@selector(MAXLineChartLeftBorderWidthForChart:)] == YES) {
        return [self.delegate MAXLineChartLeftBorderWidthForChart: self];
    }
    
    return 0;
}

-(CGFloat)p_rightBorderWidth {
    
    if ([self.delegate respondsToSelector:@selector(MAXLineChartRightBorderWidthForChart:)] == YES) {
        
        return [self.delegate MAXLineChartRightBorderWidthForChart: self];
    }
    
    return 0;
}

-(CGFloat)p_upperBorderWidth {
    
    if ([self.delegate respondsToSelector:@selector(MAXLineChartUpperBorderWidthForChart:)] == YES) {
        
        return [self.delegate MAXLineChartUpperBorderWidthForChart: self];
    }
    
    return 0;
}

-(CGFloat)p_lowerBorderWidth {
    
    if ([self.delegate respondsToSelector:@selector(MAXLineChartLowerBorderWidthForChart:)] == YES) {
        
        return [self.delegate MAXLineChartLowerBorderWidthForChart: self];
    }
    
    return 0;
}

#pragma mark - Chart Size Helpers

-(CGFloat)p_chartHeight {
    
    double height = CGRectGetWidth(self.frame);
    
    return height - [self p_upperBorderWidth] - [self p_lowerBorderWidth];
}

-(CGFloat)p_chartWidth {
    
    double width = CGRectGetWidth(self.frame);
    
    return width - [self p_leftBorderWidth] - [self p_rightBorderWidth];
}


#pragma mark - Helpers


-(double)p_findHighestYValue:(NSArray <NSArray <NSNumber *> *> *)theChartData {
    
    double highestValue = 0;
    
    for (NSArray *line in theChartData) {
        
        for (NSNumber *yValue in line) {
        
            if ([yValue doubleValue] > highestValue) {
                highestValue = [yValue doubleValue];
            }
        
        }
    
    }
    
    return highestValue;
}

@end
