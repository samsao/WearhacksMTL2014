//
//  GaugeAppearanceHelper.h
//  Wearhacks
//
//  Created by Gabriel Cartier on 2014-09-27.
//  Copyright (c) 2014 Samsao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CHCircleGaugeView/CHCircleGaugeView.h>

@interface GaugeAppearanceHelper : NSObject

/**
 *  Setup the gaugge view in the exercice view
 *
 *  @param view the gauge view
 */
+ (void)setupGaugeViewForExercice:(CHCircleGaugeView *)view;

@end
