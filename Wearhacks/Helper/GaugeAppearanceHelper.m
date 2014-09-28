//
//  GaugeAppearanceHelper.m
//  Wearhacks
//
//  Created by Gabriel Cartier on 2014-09-27.
//  Copyright (c) 2014 Samsao. All rights reserved.
//

#import "GaugeAppearanceHelper.h"
#import "UIColor+WearHackColors.h"

@implementation GaugeAppearanceHelper

/*
 trackTintColor: The color shown for the portion of the gauge that is always filled.
 gaugeTintColor: The color shown on top of trackTintColor for the portion of the gauge that varies based on the value property.
 textColor: The color of the text.
 font: The font of the text.
 trackWidth: The width for the portion of the gauge that is always filled. Defaults to a value of 0.5.
 gaugeWidth: The width for the portion of the gauge that varies based on the value property. Defaults to a value of 2.
 unitsString: String that is a suffix on the value. This string is meant to be just a few characters long. Defaults to nil.
 notApplicableString: The text shown when the state of the gauge is CHCircleGaugeViewStateNA. Defaults to "n/a".
 noDataString: The text shown when the state of the gauge is CHCircleGaugeViewStatePercentSign. Defaults to "%".
 gaugeStyle: Determines how the gauge is drawn relative to the track. Defaults to CHCircleGaugeStyleInside.

 */
+ (void)setupGaugeViewForExercice:(CHCircleGaugeView *)view {
    [view setTrackTintColor:[UIColor color3]];
    [view setGaugeTintColor:[UIColor color4]];
    [view setTrackWidth:20];
    [view setGaugeWidth:20];
}

@end
