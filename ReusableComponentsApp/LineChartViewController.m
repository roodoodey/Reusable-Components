//
//  LineChartViewController.m
//  ReusableComponentsApp
//
//  Created by Mathieu Grettir Skulason on 8/17/16.
//  Copyright © 2016 Konta ehf. All rights reserved.
//

#import "LineChartViewController.h"
#import "MAXLineChartView.h"
#import "MAXFadeBlockButton.h"
#import "UIFont+MAXSystemFonts.h"

@interface LineChartViewController () <MAXLineChartViewDataSource, MAXLineChartDelegate>

@end

@implementation LineChartViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    MAXLineChartView *lineChartView = [[MAXLineChartView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetWidth(self.view.frame))];
    
    lineChartView.datasource = self;
    lineChartView.delegate = self;
    [lineChartView reloadData];
    
    [self.view addSubview: lineChartView];
    
    MAXFadeBlockButton *reloadButton = [[MAXFadeBlockButton alloc] initWithFrame: CGRectMake(CGRectGetMidX(self.view.frame) - 60, CGRectGetMaxY(lineChartView.frame) + 20, 120, 50)];
    reloadButton.layer.backgroundColor = [UIColor redColor].CGColor;
    reloadButton.layer.cornerRadius = 16.0;
    reloadButton.titleLabel.font = [UIFont c_helveticaNeueBoldWithSize: 17.0];
    
    [reloadButton setTitle: @"Reload" forState: UIControlStateNormal];
    [reloadButton setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
    
    [reloadButton buttonTouchUpInsideWithCompletion: ^{
        
        [lineChartView reloadData];
        
    }];
    
    [self.view addSubview: reloadButton];
    
}

-(NSUInteger)MAXNumberOfLinesForChart:(MAXLineChartView *)theChartView {
    
    return 1;
}

-(NSUInteger)MAXLineChart:(MAXLineChartView *)theChartView numberOfXValuesForLine:(NSUInteger)theLine {
    
    return 20;
}

#pragma mark - Color Delegate

-(double)MAXLineChart:(MAXLineChartView *)theChartView YValueAtX:(NSUInteger)theX line:(NSUInteger)theLine {
    
    
    if (theX < 5) {
        return 0;
    }
    
    return arc4random_uniform(100);
}

-(CGFloat)MAXLineChart:(MAXLineChartView *)TheLineChart widthForLine:(NSUInteger)theLine {
    
    return 5;
}

-(UIColor *)MAXLineChart:(MAXLineChartView *)theLineChart strokeColorForLine:(NSUInteger)theLine {
    
    return [UIColor purpleColor];
}

-(CGFloat)MAXLineChartLeftBorderWidthForChart:(MAXLineChartView *)theLineChart {
    
    return 5;
}

-(CGFloat)MAXLineChartLowerBorderHeightForChart:(MAXLineChartView *)theLineChart {
    
    return 5;
}

#pragma mark - Border Decoration Delegate

-(NSUInteger)MAXLineChartNumberOfDecorationViewsForLowerBorder:(MAXLineChartView *)theLineChart {
    
    
    return 6;
}

-(double)MAXLineChart:(MAXLineChartView *)theChartView xValueForLowerBorderDecorationViewAtIndex:(NSUInteger)theIndex {
    
    return 4 * theIndex;
}

-(UIView *)MAXLineChart:(MAXLineChartView *)theChartView lowerBorderDecorationViewAxisCenterPoint:(CGPoint)theCenterPoint atIndex:(NSUInteger)theIndex {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 4, 4)];
    view.layer.cornerRadius = 2;
    view.center = theCenterPoint;
    
    view.backgroundColor = [UIColor redColor];
    
    return view;
}

#pragma mark - Line Decoration Views

-(NSUInteger)MAXLineChart:(MAXLineChartView *)theChartView numDecorationViewsForLine:(NSUInteger)theLine {
    
    return 5;
}

-(double)MAXLineChart:(MAXLineChartView *)theChartView xValueForDecorationViewForLine:(NSUInteger)theLine atIndex:(NSUInteger)theIndex {
    
    if (theIndex == 0) {
        
        return  1.53;
    }
    else if(theIndex == 1) {
        
        return 3;
    }
    else if(theIndex == 2) {
        
        return 9;
    }
    else if(theIndex == 3) {
        
        return 11.23;
    }
    
    return 14.76;
}

-(UIView *)MAXLineChart:(MAXLineChartView *)theChartView decorationViewForLine:(NSUInteger)theLine atIndex:(NSUInteger)theIndex decorationViewPosition:(CGPoint)theDecorationViewPosition {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 6, 6)];
    view.center = theDecorationViewPosition;
    
    view.backgroundColor = [UIColor greenColor];
    
    return view;
}

-(CGFloat)MAXLineChartLeftMarginWidth:(MAXLineChartView *)theLineChart {
    
    return 40.0;
}

-(CGFloat)MAXLineChartRightMarginWidth:(MAXLineChartView *)theLineChart {
    
    return 40.0;
}

-(CGFloat)MAXLineChartUpperMarginHeight:(MAXLineChartView *)theLineChart {
    
    return 20.0;
}

-(CGFloat)MAXLineChartLowerMarginHeight:(MAXLineChartView *)theLineChart {
    
    return 20.0;
}

@end
