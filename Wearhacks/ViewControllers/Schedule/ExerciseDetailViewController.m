//
//  ExerciseDetailViewController.m
//  Wearhacks
//
//  Created by Adrien CARANTA on 27/09/2014.
//  Copyright (c) 2014 Samsao. All rights reserved.
//

#import "ExerciseDetailViewController.h"
#import "ExercisePracticeViewController.h"
#import "UIButtonRounded.h"

@interface ExerciseDetailViewController ()

@property(weak, nonatomic) IBOutlet UILabel *titleLabel;
@property(weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property(weak, nonatomic) IBOutlet UIView *videoContainer;
@property(weak, nonatomic) IBOutlet UIButtonRounded *startButton;

@property(nonatomic, strong) NSURL *videoURL;
@property(nonatomic, strong) UIImage *videoThumbnail;

@end

@implementation ExerciseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.descriptionTextView.text = [self.exercise objectForKey:@"description"];

    PFFile *videoFile = [self.exercise objectForKey:@"video"];

    _videoURL = [NSURL URLWithString:videoFile.url];
    MPMoviePlayerController *player = [[MPMoviePlayerController alloc] initWithContentURL:self.videoURL];
    _videoThumbnail = [player thumbnailImageAtTime:1.0 timeOption:MPMovieTimeOptionNearestKeyFrame];
    player = nil;

    UIImageView *thumbnailView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 255, 167)];
    thumbnailView.image = self.videoThumbnail;
    [self.videoContainer addSubview:thumbnailView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.titleLabel setFont:[UIFont fontWithName:@"AvenirNextCondensed-Medium" size:32.0]];

    [self.startButton.titleLabel setFont:[UIFont fontWithName:@"AvenirNextCondensed-Medium" size:18.0]];

    [self.descriptionTextView setFont:[UIFont fontWithName:@"AvenirNextCondensed-Medium" size:15.0]];
}

- (IBAction)startExercise:(id)sender {
    ExercisePracticeViewController *destinationVC = [[UIStoryboard storyboardWithName:@"Exercice" bundle:nil] instantiateInitialViewController];
    destinationVC.exerciceId = self.exercise[@"exerciceDataID"];
    [self.navigationController pushViewController:destinationVC animated:YES];
    NSLog(@"Start Exercise button pressed");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
