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
@property (nonatomic, strong) NSArray <CAShapeLayer *> *lineLayers;

@end

@implementation MAXLineChartView

-(id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame: frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

-(id)init {
    return [self initWithFrame: CGRectZero];
}

-(void)reloadData {
    
    _chartData = [self p_fetchChartData];
    [self p_drawLinesWithChartData: _chartData maxYValue: [self p_highestYValueForChart] maxXValue: [self p_highestXValueForChart]];
    
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

-(void)p_drawLinesWithChartData:(NSArray <NSArray <NSNumber *> *> *)theChartData maxYValue:(double)maxYValue maxXValue:(NSUInteger)maxXValue {
    
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
        [self.layer addSublayer: layer];
        
        // increase the line number as we go through the line data
        lineNumber++;
    }
    
}

-(CAShapeLayer *)p_createLayerWithPath:(UIBezierPath *)thePath forLine:(NSUInteger)theLine {
    
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.path = thePath.CGPath;
    
    if ([self.delegate respondsToSelector: @selector(MAXLineChart:widthForLine:)] == YES) {
        
        layer.lineWidth = [self.delegate MAXLineChart: self widthForLine: theLine];
    }
    else {
        
        layer.lineWidth = 2.0;
    }
    
    if ([self.delegate respondsToSelector: @selector(MAXLineChart:strokeColorForLine:)] == YES) {
        
        layer.strokeColor = [self.delegate MAXLineChart: self strokeColorForLine: theLine].CGColor;
    }
    else {
        
        layer.strokeColor = [UIColor redColor].CGColor;
    }
    
    if ([self.delegate respondsToSelector:@selector(MAXLineChart:lineDashPatternForLine:)] == YES) {
        
        layer.lineDashPattern = [self.delegate MAXLineChart: self lineDashPatternForLine: theLine];
    }
    else {
        
        layer.lineDashPattern = nil;
    }
    
    layer.fillColor = [UIColor clearColor].CGColor;
    
    return layer;
}


#pragma mark - Helpers


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
