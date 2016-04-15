//
//  ViewController.m
//  ReusableComponentsApp
//
//  Created by Mathieu Skulason on 17/02/16.
//  Copyright © 2016 Konta ehf. All rights reserved.
//

#import "ViewController.h"
#import "MAXViewController.h"
#import "MAXPagingScrollViewController.h"
#import "DrawerViewController.h"

/** This is a view controller that leads to you to see all other ui components through a basic table view */
@interface ViewController () <UITableViewDelegate, UITableViewDataSource> {
    UITableView *_tableView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 20)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
}

#pragma mark - Table View Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellIdentifier"];
    }
    
    cell.textLabel.text = [self nameAtIndexPath:indexPath];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        [self presentViewController:[[MAXViewController alloc] init] animated:YES completion:nil];
    }
    else if(indexPath.row == 1) {
        [self presentViewController:[[MAXPagingScrollViewController alloc] init] animated:YES completion:nil];
    }
    else if(indexPath.row == 2) {
        [self presentViewController:[[DrawerViewController alloc] init] animated:YES completion:nil];
    }
    
    
}

#pragma mark - Table View Helpers
-(NSString*)nameAtIndexPath:(NSIndexPath*)theIndexPath {
    if (theIndexPath.row == 0) {
        return @"Automatic Keyboard Handling";
    }
    else if(theIndexPath.row == 1) {
        return @"Paging Scroll view with delegate and blocks";
    }
    else if(theIndexPath.row == 2){
        return @"Drawer View ";
    }
    
    return @"Not Recognized";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
