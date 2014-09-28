//
//  CHCircleGaugeView.h
//  Wearhacks
//
//  Created by Gabriel Cartier on 2014-09-27.
//  Copyright (c) 2014 Samsao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CHCircleGaugeView/CHCircleGaugeView.h>

@interface CHCircleGaugeView (Zentice)

/**
 *  Set the repetition counter (text in the middle) for the view
 *
 *  @param repetition the repetion counter
 */
- (void)setRepetitionCounter:(NSNumber *)repetition;

/**
 *  Set the value label
 *
 *  @param value the value
 */
- (void)setValueLabelWithNumber:(NSNumber *)value;

@end
