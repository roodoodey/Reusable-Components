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

@property (nonatomic, strong) NSMutableArray <CAShapeLayer *> *lineShapeLayers;

@property (nonatomic, strong) NSArray <NSArray <UIView *> *> *lineDecorationViews;

////////// Border views

@property (nonatomic, strong) UIView *leftBorderView;

@property (nonatomic, strong) UIView *rightBorderView;

@property (nonatomic, strong) UIView *upperBorderView;

@property (nonatomic, strong) UIView *lowerBorderView;

////////// Border decoration views

@property (nonatomic, strong) NSArray <UIView *> *leftBorderDecorationViews;

@property (nonatomic, strong) NSArray <UIView *> *rightBorderDecorationViews;

@property (nonatomic, strong) NSArray <UIView *> *upperBorderDecorationViews;

@property (nonatomic, strong) NSArray <UIView *> *lowerBorderDecorationViews;

@end

@implementation MAXLineChartView

-(id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame: frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        _lineShapeLayers = [NSMutableArray array];
        
        _leftBorderView = [[UIView alloc] init];
        [self addSubview: _leftBorderView];
        
        _rightBorderView = [[UIView alloc] init];
        [self addSubview: _rightBorderView];
        
        _upperBorderView = [[UIView alloc] init];
        [self addSubview: _upperBorderView];
        
        _lowerBorderView = [[UIView alloc] init];
        [self addSubview: _lowerBorderView];
    
        self.layer.masksToBounds = YES;
        
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
    [self p_drawChartLineBorders];
    [self p_drawLineDecorationViewsWithChartData: _chartData];
    [self p_drawLineBorderDecorationViews];
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


#pragma mark - Drawing The Line Chart

-(void)p_drawLinesWithChartData:(NSArray <NSArray <NSNumber *> *> *)theChartData lineShapeLayers:(NSMutableArray *)theLineShapeLayers maxYValue:(double)maxYValue maxXValue:(NSUInteger)maxXValue {
    
    CGFloat horizontalStep = [self p_chartWidth] / (maxXValue - 1);
    CGFloat height = [self p_chartHeight];
    
    NSUInteger lineNumber = 0;
    for (NSArray *line in theChartData) {
        
        UIBezierPath *path = [[UIBezierPath alloc] init];
        path.lineWidth = 2;
        
        for (int x = 0; x < line.count; x++) {
            
            double y = [[line objectAtIndex: x] doubleValue] / maxYValue;
            double yHeight = [self p_chartHeight] - y * height;
            
            if (x == 0) {
                CGPoint point = CGPointMake([self p_leftBorderWidth], yHeight + [self p_upperBorderWidth]);
                [path moveToPoint: point];
            }
            else {
                CGPoint point = CGPointMake(x * horizontalStep + [self p_leftBorderWidth],  yHeight + [self p_upperBorderWidth]);
                [path addLineToPoint: point];
            }
            
        }
        
        CAShapeLayer *layer = [self p_createLayerWithPath: path forLine: lineNumber];
        [theLineShapeLayers addObject: layer];
        [self.layer insertSublayer: layer below: _leftBorderView.layer];
        
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

#pragma mark - Line Decoration Views

-(void)p_drawLineDecorationViewsWithChartData:(NSArray <NSArray <NSNumber *> *> *)theChartData {
    
    if ([self.datasource respondsToSelector:@selector(MAXLineChart:numLineDecorationViewsForLine:)] == YES || [self.datasource respondsToSelector:@selector(MAXLineChart:decorationViewAtPositionXForLine:decorationViewNum:)] == YES || [self.datasource respondsToSelector:@selector(MAXLineChart:decorationViewForLine:decoartionViewNum:decorationViewPosition:)] == YES) {
        
        [self p_removeLineDecorationViews];
        [self p_fetchAndDrawLineDecorationViewsWithChartData: theChartData];
        
    }
    
}

-(NSArray <NSArray <UIView *> *> *)p_fetchAndDrawLineDecorationViewsWithChartData:(NSArray <NSArray <NSNumber *> *> *)theChartData {
    
    NSMutableArray *lineDecorationViews = [NSMutableArray array];
    
    for (int line = 0; line < theChartData.count; line++) {
        
        NSMutableArray *decorationViews = [NSMutableArray array];
        
        NSUInteger numDecorationViews = [self.datasource MAXLineChart: self numLineDecorationViewsForLine: line];
        NSArray *lineData = [theChartData objectAtIndex: line];
        
        for (int decorationNum = 0; decorationNum < numDecorationViews; decorationNum++) {
            
            double posX = [self.datasource MAXLineChart: self decorationViewAtPositionXForLine: line decorationViewNum: decorationNum];
            
            int lowPosX = floor(posX);
            int highPosX = ceil(posX);
            
            double lowPosY = [[lineData objectAtIndex: lowPosX] doubleValue] / [self p_highestYValueForChart];
            double highPosY = [[lineData objectAtIndex: highPosX] doubleValue] / [self p_highestYValueForChart];
            
            double slopeHeight = /* dstance x*/ (posX - lowPosX) * /* slope */ (highPosY - lowPosY) * [self p_chartHeight];
            double lowPosYViewCoord = (1 - lowPosY) * [self p_chartHeight];
            
            double horizontalStep = [self p_chartHeight] / ([self p_highestXValueForChart] - 1);

            CGPoint centerPointForDecorationView = CGPointMake([self p_leftBorderWidth] + horizontalStep * posX,  [self p_upperBorderWidth] + [self p_chartHeight] - lowPosYViewCoord + slopeHeight);

            UIView *lineDecorationView = [self.datasource MAXLineChart: self decorationViewForLine: line decoartionViewNum: decorationNum decorationViewPosition: centerPointForDecorationView];
            [self addSubview: lineDecorationView];
            
            [decorationViews addObject: lineDecorationView];
        }
        
        [lineDecorationViews addObject: decorationViews];
    }
    
    return lineDecorationViews;
}

-(void)p_removeLineDecorationViews {
    
    for (NSArray *lineDecorations in _lineDecorationViews) {
        
        for (UIView *decorationView in lineDecorations) {
            [decorationView removeFromSuperview];
        }
        
    }
    
}

#pragma mark - Line Border Drawing

-(void)p_drawChartLineBorders {
    
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    
    _leftBorderView.frame = CGRectMake(0, 0, [self p_leftBorderWidth], height);
    _rightBorderView.frame = CGRectMake(width - [self p_rightBorderWidth], 0, [self p_rightBorderWidth], height);
    
    _upperBorderView.frame = CGRectMake(0, 0, width, [self p_upperBorderWidth]);
    _lowerBorderView.frame = CGRectMake(0, height - [self p_lowerBorderWidth], width, [self p_lowerBorderWidth]);
    
    [self p_reloadBorderColor];
    
}

-(void)p_reloadBorderColor {
    
    if ([self.delegate respondsToSelector:@selector(MAXLineChartColorsForBordersForChart:)] == YES) {
        
        UIColor *borderColor = [self.delegate MAXLineChartColorsForBordersForChart: self];
        
        [self p_setBordersColor: borderColor];
        
    }
    else {
        [self p_setBordersColor: [UIColor blackColor]];
    }
    
}

-(void)p_bringBordersToFront {
    
    [self bringSubviewToFront: _leftBorderView];
    [self bringSubviewToFront: _rightBorderView];
    [self bringSubviewToFront: _upperBorderView];
    [self bringSubviewToFront: _lowerBorderView];
    
}

-(void)p_setBordersColor:(UIColor *)theColor {
    
    _leftBorderView.backgroundColor = theColor;
    _rightBorderView.backgroundColor = theColor;
    _upperBorderView.backgroundColor = theColor;
    _lowerBorderView.backgroundColor = theColor;
    
}

#pragma mark - Border Line Decoration Views

-(void)p_drawLineBorderDecorationViews {
    
    [self p_removeLineDecorationViews];
    _leftBorderDecorationViews = [self p_fetchLeftBorderDecorationViews];
    _rightBorderDecorationViews = [self p_fetchRightBorderDecorationViews];
    _lowerBorderDecorationViews = [self p_fetchLowerBorderDecorationViews];
    _upperBorderDecorationViews = [self p_fetchUpperBorderDecorationViews];
    
    
}

-(void)p_removeLineBorderDecorationViews {
    
    [self p_removeLineDecorationViewsWithDecorationViews: _leftBorderDecorationViews];
    [self p_removeLineDecorationViewsWithDecorationViews: _rightBorderDecorationViews];
    [self p_removeLineDecorationViewsWithDecorationViews: _upperBorderDecorationViews];
    [self p_removeLineDecorationViewsWithDecorationViews: _lowerBorderDecorationViews];
    
}

-(void)p_removeLineDecorationViewsWithDecorationViews:(NSArray <UIView *> *)decorationViews {
    
    for (UIView *view in decorationViews) {
        
        [view removeFromSuperview];
        
    }
    
}

-(NSArray <UIView *> *)p_fetchLeftBorderDecorationViews {
    
    // these methods have to be defined in order to create the left decoration views
    if ([self.datasource respondsToSelector:@selector(MAXLineChartNumberOfDecorationViewsForLeftBorder:)] == YES || [self.datasource respondsToSelector:@selector(MAXLineChart:valueForLeftBorderDecorationViewNumber:)] == YES || [self.datasource respondsToSelector:@selector(MAXLineChart:leftBorderDecorationViewWithCenterPosition:decorationViewNumber:)] == YES) {
        
        NSMutableArray *leftBorderDecorationViews = [NSMutableArray array];
        
        NSUInteger numberOfDecorationViews = [self.datasource MAXLineChartNumberOfDecorationViewsForLeftBorder: self];
        
        for (int decorationNum = 0; decorationNum < numberOfDecorationViews; decorationNum++) {
            
            double leftBorderDecorationValue = [self.datasource MAXLineChart: self valueForLeftBorderDecorationViewNumber: decorationNum];
            
            CGPoint centerPoint = CGPointMake([self p_leftBorderWidth] / 2.0, [self p_upperBorderWidth] + (1 - leftBorderDecorationValue / [self p_highestYValueForChart]) * [self p_chartHeight]);
            
            UIView *decorationView = [self.datasource MAXLineChart: self leftBorderDecorationViewWithCenterPosition: centerPoint decorationViewNumber: decorationNum];
            [self addSubview: decorationView];
            
            [leftBorderDecorationViews addObject: decorationView];
            
        }
        
        return leftBorderDecorationViews;
    }
    
    return nil;
}

-(NSArray <UIView *> *)p_fetchRightBorderDecorationViews {
    
    // these methods have to be defined in order to create the right decoration views
    if ([self.datasource respondsToSelector:@selector(MAXLineChartNumberOfDecorationViewsForRightBorder:)] == YES || [self.datasource respondsToSelector:@selector(MAXLineChart:valueForRightBorderDecorationViewNumber:)] == YES || [self.datasource respondsToSelector:@selector(MAXLineChart:rightBorderDecorationViewWithCenterPosition:decorationViewNumber:)] == YES) {
        
        NSMutableArray *rightBorderDecorationViews = [NSMutableArray array];
        
        NSUInteger numberOfDecorationViews = [self.datasource MAXLineChartNumberOfDecorationViewsForRightBorder: self];
        
        for (int decorationNum = 0; decorationNum < numberOfDecorationViews; decorationNum++) {
            
            double rightBorderValue = [self.datasource MAXLineChart: self valueForRightBorderDecorationViewNumber: decorationNum];
            
            CGPoint centerPoint = CGPointMake( [self p_leftBorderWidth] + [self p_chartWidth] + [self p_rightBorderWidth] / 2.0, [self p_upperBorderWidth] + (1 - rightBorderValue / [self p_highestYValueForChart]) * [self p_chartHeight]);
            
            UIView *decorationView = [self.datasource MAXLineChart: self rightBorderDecorationViewWithCenterPosition: centerPoint decorationViewNumber: decorationNum];
            [self addSubview: decorationView];
            
            [rightBorderDecorationViews addObject: decorationView];
        }
        
        return rightBorderDecorationViews;
    }
    
    return nil;
}

-(NSArray <UIView *> *)p_fetchUpperBorderDecorationViews {
    
    // these methods have to be defined in order to create the upper decoration view
    if ([self.datasource respondsToSelector:@selector(MAXLineChartNumberOfDecorationViewsForUpperBorder:)] == YES || [self.datasource respondsToSelector:@selector(MAXLineChart:valueForUpperBorderDecorationViewNumber:)] == YES || [self.datasource respondsToSelector:@selector(MAXLineChart:upperBorderDecorationViewWithCenterPosition:decoartionViewNumber:)] == YES) {
        
        NSMutableArray *upperBorderDecorationViews = [NSMutableArray array];
        
        NSUInteger numberOfDecorationViews = [self.datasource MAXLineChartNumberOfDecorationViewsForUpperBorder: self];
        
        for (int decorationNum = 0; decorationNum < numberOfDecorationViews; decorationNum++) {
            
            double upperBorderValue = [self.datasource MAXLineChart: self valueForUpperBorderDecorationViewNumber: decorationNum];
            
            CGPoint centerPoint = CGPointMake(0 + upperBorderValue / [self p_highestXValueForChart] * self.frame.size.width, [self p_upperBorderWidth] / 2.0);
            
            UIView *decorationView = [self.datasource MAXLineChart: self upperBorderDecorationViewWithCenterPosition: centerPoint decoartionViewNumber: decorationNum];
            [self addSubview: decorationView];
            
            [upperBorderDecorationViews addObject: decorationView];
        }
        
        return upperBorderDecorationViews;
    }
    
    return nil;
}

-(NSArray <UIView *> *)p_fetchLowerBorderDecorationViews {
    
    
    if ([self.datasource respondsToSelector:@selector(MAXLineChartNumberOfDecorationViewsForLowerBorder:)] == YES || [self.datasource respondsToSelector:@selector(MAXLineChart:valueForLowerBorderDecorationViewNumber:)] == YES || [self.datasource respondsToSelector:@selector(MAXLineChart:lowerBorderDecorationViewWithCenterPosition:decorationViewNumber:)] == YES) {
        
        NSMutableArray *lowerBorderDecorationViews = [NSMutableArray array];
        
        NSUInteger numberOfDecorationViews = [self.datasource MAXLineChartNumberOfDecorationViewsForLowerBorder: self];
        
        for (int decorationNum = 0; decorationNum < numberOfDecorationViews; decorationNum++) {
            
            double lowerBorderValue = [self.datasource MAXLineChart: self valueForLowerBorderDecorationViewNumber: decorationNum];
            
            CGPoint centerPoint = CGPointMake( lowerBorderValue / [self p_highestXValueForChart] * self.frame.size.width, [self p_upperBorderWidth] + [self p_chartHeight] + [self p_lowerBorderWidth] / 2.0);
            
            UIView *decorationView = [self.datasource MAXLineChart: self lowerBorderDecorationViewWithCenterPosition: centerPoint decorationViewNumber: decorationNum];
            [self addSubview: decorationView];
            
            [lowerBorderDecorationViews addObject: decorationView];
        }
        
        return lowerBorderDecorationViews;
    }
    
    return nil;
    
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
    
    double height = CGRectGetHeight(self.frame);
    
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
