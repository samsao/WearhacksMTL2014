//
//  ExerciseDetailViewController.h
//  Wearhacks
//
//  Created by Adrien CARANTA on 27/09/2014.
//  Copyright (c) 2014 Samsao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface ExerciseDetailViewController : UIViewController <UITextViewDelegate>

@property (nonatomic, strong) PFObject *exercise;

@end
