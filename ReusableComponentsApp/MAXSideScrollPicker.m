//
//  MAXSideScrollPicker.m
//  ReusableComponentsApp
//
//  Created by Mathieu Grettir Skulason on 2/26/17.
//  Copyright © 2017 Konta ehf. All rights reserved.
//

#import "MAXSideScrollPicker.h"
#import "MAXFadeBlockButton.h"

@interface MAXSideScrollPicker ()

@property (nonatomic) NSInteger numSections;


@end

@implementation MAXSideScrollPicker


-(id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame: frame]) {
        
        self.scrollView = [[UIScrollView alloc] initWithFrame: CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.scrollView.showsHorizontalScrollIndicator = NO;
        
        [self addSubview: _scrollView];
        
        _isScrollIndicatorVisible = YES;
        _adjustsButtonsOnPick = YES;
        _isScrollIndicitaorWidthAdjustsable = YES;
        _scrollAnimationTime = 0.3f;
        _edgeInsets = UIEdgeInsetsZero;
        _scrollIndicatorPosition = MAXSideScrollIndicatorBottom;
        _selectedIndex = nil;
        
    }
    
    return self;
}


-(void)reloadData {
    
    _numSections = [self numSections];
    
    CGFloat accumWidth = self.edgeInsets.left;
    
    NSMutableArray *tmpButtons = [NSMutableArray array];
    for (int section = 0; section < _numSections; section++) {
        
        NSMutableArray *sectionButtons = [NSMutableArray array];
        
        NSInteger itemsInSection = [self.datasource MAXSideScrollPicker: self numberOfItemsInSection: section];
        
        if (section != _numSections - 1) {
            accumWidth += [self p_spaceAfterSection: section];
        }
        
        for (int item = 0; item < itemsInSection; item++) {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem: item inSection: section];
            
            MAXFadeBlockButton *button = [self p_createButtonAtOrigin:CGPointMake(accumWidth, 0) atIndexPath: [NSIndexPath indexPathForItem: item inSection: section] ];
            button.backgroundColor = [UIColor redColor];
            
            [sectionButtons addObject: button];
            
            accumWidth += button.frame.size.width;
            
            if (item != itemsInSection - 1) {
                accumWidth += [self p_widthForSpaceAtIndexPath: indexPath];
            }
            
        }
        
        [tmpButtons addObject: sectionButtons];
    }
    
    _buttons = tmpButtons;
    
    // if we do not have zero objects, and we do not have a selected index, default it to zero.
    if (self.buttons.count != 0 && _selectedIndex == nil) {
        if (self.buttons.firstObject.count != 0) {
            _selectedIndex = [NSIndexPath indexPathForItem: 0 inSection: 0];
            [self p_setSelectedIndexPath: _selectedIndex animated: YES];
        }
    }
    
    self.scrollView.contentSize = CGSizeMake(accumWidth + self.edgeInsets.right, self.frame.size.height);

}

-(NSInteger)numSections {
    
    if ([self.datasource respondsToSelector: @selector(MAXNumberOfSectionsForSideScrollPicker:)] == YES) {
        
        return [self.datasource MAXNumberOfSectionsForSideScrollPicker: self];
    }
    
    return 1;
}

-(NSInteger)numItems {
    
    NSInteger items = 0;
    
    _numSections = [self numSections];

    for (int section = 0; section < _numSections; section++) {
        
        NSInteger itemsToAdd = [self.datasource MAXSideScrollPicker: self numberOfItemsInSection: section];
        
        items += itemsToAdd;
        
    }
    
    return items;
}

-(void)setScrollIndicator:(UIView *)scrollIndicator {
    [_scrollIndicator removeFromSuperview];
    
    _scrollIndicator = scrollIndicator;
    [self addSubview: _scrollIndicator];
}

#pragma mark - Private Instance Methods

-(MAXFadeBlockButton *)p_createButtonAtOrigin:(CGPoint)origin atIndexPath:(NSIndexPath *)indexPath {
    
    MAXFadeBlockButton *fadeBlockButton = [[MAXFadeBlockButton alloc] initWithControlEvents: UIControlEventTouchUpInside | UIControlEventTouchDown];
    
    CGFloat buttonWidth = [self p_widthForItemAtIndexPath: indexPath];
    
    fadeBlockButton.frame = CGRectMake(origin.x, origin.y + self.edgeInsets.top, buttonWidth, self.frame.size.height - self.edgeInsets.top - self.edgeInsets.bottom - [self p_heightForScrollIndicator] - [self p_verticalSpaceForScrollIndicator]);
    [fadeBlockButton setTitle: [self p_textForItemAtIndexPath: indexPath] forState: UIControlStateNormal];
    [fadeBlockButton setTitleColor: [self p_textColorForItemAtIndexPath: indexPath] forState: UIControlStateNormal];
    [fadeBlockButton setTitleColor: [self p_textHighlightColorAtIndexPath: indexPath] forState: UIControlStateHighlighted];
    fadeBlockButton.titleLabel.font = [self p_fontForItemAtIndexPath: indexPath];
    
    __weak typeof (self) wSelf = self;
    [fadeBlockButton buttonTouchDownWithCompletion:^{
        
        [wSelf p_didSelectItemAtIndexPAth: indexPath];
        [wSelf p_setSelectedIndexPath: indexPath animated: YES];
        
    }];
    
    [self.scrollView addSubview: fadeBlockButton];
    
    return fadeBlockButton;
}

-(void)p_setSelectedIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated {
    
    MAXFadeBlockButton *button = [[self.buttons objectAtIndex: indexPath.section] objectAtIndex: indexPath.item];
    
    [self p_adjustButtonAndScrollIndicatorPickAtIndexPath: indexPath withButton: button animated: animated];
    [self p_updateScrollIndicatorPositionWithIndexPath: indexPath button: button animated: animated];
    
}

-(void)p_adjustButtonAndScrollIndicatorPickAtIndexPath:(NSIndexPath *)indexPath withButton:(MAXFadeBlockButton *)button animated:(BOOL)animated {
    
    NSInteger numItemsInSection = [self.datasource MAXSideScrollPicker: self numberOfItemsInSection: indexPath.section];
    
    
    CGFloat buttonMaxXPositionOnScreen = button.frame.origin.x + button.frame.size.width - self.scrollView.contentOffset.x;
    
    // moving to the right on screen
    if (buttonMaxXPositionOnScreen >= self.scrollView.frame.size.width) {
        
        CGFloat nextButtonWidth = 0;
        CGFloat widthBetweenButtons = 0;
        
        // last item but not in the last section so we need
        if (numItemsInSection - 1 == indexPath.item && _numSections - 1 != indexPath.section) {
            
            MAXFadeBlockButton *nextSectionButton = [[self.buttons objectAtIndex: indexPath.section + 1] objectAtIndex: 0];
            nextButtonWidth = nextSectionButton.frame.size.width;
            
            widthBetweenButtons = [self p_spaceAfterSection: indexPath.section];
            
            
        }
        else if(numItemsInSection - 1 != indexPath.item) {
            
            MAXFadeBlockButton *nextItemButton = [[self.buttons objectAtIndex: indexPath.section] objectAtIndex: indexPath.item + 1];
            nextButtonWidth = nextItemButton.frame.size.width;
            
            widthBetweenButtons = [self p_widthForSpaceAtIndexPath: indexPath];
            
        }
        
        if (numItemsInSection - 1 == indexPath.item && _numSections - 1 == indexPath.section) {
            widthBetweenButtons += self.edgeInsets.right;
        }
        
        CGFloat offsetX = buttonMaxXPositionOnScreen - self.scrollView.frame.size.width;
        
        CGPoint contentOffset = CGPointMake(self.scrollView.contentOffset.x + offsetX + nextButtonWidth / 2.0 + widthBetweenButtons, self.scrollView.contentOffset.y);
        
        if (animated == YES) {
            [UIView animateWithDuration: _scrollAnimationTime animations:^{
                
                self.scrollView.contentOffset = contentOffset;
                
            }];
        }
        else {
            
            self.scrollView.contentOffset = contentOffset;
            
        }
        
        
        return ;
    }
    
    CGFloat buttonMinXPositionOnScreen = button.frame.origin.x - self.scrollView.contentOffset.x;
    
    if (buttonMinXPositionOnScreen < 0) {
        
        // if it is not the last item we can move to the left
        CGRect nextButtonRect = CGRectZero;
        if (indexPath.item != 0) {
            MAXFadeBlockButton *previousButton = [[self.buttons objectAtIndex: indexPath.section] objectAtIndex: indexPath.item - 1];
            nextButtonRect = previousButton.frame;
        }
        else if(indexPath.item == 0 && indexPath.section != 0) {
            NSInteger numItemsInPreviuosSection = [self.datasource MAXSideScrollPicker: self numberOfItemsInSection: indexPath.section - 1];
            MAXFadeBlockButton *previousSectionButton = [[self.buttons objectAtIndex: indexPath.section - 1] objectAtIndex: numItemsInPreviuosSection - 1];
            nextButtonRect = previousSectionButton.frame;
        }
        
        CGFloat spaceBetweenItemsOrSections = 0;
        
        if (indexPath.item == 0 && indexPath.section != 0) {
            spaceBetweenItemsOrSections = [self p_spaceAfterSection: indexPath.section - 1];
        }
        else if(indexPath.item != 0) {
            spaceBetweenItemsOrSections = [self p_widthForSpaceAtIndexPath: [NSIndexPath indexPathForItem: indexPath.item - 1 inSection:indexPath.section]];
        }
        
        if (indexPath.item == 0 && indexPath.section == 0) {
            spaceBetweenItemsOrSections += self.edgeInsets.left;
        }
        
        CGPoint contentOffset = CGPointMake( _scrollView.contentOffset.x + buttonMinXPositionOnScreen - spaceBetweenItemsOrSections - nextButtonRect.size.width / 2.0, _scrollView.contentOffset.y);
        
        if (animated == YES) {
            [UIView animateWithDuration: _scrollAnimationTime animations:^{
                
                self.scrollView.contentOffset = contentOffset;
                
            }];
            
        }
        else {
            
            self.scrollView.contentOffset = contentOffset;
            
        }
        
        return ;
    }
    
}

-(void)p_updateScrollIndicatorPositionWithIndexPath:(NSIndexPath *)indexPath button:(MAXFadeBlockButton *)button animated:(BOOL)animated {
    
    if (_scrollIndicator == nil) {
        _scrollIndicator = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - [self p_heightForScrollIndicator] - self.edgeInsets.bottom, [self p_widthForItemAtIndexPath: indexPath], [self p_heightForScrollIndicator])];
        [self.scrollView addSubview: _scrollIndicator];
    }
    
    CGFloat newWidth = 0;
    if ([self.delegate respondsToSelector:@selector(MAXSideScrollPicker:scrollIndicatorWidthAtIndexPath:)] == YES) {
        newWidth = [self.delegate MAXSideScrollPicker: self scrollIndicatorWidthAtIndexPath: indexPath];
    }
    else if(self.isScrollIndicitaorWidthAdjustsable == YES) {
        newWidth = [self p_widthForItemAtIndexPath: indexPath];
    }
    else {
        newWidth = _scrollIndicator.frame.size.width;
    }
    
    CGFloat scrollIndicatorXPosition = button.frame.origin.x + button.frame.size.width / 2.0 - newWidth / 2.0;
    
    CGRect newFrame =  CGRectMake(scrollIndicatorXPosition, _scrollIndicator.frame.origin.y, newWidth, [self p_heightForScrollIndicator]);
    
    if (animated == YES) {
        
        [UIView animateWithDuration: _scrollAnimationTime animations:^{
            
            _scrollIndicator.frame = newFrame;
            
            if ([self.delegate respondsToSelector:@selector(MAXSideScrollPicker:scrollIndicatorColorAtIndexPath:)] == YES) {
                _scrollIndicator.backgroundColor = [self.delegate MAXSideScrollPicker: self scrollIndicatorColorAtIndexPath: indexPath];
            }
            
        }];
        
    }
    else {
        
        _scrollIndicator.frame = newFrame;
        
        if ([self.delegate respondsToSelector:@selector(MAXSideScrollPicker:scrollIndicatorColorAtIndexPath:)] == YES) {
            _scrollIndicator.backgroundColor = [self.delegate MAXSideScrollPicker: self scrollIndicatorColorAtIndexPath: indexPath];
        }
        
    }
    
}

#pragma mark - Delegate Optional Getters

-(CGFloat)p_widthForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.delegate respondsToSelector: @selector(MAXSideScrollPicker:widthForItemAtIndexPath:)] == YES) {
        
        return [self.delegate MAXSideScrollPicker: self widthForItemAtIndexPath: indexPath];
    }
    
    return 45;
}

-(CGFloat)p_widthForSpaceAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.delegate respondsToSelector: @selector(MAXSideScrollPicker:widthForSpaceAtIndexPath:)] == YES) {
        
        return [self.delegate MAXSideScrollPicker: self widthForSpaceAtIndexPath: indexPath];
    }
    
    return 5;
}

-(CGFloat)p_spaceAfterSection:(NSInteger)section {
    
    if ([self.delegate respondsToSelector:@selector(MAXSideScrollPicker:spaceAfterSection:)] == YES) {
        
        return [self.delegate MAXSideScrollPicker: self spaceAfterSection: section];
    }
    
    return 5;
}

-(CGFloat)p_verticalSpaceForScrollIndicator {
    
    if ([self.delegate respondsToSelector:@selector(MAXVerticalSpaceForScrollIndicatorWithSideScrollPicker:)] == YES) {
        
        return [self.delegate MAXVerticalSpaceForScrollIndicatorWithSideScrollPicker: self];
    }
    
    return 2;
}

-(CGFloat)p_heightForScrollIndicator {
    
    if ([self.delegate respondsToSelector:@selector(MAXHeightForScrollIndicatorWithSideScrollPicker:)] == YES) {
        
        return [self.delegate MAXHeightForScrollIndicatorWithSideScrollPicker: self];
    }
    
    return 2;
}

-(UIFont *)p_fontForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.delegate respondsToSelector: @selector(MAXSideScrollPicker:fontForItemAtIndexPath:)] == YES) {
        
        return [self.delegate MAXSideScrollPicker: self fontForItemAtIndexPath: indexPath];
    }
    
    return [UIFont systemFontOfSize: 15.0];
}

-(NSString *)p_textForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.delegate respondsToSelector:@selector(MAXSideScrollPicker:titleForItemAtIndexPath:)] == YES) {
        
        return [self.datasource MAXSideScrollPicker: self titleForItemAtIndexPath: indexPath];
    }
    
    return nil;
}

-(UIColor *)p_textColorForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.delegate respondsToSelector: @selector(MAXSideScrollPicker:textColorForItemAtIndexPath:)] == YES) {
        
        return [self.delegate MAXSideScrollPicker: self textColorForItemAtIndexPath: indexPath];
    }
 
    return [UIColor blackColor];
}

-(UIColor *)p_textHighlightColorAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.delegate respondsToSelector: @selector(MAXSideScrollPicker:textHighlightColorAtIndexPath:)] == YES) {
        
        return [self.delegate MAXSideScrollPicker: self textHighlightColorAtIndexPath: indexPath];
    }
    
    return [UIColor lightGrayColor];
}

-(void)p_didSelectItemAtIndexPAth:(NSIndexPath *)indexPath {
    
    if ([self.delegate respondsToSelector:@selector(MAXSideScrollPicker:didSelectItemAtIndexPath:)]) {
        [self.delegate MAXSideScrollPicker: self didSelectItemAtIndexPath: indexPath];
    }
    
}


@end
