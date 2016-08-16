//
//  MAXPagingScrollViewController.m
//  ReusableComponentsApp
//
//  Created by Mathieu Skulason on 25/02/16.
//  Copyright © 2016 Konta ehf. All rights reserved.
//

#import "MAXPagingScrollViewController.h"
#import "MAXPagingScrollView.h"

@interface MAXPagingScrollViewController () <MAXScrollViewDelegateAndDataSource>

@end

@implementation MAXPagingScrollViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    MAXPagingScrollView *pageScrollView = [[MAXPagingScrollView alloc] initWithFrame:CGRectMake(self.view.frame.size.width * 0.1, CGRectGetHeight(self.view.frame) * 0.1, CGRectGetWidth(self.view.frame) * 0.8, CGRectGetHeight(self.view.frame) * 0.8)];
    pageScrollView.backgroundColor = [UIColor orangeColor];
    pageScrollView.maxDelegate = self;
    //[pageScrollView reloadDataDelegate];
    //[pageScrollView reloadDataBlocks];
    [self.view addSubview:pageScrollView];
    
    
    [pageScrollView MAXScrollViewNumPagesWithBlock:^{
        
        return (NSInteger)3;
        
    }];
    
    [pageScrollView MAXScrollViewWithViewAtPageBlock:^(UIView *theView, NSInteger theIndex) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(theView.frame) / 2.0 - 100, CGRectGetHeight(theView.frame) / 2.0 - 20, 200, 40)];
        label.text = [NSString stringWithFormat:@"view number: %d", (int)theIndex];
        [theView addSubview:label];
        
        if (theIndex == 0) {
            label.textColor = [UIColor blueColor];
        }
        else if(theIndex == 1) {
            label.textColor = [UIColor purpleColor];
        }
        
    }];
    
}

#pragma mark - Paging

-(NSInteger)MAXScrollViewNumPages:(MAXPagingScrollView *)theScrollView {
    return 3;
}

-(void)MAXScrollView:(MAXPagingScrollView *)theScrollView view:(UIView *)theView atIndex:(NSInteger)theIndex {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(theView.frame) / 2.0 - 100, CGRectGetHeight(theView.frame) / 2.0 - 20, 200, 40)];
    label.text = [NSString stringWithFormat:@"view number: %d", (int)theIndex];
    [theView addSubview:label];
    
    if (theIndex == 0) {
        label.textColor = [UIColor blueColor];
    }
    else if(theIndex == 1) {
        label.textColor = [UIColor purpleColor];
    }
    
}

@end
