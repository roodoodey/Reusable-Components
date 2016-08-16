//
//  MAXChartViewController.m
//  ReusableComponentsApp
//
//  Created by Mathieu Skulason on 19/06/16.
//  Copyright © 2016 Konta ehf. All rights reserved.
//

#import "MAXChartViewController.h"
#import "MAXChartView.h"

@interface MAXChartViewController () <MAXChartViewDelegate, MAXChartViewDataSource> {
    
}

@end

@implementation MAXChartViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    MAXChartView *chartView = [[MAXChartView alloc] initWithFrame: CGRectMake(0, 64, CGRectGetWidth(self.view.frame), CGRectGetWidth(self.view.frame))];
    
    chartView.delegate = self;
    chartView.datasource = self;
    
    [self.view addSubview: chartView];
    
}

#pragma mark - Max Chart View Delegate



@end
