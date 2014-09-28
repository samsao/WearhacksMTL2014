//
//  ExerciseDoneOverlayViewController.h
//  Wearhacks
//
//  Created by Gabriel Cartier on 2014-09-28.
//  Copyright (c) 2014 Samsao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ExerciseDoneOverlayDelegate;

@interface ExerciseDoneOverlayViewController : UIViewController

@property(weak, nonatomic) id<ExerciseDoneOverlayDelegate> delegate;

@end

@protocol ExerciseDoneOverlayDelegate <NSObject>

/**
 *  Called when the exercise overlay dismisses
 *
 *  @param viewController the view controller
 */
- (void)exerciseDoneOverlayDidDimiss:(ExerciseDoneOverlayViewController *)viewController;

@end
