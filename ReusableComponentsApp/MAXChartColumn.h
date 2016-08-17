//
//  MAXChartColumn.h
//  ReusableComponentsApp
//
//  Created by Mathieu Skulason on 19/06/16.
//  Copyright © 2016 Konta ehf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAXSelectedContentButton.h"

typedef void (^MAXChartColumnCompletionBlock)(void);

@interface MAXChartColumn : NSObject

@property (nonatomic, strong) MAXSelectedContentButton *view;

@property (nonatomic, strong) MAXSelectedContentButton *backgroundView;


@end
