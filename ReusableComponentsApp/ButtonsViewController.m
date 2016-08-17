//
//  ButtonsViewController.m
//  ReusableComponentsApp
//
//  Created by Mathieu Grettir Skulason on 8/16/16.
//  Copyright © 2016 Konta ehf. All rights reserved.
//

#import "ButtonsViewController.h"

#import "MAXSelectedContentButton.h"
#import "MAXFadeBlockButton.h"
#import "MAXBlockButton.h"

@implementation ButtonsViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    MAXSelectedContentButton *selectedContentButton = [[MAXSelectedContentButton alloc] init];
    selectedContentButton.frame = CGRectMake(CGRectGetMidX(self.view.frame) - 60, 20, 120, 50);
    selectedContentButton.backgroundColor = [UIColor redColor];
    
    [self.view addSubview: selectedContentButton];
    
}

@end
