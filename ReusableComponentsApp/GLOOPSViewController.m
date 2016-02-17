//
//  GLOOPSViewController.m
//  Gloops
//
//  Created by Mathieu Skulason on 25/04/15.
//  Copyright (c) 2015 Mathieu Skulason. All rights reserved.
//

#import "GLOOPSViewController.h"

@interface GLOOPSViewController () {
    CGRect _viewToAdjustTo;
    CGPoint _preservedContentOffset;
    NSNotification *_keyboardNotif;
    
}

@end

@implementation GLOOPSViewController

@synthesize gloopsScrollView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.preserveContentOffset = YES;
    
    _viewToAdjustTo = CGRectZero;
    _preservedContentOffset = CGPointZero;
    _keyboardYOffset = 0;
    
    
    // Do any additional setup after loading the view.
    gloopsScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    gloopsScrollView.delegate = self;
    [self.view addSubview:gloopsScrollView];
    
    if (self.navigationController) {
        [self.navigationController setNavigationBarHidden:YES];
    }
 
 
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldWillBeginEditing:) name:UITextFieldTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldWillEndEditing:) name:UITextFieldTextDidEndEditingNotification object:nil];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Keyboard Events

- (void)keyboardWillShow:(NSNotification *)theNotification {
    NSLog(@"keyboard will show notificaiton: %@", theNotification);
    
    _keyboardNotif = theNotification;
    _preservedContentOffset = self.gloopsScrollView.contentOffset;
    
    float keyboardPositionInView = [[[theNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    float keyboardAnim = [[[theNotification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    float absolutePosition = _viewToAdjustTo.origin.y + _viewToAdjustTo.size.height + _keyboardYOffset - keyboardPositionInView;
    
    if (absolutePosition > 0) {
        [UIView animateWithDuration:keyboardAnim animations:^{
            self.gloopsScrollView.contentOffset = CGPointMake(self.gloopsScrollView.contentOffset.x, absolutePosition);
        } completion:^(BOOL finished) {
            
        }];
    }
    
    
    
}

- (void)keyboardWillHide:(NSNotification *)theNotification {
    _keyboardNotif = nil;
    float keyboadAnim = [[[theNotification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    if (self.preserveContentOffset == YES) {
        [UIView animateWithDuration:keyboadAnim animations:^{
            self.gloopsScrollView.contentOffset = _preservedContentOffset;
        } completion:^(BOOL finished) {
            
        }];
    }
    
}

#pragma mark - Text Field Events

-(void)textFieldWillBeginEditing:(NSNotification *)theNotification {
    UIView *textField = theNotification.object;
    
    _viewToAdjustTo = [self.view convertRect:textField.frame fromView:textField.superview];
    
    if (_keyboardNotif) {
        [self keyboardWillShow:_keyboardNotif];
    }
    
}

-(void)textFieldWillEndEditing:(NSNotification *)theNotification {
    _viewToAdjustTo = CGRectZero;
    
}

#pragma mark - 
#pragma mark Scroll View Delegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
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
