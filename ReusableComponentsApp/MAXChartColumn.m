//
//  MAXChartColumn.m
//  ReusableComponentsApp
//
//  Created by Mathieu Skulason on 19/06/16.
//  Copyright © 2016 Konta ehf. All rights reserved.
//

#import "MAXChartColumn.h"


@implementation MAXChartColumn


-(id)init {
    
    if (self = [super init]) {
        
        self.view = [[MAXSelectedContentButton alloc] init];
        
        self.backgroundView = [[MAXSelectedContentButton alloc] init];
        self.backgroundView.backgroundColor = [UIColor clearColor];
        
    }
    
    return self;
}





@end
