//
//  MAXBlockTapGestureRecognizer.h
//  LeagueManageriOS
//
//  Created by Mathieu Skulason on 31/07/16.
//  Copyright © 2016 Konta ehf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MAXBlockTapGestureRecognizer : UITapGestureRecognizer

+(instancetype)blockGestureRecognizerWithCompletion:(void (^)(void))completion;
-(id)initWithCompletion:(void (^)(void))completion;

@end
