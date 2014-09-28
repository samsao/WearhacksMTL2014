//
//  ExercisePracticeViewController.h
//  Wearhacks
//
//  Created by Gabriel Cartier on 2014-09-28.
//  Copyright (c) 2014 Samsao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExerciseDoneOverlayViewController.h"
#import "WearHacksUtility.h"

@interface ExercisePracticeViewController : UIViewController <ExerciseDoneOverlayDelegate>

/**
 *  Number of repetition to do for the exercise
 */
@property(strong, nonatomic) NSNumber *exerciceId;

@end
