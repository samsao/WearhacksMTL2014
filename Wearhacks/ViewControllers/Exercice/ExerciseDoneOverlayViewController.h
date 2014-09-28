//
//  ExerciseDoneOverlayViewController.h
//  Wearhacks
//
//  Created by Gabriel Cartier on 2014-09-28.
//  Copyright (c) 2014 Samsao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GKLineGraph.h>

@protocol ExerciseDoneOverlayDelegate;

@interface ExerciseDoneOverlayViewController : UIViewController <GKLineGraphDataSource>

/**
 *  Delegate for the view controller
 */
@property(weak, nonatomic) id<ExerciseDoneOverlayDelegate> delegate;

/**
 *  Array of exercise
 */
@property(strong, nonatomic) NSArray *exerciseData;

@end

@protocol ExerciseDoneOverlayDelegate <NSObject>

/**
 *  Called when the exercise overlay dismisses
 *
 *  @param viewController the view controller
 */
- (void)exerciseDoneOverlayDidDimiss:(ExerciseDoneOverlayViewController *)viewController;

@end
