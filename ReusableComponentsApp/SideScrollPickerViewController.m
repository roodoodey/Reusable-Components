//
//  SideScrollPickerViewController.m
//  ReusableComponentsApp
//
//  Created by Mathieu Grettir Skulason on 2/26/17.
//  Copyright © 2017 Konta ehf. All rights reserved.
//

#import "SideScrollPickerViewController.h"
#import "MAXSideScrollPicker.h"

@interface SideScrollPickerViewController () <MAXSideScrollPickerDelegate, MAXSideScrollPickerDatasource>

@end

@implementation SideScrollPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    MAXSideScrollPicker *scrollPicker = [[MAXSideScrollPicker alloc] initWithFrame: CGRectMake(0, 44, 320, 40)];
    scrollPicker.datasource = self;
    scrollPicker.delegate = self;
    scrollPicker.edgeInsets = UIEdgeInsetsMake(2, 5, 2, 5);
    
    [scrollPicker reloadData];
    
    [self.view addSubview: scrollPicker];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 

-(NSInteger)MAXSideScrollPicker:(MAXSideScrollPicker *)sideScrollPicker numberOfItemsInSection:(NSInteger)section {
    
    return 10;
}

-(NSString *)MAXSideScrollPicker:(MAXSideScrollPicker *)sideScrollPicker titleForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.item == 0) {
        return @"first";
    }
    else if(indexPath.item == 1) {
        return @"second";
    }
    else if(indexPath.item == 2) {
        return @"third";
    }
    else if(indexPath.item == 3) {
        return @"fourth";
    }
    else if(indexPath.item == 4) {
        return @"fifth";
    }
    
    return @"Default";
}

-(CGFloat)MAXHeightForScrollIndicatorWithSideScrollPicker:(MAXSideScrollPicker *)sideScrollPicker {
    
    return 2;
}

-(CGFloat)MAXVerticalSpaceForScrollIndicatorWithSideScrollPicker:(MAXSideScrollPicker *)sideScrollPicker {
    
    return 6;
}

-(UIColor *)MAXSideScrollPicker:(MAXSideScrollPicker *)sideScrollPicker scrollIndicatorColorAtIndexPath:(NSIndexPath *)indexPath {
    
    return [UIColor greenColor];
}

-(CGFloat)MAXSideScrollPicker:(MAXSideScrollPicker *)sideScrollPicker widthForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.item == 2) {
        return 80;
    }
    
    if (indexPath.item == 5 || indexPath.item == 8) {
        
        return 40;
    }
    
    return 60;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
