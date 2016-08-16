//
//  MAXChartIndexPath.h
//  ReusableComponentsApp
//
//  Created by Mathieu Skulason on 20/06/16.
//  Copyright © 2016 Konta ehf. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MAXChartIndexPath : NSObject

/**
 @description The current section for the index path.
 */
@property (nonatomic, readonly) NSUInteger section;

/**
 @description The current column within the section for the index path.
 */
@property (nonatomic, readonly) NSUInteger column;

/**
 @description Convenience initializer to create an index path for the chart view which uses columns and not rows. Keeps terminology clear and simple.
 */
+(instancetype)MAXChartIndexPathWithSection:(NSUInteger)theSection column:(NSUInteger)theColumn;

@end

NS_ASSUME_NONNULL_END