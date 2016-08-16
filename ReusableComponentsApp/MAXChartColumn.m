//
//  MAXChartColumn.m
//  ReusableComponentsApp
//
//  Created by Mathieu Skulason on 19/06/16.
//  Copyright © 2016 Konta ehf. All rights reserved.
//

#import "MAXChartColumn.h"

@interface MAXChartColumn () {
    
    NSMutableArray *_touchDownEvents;
    NSMutableArray *_touchDownRepeatEvents;
    NSMutableArray *_touchDragInsideEvents;
    NSMutableArray *_touchDragOutsideEvents;
    NSMutableArray *_touchDragEnterEvents;
    NSMutableArray *_touchDragExitEvents;
    NSMutableArray *_touchUpInsideEvents;
    NSMutableArray *_touchUpOutsideEvents;
    NSMutableArray *_touchCancelEvents;
    
}

@end

@implementation MAXChartColumn

-(id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame: frame]) {
        [self p_setup];
    }
    
    return self;
    
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder: aDecoder]) {
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

-(void)p_setup {
    
    _touchDownEvents = [NSMutableArray array];
    _touchDownRepeatEvents = [NSMutableArray array];
    _touchDragInsideEvents = [NSMutableArray array];
    _touchDragOutsideEvents = [NSMutableArray array];
    _touchDragEnterEvents = [NSMutableArray array];
    _touchDragExitEvents = [NSMutableArray array];
    _touchUpInsideEvents = [NSMutableArray array];
    _touchUpOutsideEvents = [NSMutableArray array];
    _touchCancelEvents = [NSMutableArray array];
    
    [self addTarget: self action: @selector(p_touchDown) forControlEvents: UIControlEventTouchDown];
    [self addTarget: self action: @selector(p_touchDownRepeat) forControlEvents: UIControlEventTouchDownRepeat];
    [self addTarget: self action: @selector(p_touchDragInside) forControlEvents: UIControlEventTouchDragInside];
    [self addTarget: self action: @selector(p_touchDragOutside) forControlEvents: UIControlEventTouchDragOutside];
    [self addTarget: self action: @selector(p_touchDragEnter) forControlEvents: UIControlEventTouchDragEnter];
    [self addTarget: self action: @selector(p_touchDragExit) forControlEvents: UIControlEventTouchDragExit];
    [self addTarget: self action: @selector(p_touchUpInside) forControlEvents: UIControlEventTouchUpInside];
    [self addTarget: self action: @selector(p_touchUpOutside) forControlEvents: UIControlEventTouchUpOutside];
    [self addTarget: self action: @selector(p_touchCancel) forControlEvents: UIControlEventTouchCancel];
    
}

#pragma mark - Completion Blocks

-(void)touchDownWithCompletion:(MAXChartColumnCompletionBlock)completion {
    
    [_touchDownEvents addObject: completion];

}

-(void)touchDownRepeatWithCompletion:(MAXChartColumnCompletionBlock)completion {
    
    [_touchDownRepeatEvents addObject: completion];
    
}

-(void)touchDragInsideWithCompletion:(MAXChartColumnCompletionBlock)completion {
    
    [_touchDragInsideEvents addObject: completion];
    
}

-(void)touchDragOutsideWithCompletion:(MAXChartColumnCompletionBlock)completion {
    
    [_touchDragOutsideEvents addObject: completion];
    
}

-(void)touchDragEnterWithCompletion:(MAXChartColumnCompletionBlock)completion {
    
    [_touchDragEnterEvents addObject: completion];
    
}

-(void)touchDragExitWithCompletion:(MAXChartColumnCompletionBlock)completion {
    
    [_touchDragExitEvents addObject: completion];
    
}

-(void)touchUpInsideWithCompletion:(MAXChartColumnCompletionBlock)completion {
    
    [_touchUpInsideEvents addObject: completion];
    
}

-(void)touchUpOutsideWithCompletion:(MAXChartColumnCompletionBlock)completion {
    
    [_touchUpOutsideEvents addObject: completion];
    
}

-(void)touchCancelWithCompletion:(MAXChartColumnCompletionBlock)completion {
    
    [_touchCancelEvents addObject: completion];
    
}

#pragma mark - Private Events

-(void)p_touchDown {
    [self p_dispatchBlocksInArray: _touchDownEvents];
}

-(void)p_touchDownRepeat {
    [self p_dispatchBlocksInArray: _touchDownRepeatEvents];
}

-(void)p_touchDragInside {
    [self p_dispatchBlocksInArray: _touchDragInsideEvents];
}

-(void)p_touchDragOutside {
    [self p_dispatchBlocksInArray: _touchDragOutsideEvents];
}

-(void)p_touchDragEnter {
    [self p_dispatchBlocksInArray: _touchDragEnterEvents];
}

-(void)p_touchDragExit {
    [self p_dispatchBlocksInArray: _touchDragExitEvents];
}

-(void)p_touchUpInside {
    [self p_dispatchBlocksInArray: _touchUpInsideEvents];
}

-(void)p_touchUpOutside {
    [self p_dispatchBlocksInArray: _touchUpOutsideEvents];
}

-(void)p_touchCancel {
    [self p_dispatchBlocksInArray: _touchCancelEvents];
}

#pragma mark Event dispatch

-(void)p_dispatchBlocksInArray:(NSArray *)theBlocks {
    
    for (MAXChartColumnCompletionBlock block in theBlocks) {
        
        block();
        
    }
    
}

@end
