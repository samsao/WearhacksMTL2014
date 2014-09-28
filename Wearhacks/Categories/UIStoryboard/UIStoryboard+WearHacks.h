//
//  UIStoryboard+WearHacks.h
//  Wearhacks
//
//  Created by Francois-Julien Alcaraz on 2014-09-28.
//  Copyright (c) 2014 Samsao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIStoryboard (WearHacks)

/**
 *  Get the Main storyboard
 *
 *  @return The storyboard
 */
+ (UIStoryboard *)mainStoryboard;

/**
 *  Get the Form storyboard
 *
 *  @return The storyboard
 */
+ (UIStoryboard *)scheduleStoryboard;

/**
 *  Get the Products storyboard
 *
 *  @return The storyboard
 */
+ (UIStoryboard *)rehabStoryboard;

@end
