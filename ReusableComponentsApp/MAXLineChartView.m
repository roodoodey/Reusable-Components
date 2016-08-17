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


-(void)p_drawLinesWithChartData:(NSArray <NSArray <NSNumber *> *> *)theChartData maxYValue:(double)maxYValue maxXValue:(NSUInteger)maxXValue {
    
    CGFloat horizontalStep = CGRectGetWidth(self.frame) / (maxXValue - 1);
    CGFloat height = CGRectGetHeight(self.frame);
    
    UIGraphicsBeginImageContext( self.frame.size );
    CGContextRef context = UIGraphicsGetCurrentContext();
    
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
        
        CAShapeLayer *layer = [[CAShapeLayer alloc] init];
        layer.path = path.CGPath;
        layer.strokeColor = [UIColor greenColor].CGColor;
        layer.fillColor = [UIColor clearColor].CGColor;
        [self.layer addSublayer: layer];
        
        
    }
    
}


#pragma mark - Helpers


-(NSUInteger)p_highestXValueForChart {
    
    if ([self.delegate respondsToSelector: @selector(MAXHighestXValueForChart:)] == YES) {
        
        return [self.delegate MAXHighestXValueForChart: self];
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
    if ([self.delegate respondsToSelector:@selector(MAXhighestYValueForChart:)] == YES) {
        
        return [self.delegate MAXhighestYValueForChart: self];
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
