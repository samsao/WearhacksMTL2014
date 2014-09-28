//
//  CHCircleGaugeView.m
//  Wearhacks
//
//  Created by Gabriel Cartier on 2014-09-27.
//  Copyright (c) 2014 Samsao. All rights reserved.
//

#import "CHCircleGaugeView.h"

@implementation CHCircleGaugeView (Zentice)

- (void)setRepetitionCounter:(NSNumber *)repetition {
}

- (void)setValueLabelWithNumber:(NSNumber *)value {
    [self setValueLabel:[value floatValue] / 100];
}

@end
