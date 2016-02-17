//
//  GLOOPSViewController.h
//  Gloops
//
//  Created by Mathieu Skulason on 25/04/15.
//  Copyright (c) 2015 Mathieu Skulason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MAXViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

/** extra y offset when the keyboard is shown */
@property (nonatomic, readwrite) float keyboardYOffset;
@property (nonatomic, readwrite) BOOL preserveContentOffset;

-(void)keyboardWillShow:(NSNotification *)theNotification;
-(void)keyboardWillHide:(NSNotification *)theNotification;

-(void)textFieldWillBeginEditing:(NSNotification *)theNotification;
-(void)textFieldWillEndEditing:(NSNotification *)theNotification;

@end
