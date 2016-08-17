//
//  MAXChartViewController.m
//  ReusableComponentsApp
//
//  Created by Mathieu Skulason on 19/06/16.
//  Copyright © 2016 Konta ehf. All rights reserved.
//

#import "MAXChartViewController.h"
#import "MAXChartView.h"
#import "MAXSelectedContentButton.h"

@interface MAXChartViewController () <MAXChartViewDelegate, MAXChartViewDataSource> {
    
}

@end

@implementation MAXChartViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    MAXChartView *chartView = [[MAXChartView alloc] initWithFrame: CGRectMake(0, 64, CGRectGetWidth(self.view.frame), CGRectGetWidth(self.view.frame))];
    chartView.chartDirection = kMAXChartDirectionHorizontalLeft;
    
    chartView.delegate = self;
    chartView.datasource = self;
    
    [chartView reloadData];
    
    [self.view addSubview: chartView];
    
}

#pragma mark - Max Chart View Delegate

-(NSUInteger)MAXChartView:(MAXChartView *)theChartView numberOfColumnsInSection:(NSUInteger)theSection {
    
    return 10;
}

-(CGFloat)MAXChartView:(MAXChartView *)theChartView widthForColumnAtIndexPath:(MAXChartIndexPath *)theIndexPath {
    
    return 10;
}

-(CGFloat)MAXChartView:(MAXChartView *)theChartView spaceForSection:(NSUInteger)theSection {
    
    return 10;
}

-(CGFloat)MAXChartView:(MAXChartView *)theChartView spaceForColumnAtIndexPath:(MAXChartIndexPath *)theIndexPath {
    
    return 4;
}

-(double)MAXChartView:(MAXChartView *)theChartView valueAtIndexPath:(MAXChartIndexPath *)theIndexPath {
    
    return arc4random_uniform(100);
}

-(void)MAXChartView:(MAXChartView *)theChartView customizeColumnView:(MAXSelectedContentButton *)theColumnView columnBackgroundView:(MAXSelectedContentButton *)theColumnBackgorundView atIndexPath:(MAXChartIndexPath *)theIndexPath {
    
    theColumnView.backgroundColor = [UIColor redColor];
    
    [theColumnView buttonTouchDownWithCompletion: ^{
       
        
    }];
    
}

-(void)MAXChartView:(MAXChartView *)theChartView sectionSpaceDecorationView:(UIView *)theSectionSpaceDecorationView section:(NSInteger)theSection {
    
    theSectionSpaceDecorationView.backgroundColor = [UIColor blueColor];
    
}

-(void)MAXChartView:(MAXChartView *)theChartView columnSpaceDecorationView:(UIView *)theColumnSpaceDecorationView indexPath:(MAXChartIndexPath *)theIndexPath {
    
    theColumnSpaceDecorationView.backgroundColor = [UIColor greenColor];
    
}


@end
