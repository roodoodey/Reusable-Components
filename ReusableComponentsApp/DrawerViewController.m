//
//  DrawerViewController.m
//  ReusableComponentsApp
//
//  Created by Mathieu Skulason on 03/04/16.
//  Copyright © 2016 Konta ehf. All rights reserved.
//

#import "DrawerViewController.h"
#import "MAXDrawerView.h"
#import "MAXBlockButton.h"

@interface DrawerViewController () {
    MAXDrawerView *_drawerView;
}

@end

@implementation DrawerViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _drawerView = [[MAXDrawerView alloc] initWithFrame:CGRectMake(-120, 0, 120, CGRectGetHeight(self.view.frame))];
    _drawerView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_drawerView];
    
    MAXBlockButton *blockButton = [[MAXBlockButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame) / 2.0  - 60, 20, 120, 40)];
    [blockButton setTitle:@"Show" forState:UIControlStateNormal];
    [blockButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
    [blockButton buttonTouchUpInsideWithCompletion:^{
       
        blockButton.selected = !blockButton.isSelected;
        
        if (blockButton.isSelected == YES) {
            [_drawerView animateInWithCompletion:^{
                
            }];
        }
        else {
            [_drawerView animateOutWithCompletion:^{
                
            }];
        }
        
    }];
    
    [self.view addSubview:blockButton];
    
}

@end
