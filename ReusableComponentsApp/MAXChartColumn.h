//
//  MAXChartColumn.h
//  ReusableComponentsApp
//
//  Created by Mathieu Skulason on 19/06/16.
//  Copyright © 2016 Konta ehf. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^MAXChartColumnCompletionBlock)(void);

@interface MAXChartColumn : UIControl

/**
 @description This block is called when a UIControlEventTouchDown takes place. The column can register multiple blocks.
 
 @param completion The completion block for the button when pressed.
 */
-(void)touchDownWithCompletion:(MAXChartColumnCompletionBlock)completion;

/**
 @description This block is called when a UIControlEventTouchDownRepeat takes place. The column can register multiple blocks.
 
 @param completion The completion block for the button when pressed.
 */
-(void)touchDownRepeatWithCompletion:(MAXChartColumnCompletionBlock)completion;

/**
 @description This block is called when a UIControlEventTouchDragInside takes place. The column can register multiple blocks.
 
 @param completion The completion block for the button when pressed.
 */
-(void)touchDragInsideWithCompletion:(MAXChartColumnCompletionBlock)completion;

/**
 @description This block is called when a UIControlEventTouchDragOutside takes place. The column can register multiple blocks.
 
 @param completion The completion block for the button when pressed.
 */
-(void)touchDragOutsideWithCompletion:(MAXChartColumnCompletionBlock)completion;

/**
 @description This block is called when a UIControlEventTouchDragEnter takes place. The column can register multiple blocks.
 
 @param completion The completion block for the button when pressed.
 */
-(void)touchDragEnterWithCompletion:(MAXChartColumnCompletionBlock)completion;

/**
 @description This block is called when a UIControlEventTouchDragExit takes place. The column can register multiple blocks.
 
 @param completion The completion block for the button when pressed.
 */
-(void)touchDragExitWithCompletion:(MAXChartColumnCompletionBlock)completion;

/**
 @description This block is called when a UIControlEventTouchUpInside takes place. The column can register multiple blocks.
 
 @param completion The completion block for the button when pressed.
 */
-(void)touchUpInsideWithCompletion:(MAXChartColumnCompletionBlock)completion;

/**
 @description This block is called when a UIControlEventTouchUpOutside takes place. The column can register multiple blocks.
 
 @param completion The completion block for the button when pressed.
 */
-(void)touchUpOutsideWithCompletion:(MAXChartColumnCompletionBlock)completion;

/**
 @description This block is called when a UIControlEventTouchCancel takes place. The column can register multiple blocks.
 
 @param completion The completion block for the button when pressed.
 */
-(void)touchCancelWithCompletion:(MAXChartColumnCompletionBlock)completion;

@end
