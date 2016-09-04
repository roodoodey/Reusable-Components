//
//  MAXBlockTapGestureRecognizer.m
//  LeagueManageriOS
//
//  Created by Mathieu Skulason on 31/07/16.
//  Copyright © 2016 Konta ehf. All rights reserved.
//

#import "MAXBlockTapGestureRecognizer.h"

@interface MAXBlockTapGestureRecognizer () {
    void (^_completionBlock)(void);
}

@end

@implementation MAXBlockTapGestureRecognizer

+(instancetype)blockGestureRecognizerWithCompletion:(void (^)(void))completion {
    
    MAXBlockTapGestureRecognizer *recognizer = [[MAXBlockTapGestureRecognizer alloc] initWithCompletion: completion];
    
    return recognizer;
    
}

-(id)initWithCompletion:(void (^)(void))completion {
    
    if (self = [super init]) {
        
        _completionBlock = completion;
        [self addTarget: self action: @selector(runCompletionBlock)];
        
    }
    
    return self;
}

-(void)runCompletionBlock {
    if (_completionBlock != nil) {
        _completionBlock();
    }
}

@end
