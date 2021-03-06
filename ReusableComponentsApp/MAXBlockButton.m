//
//  MAXBlockButton.m
//  ReusableComponentsApp
//
//  Created by Mathieu Skulason on 18/02/16.
//  Copyright © 2016 Konta ehf. All rights reserved.
//

#import "MAXBlockButton.h"

typedef void (^CompletionBlock)(void);

@interface MAXBlockButton () {
    
    NSMutableArray *_touchDownBlocks;
    NSMutableArray *_touchDownRepeatBlocks;
    NSMutableArray *_touchDragInsideBlocks;
    NSMutableArray *_touchDragOutsideBlocks;
    NSMutableArray *_touchDragEnterBlocks;
    NSMutableArray *_touchDragExitBlocks;
    NSMutableArray *_touchUpInsideBlocks;
    NSMutableArray *_touchUpOutsideBlocks;
    NSMutableArray *_touchCancelBlocks;
    NSMutableArray *_touchAllEventsBlocks;
}

@end

@implementation MAXBlockButton

-(id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self p_setup];
    }
    
    return self;
}

-(id)init {
    if (self = [super init]) {
        [self p_setup];
    }
    
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self p_setup];
    }
    
    return self;
}

-(id)initWithControlEvents:(UIControlEvents)events {
    
    if (self = [super init]) {
        
        [self p_setupWithControlEvents: events];
        
    }
    
    return self;
}

-(void)p_setupWithControlEvents:(UIControlEvents)events {
    
    [self p_setupAllArrays];
    
    if((events & UIControlEventAllEvents) != 0x0) {
        [self p_setupAllControlerEvents];
    }
    else {
        
        if ((events & UIControlEventTouchDown) != 0x0) {
            [self addTarget:self action:@selector(buttonTouchDownAction) forControlEvents:UIControlEventTouchDown];
        }
        
        if((events & UIControlEventTouchDownRepeat) != 0x0) {
            [self addTarget:self action:@selector(buttonTouchDownRepeatAction) forControlEvents:UIControlEventTouchDownRepeat];
        }
        
        if((events & UIControlEventTouchDragInside) != 0x0) {
            [self addTarget:self action:@selector(buttonTouchDragInsideAction) forControlEvents:UIControlEventTouchDragInside];
        }
        
        if((events & UIControlEventTouchDragOutside) != 0x0) {
            [self addTarget:self action:@selector(buttonTouchDragOutsideAction) forControlEvents:UIControlEventTouchDragOutside];
        }
        
        if((events & UIControlEventTouchDragEnter) != 0x0) {
            [self addTarget:self action:@selector(buttonTouchDragEnterAction) forControlEvents:UIControlEventTouchDragEnter];
        }
        
        if((events & UIControlEventTouchDragExit) != 0x0) {
            [self addTarget:self action:@selector(buttonTouchDragExitAction) forControlEvents: UIControlEventTouchDragExit];
        }
        
        if((events & UIControlEventTouchUpInside) != 0x0) {
            [self addTarget:self action:@selector(buttonTouchUpInsideAction) forControlEvents: UIControlEventTouchUpInside];
        }
        
        if((events & UIControlEventTouchUpOutside) != 0x0) {
            [self addTarget:self action:@selector(buttonTouchUpOutsideAction) forControlEvents:UIControlEventTouchUpOutside];
        }
        
        if((events & UIControlEventTouchCancel) != 0x0) {
            [self addTarget:self action:@selector(buttonTouchAllEventsAction) forControlEvents:UIControlEventAllTouchEvents];
        }
        
    }
    
}

-(void)p_setup {
    
    [self p_setupAllArrays];
    [self p_setupAllControlerEvents];
    
}

-(void)p_setupAllArrays {
    
    _touchDownBlocks = [NSMutableArray array];
    _touchDownRepeatBlocks = [NSMutableArray array];
    _touchDragInsideBlocks = [NSMutableArray array];
    _touchDragOutsideBlocks = [NSMutableArray array];
    _touchDragEnterBlocks = [NSMutableArray array];
    _touchDragExitBlocks = [NSMutableArray array];
    _touchUpInsideBlocks = [NSMutableArray array];
    _touchUpOutsideBlocks = [NSMutableArray array];
    _touchCancelBlocks = [NSMutableArray array];
    _touchAllEventsBlocks = [NSMutableArray array];
    
}

-(void)p_setupAllControlerEvents {
    [self addTarget:self action:@selector(buttonTouchDownAction) forControlEvents:UIControlEventTouchDown];
    [self addTarget:self action:@selector(buttonTouchDownRepeatAction) forControlEvents:UIControlEventTouchDownRepeat];
    [self addTarget:self action:@selector(buttonTouchDragInsideAction) forControlEvents:UIControlEventTouchDragInside];
    [self addTarget:self action:@selector(buttonTouchDragOutsideAction) forControlEvents:UIControlEventTouchDragOutside];
    [self addTarget:self action:@selector(buttonTouchDragEnterAction) forControlEvents:UIControlEventTouchDragEnter];
    [self addTarget:self action:@selector(buttonTouchDragExitAction) forControlEvents:UIControlEventTouchDragExit];
    [self addTarget:self action:@selector(buttonTouchUpInsideAction) forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(buttonTouchUpOutsideAction) forControlEvents:UIControlEventTouchUpOutside];
    [self addTarget:self action:@selector(buttonTouchCancelAction) forControlEvents:UIControlEventTouchCancel];
    [self addTarget:self action:@selector(buttonTouchAllEventsAction) forControlEvents:UIControlEventAllTouchEvents];
}

#pragma mark - Button Actions

-(void)buttonTouchDownAction {
    for (CompletionBlock block in _touchDownBlocks) {
        block();
    }
}

-(void)buttonTouchDownRepeatAction {
    for (CompletionBlock block in _touchDownRepeatBlocks) {
        block();
    }
}

-(void)buttonTouchDragInsideAction {
    for (CompletionBlock block in _touchDownRepeatBlocks) {
        block();
    }
}

-(void)buttonTouchDragOutsideAction {
    for (CompletionBlock block in _touchDragOutsideBlocks) {
        block();
    }
}

-(void)buttonTouchDragEnterAction {
    for (CompletionBlock block in _touchDragEnterBlocks) {
        block();
    }
}

-(void)buttonTouchDragExitAction {
    for (CompletionBlock block in _touchDragExitBlocks) {
        block();
    }
}

-(void)buttonTouchUpInsideAction {
    for (CompletionBlock block in _touchUpInsideBlocks) {
        block();
    }
}

-(void)buttonTouchUpOutsideAction {
    for (CompletionBlock block in _touchUpOutsideBlocks) {
        block();
    }
}

-(void)buttonTouchCancelAction {
    for (CompletionBlock block in _touchCancelBlocks) {
        block();
    }
}

-(void)buttonTouchAllEventsAction {
    for (CompletionBlock block in _touchAllEventsBlocks) {
        block();
    }
}

#pragma mark - Completion Blocks

-(void)buttonTouchDownWithCompletion:(void (^)(void))block {
    [block copy];
    
    [_touchDownBlocks addObject: [block copy] ];
    
}

-(void)buttonTouchDownRepeatWithCompletion:(void (^)(void))block {
    [block copy];
    
    [_touchDownRepeatBlocks addObject: [block copy] ];
    
}

-(void)buttonTouchDragInsideWithCompletion:(void (^)(void))block {
    [block copy];
    
    [_touchDragInsideBlocks addObject: [block copy] ];
    
}

-(void)buttonTouchDragOutsideWithCompletion:(void (^)(void))block {
    [block copy];
    
    [_touchDragOutsideBlocks addObject:block];
    
}

-(void)buttonTouchDragEnterWithCompletion:(void (^)(void))block {
    [block copy];
    
    [_touchDragEnterBlocks addObject:block];
    
}

-(void)buttonTouchDragExitWithCompletion:(void (^)(void))block {
    [block copy];
    
    [_touchDragExitBlocks addObject:block];
    
}

-(void)buttonTouchUpInsideWithCompletion:(void (^)(void))block {
    [block copy];
    
    [_touchUpInsideBlocks addObject:block];
}

-(void)buttonTouchUpOutsideWithCompletion:(void (^)(void))block {
    [block copy];
    
    [_touchUpOutsideBlocks addObject:block];
}

-(void)buttonTouchCancelWithCompletion:(void (^)(void))block {
    [block copy];
    
    [_touchCancelBlocks addObject:block];
}

-(void)buttonTouchAllEventsWithCompletion:(void (^)(void))block {
    [block copy];
    
    [_touchAllEventsBlocks addObject:block];
}

@end
