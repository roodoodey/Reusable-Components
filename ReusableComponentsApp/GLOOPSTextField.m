//
//  GLOOPSTextField.m
//  Gloops
//
//  Created by Mathieu Skulason on 25/04/15.
//  Copyright (c) 2015 Mathieu Skulason. All rights reserved.
//

#import "GLOOPSTextField.h"

@implementation GLOOPSTextField

@synthesize iconImageView;
@synthesize textField;

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.layer.cornerRadius = 4.0f;
        self.layer.backgroundColor = [UIColor whiteColor].CGColor;
        self.layer.borderWidth = 0.8f;
        self.layer.masksToBounds = YES;
        
        UIView *iconBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetHeight(self.frame), CGRectGetHeight(self.frame))];
        [self addSubview:iconBackgroundView];
        
        self.iconImageView = [[UIImageView alloc] initWithFrame:iconBackgroundView.frame];
        self.iconImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.iconImageView];
        
        self.textField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetWidth(iconBackgroundView.frame) + 3, 0, CGRectGetWidth(self.frame) - CGRectGetHeight(self.frame) - 6, CGRectGetHeight(self.frame))];
        self.textField.returnKeyType = UIReturnKeyDone;
        [self addSubview:self.textField];
        
    }
    
    return self;
}

@end
