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

-(CGFloat)MAXLineChartLowerBorderWidthForChart:(MAXLineChartView *)theLineChart {
    
    return 5;
}

@end
