//
//  MAXSideScrollPicker.h
//  ReusableComponentsApp
//
//  Created by Mathieu Grettir Skulason on 2/26/17.
//  Copyright © 2017 Konta ehf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN;

@class MAXSideScrollPicker;
@class MAXFadeBlockButton;

typedef NS_ENUM(NSInteger, MAXSideScrollIndicatorPosition) {
    MAXSideScrollIndicatorBottom,
    MAXSideScrollIndicatorTop
};

@protocol MAXSideScrollPickerDelegate <NSObject>

@optional

-(CGFloat)MAXSideScrollPicker:(MAXSideScrollPicker *)sideScrollPicker widthForItemAtIndexPath:(NSIndexPath *)indexPath;

-(CGFloat)MAXSideScrollPicker:(MAXSideScrollPicker *)sideScrollPicker widthForSpaceAtIndexPath:(NSIndexPath *)indexPath;

-(CGFloat)MAXSideScrollPicker:(MAXSideScrollPicker *)sideScrollPicker spaceAfterSection:(NSInteger)section;

-(UIFont *)MAXSideScrollPicker:(MAXSideScrollPicker *)sideScrollPicker fontForItemAtIndexPath:(NSIndexPath *)indexPath;

-(UIColor *)MAXSideScrollPicker:(MAXSideScrollPicker *)sideScrollPicker textColorForItemAtIndexPath:(NSIndexPath *)indexPath;

-(UIColor *)MAXSideScrollPicker:(MAXSideScrollPicker *)sideScrollPicker textHighlightColorAtIndexPath:(NSIndexPath *)indexPath;

-(void)MAXSideScrollPicker:(MAXSideScrollPicker *)sideScrollPicker didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

// For Scroll Indicator

-(CGFloat)MAXHeightForScrollIndicatorWithSideScrollPicker:(MAXSideScrollPicker *)sideScrollPicker;

-(CGFloat)MAXVerticalSpaceForScrollIndicatorWithSideScrollPicker:(MAXSideScrollPicker *)sideScrollPicker;

-(CGFloat)MAXSideScrollPicker:(MAXSideScrollPicker *)sideScrollPicker scrollIndicatorWidthAtIndexPath:(NSIndexPath *)indexPath;

-(UIColor *)MAXSideScrollPicker:(MAXSideScrollPicker *)sideScrollPicker scrollIndicatorColorAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol MAXSideScrollPickerDatasource <NSObject >

@optional

-(NSInteger)MAXNumberOfSectionsForSideScrollPicker:(MAXSideScrollPicker *)sideScrollPicker;

@required

-(NSInteger)MAXSideScrollPicker:(MAXSideScrollPicker *)sideScrollPicker numberOfItemsInSection:(NSInteger)section;

-(NSString *)MAXSideScrollPicker:(MAXSideScrollPicker *)sideScrollPicker titleForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface MAXSideScrollPicker : UIView

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic) BOOL isScrollIndicatorVisible;

@property (nonatomic) BOOL isScrollIndicitaorWidthAdjustsable;

@property (nonatomic) BOOL adjustsButtonsOnPick;

@property (nonatomic) UIEdgeInsets edgeInsets;

@property (nonatomic) double scrollAnimationTime;

@property (nonatomic) double scrollIndicatorAnimationTime;

@property (nonatomic) MAXSideScrollIndicatorPosition scrollIndicatorPosition;

@property (nonatomic, strong) NSArray <NSArray <MAXFadeBlockButton *> *> *buttons;

@property (nonatomic, strong) UIView *scrollIndicator;

@property (nonatomic, weak) id <MAXSideScrollPickerDelegate> delegate;

@property (nonatomic, weak) id <MAXSideScrollPickerDatasource> datasource;

@property (nonatomic, strong) NSIndexPath *selectedIndex;

-(id)initWithFrame:(CGRect)frame;

-(void)reloadData;

/**
 @description The number of items in all sections provided by the delegate.
 */
-(NSInteger)numItems;

/**
 @description The number of sections provided by the delegate.
 */
-(NSInteger)numSections;

@end

NS_ASSUME_NONNULL_END;
