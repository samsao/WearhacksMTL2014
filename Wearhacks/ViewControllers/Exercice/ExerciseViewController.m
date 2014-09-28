//
//  ExerciceViewController.m
//  Wearhacks
//
//  Created by Gabriel Cartier on 2014-09-27.
//  Copyright (c) 2014 Samsao. All rights reserved.
//

#import "ExerciseViewController.h"
#import "GaugeAppearanceHelper.h"
#import "CHCircleGaugeView+Zentice.h"
#import "ExerciseDoneOverlayViewController.h"
#import "ConnectingMyoModalViewController.h"
#import "MyoManager.h"
#import "UIButtonRounded.h"

@interface ExerciseViewController ()
@property(weak, nonatomic) IBOutlet CHCircleGaugeView *circleGaugeView;
@property(strong, nonatomic) NSNumber *currentRepetitionCount;
@property (weak, nonatomic) IBOutlet UIButtonRounded *doneButton;

@end

@implementation ExerciseViewController

#pragma mark - View lifecyle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.doneButton.titleLabel setFont:[UIFont fontWithName:@"AvenirNextCondensed-Medium" size:18.0]];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (![MyoManager sharedInstance].myo) {
        //@TODO: Should be in a mediator
        [self performSegueWithIdentifier:EXERCISER_TO_CONNECTING_MYO sender:self];
    }
}

#pragma mark - Utilities

/**
 *  Initialization
 */
- (void)initialize {
    self.currentRepetitionCount = 0;
    [self initializeGauge];
}

/**
 *  Initialize the gauges
 */
- (void)initializeGauge {

    [GaugeAppearanceHelper setupGaugeViewForExercice:self.circleGaugeView];
    [self.circleGaugeView setValue:0.5 animated:YES assignLabel:NO];
    [self.circleGaugeView setValueLabelWithNumber:[NSNumber numberWithInteger:100]];
}

#pragma mark - IBAction

- (IBAction)exerciseButtonTouchUpInside:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:NSLocalizedString(@"start exercise button", nil)]) {
        //@TODO : Start the exercise
        [sender setTitle:NSLocalizedString(@"stop exercise button", nil) forState:UIControlStateNormal];

    } else if ([sender.titleLabel.text isEqualToString:NSLocalizedString(@"stop exercise button", nil)]) {
        //@TODO : Stop the exercise
        [self incrementRepetition];
        [sender setTitle:NSLocalizedString(@"start exercise button", nil) forState:UIControlStateNormal];
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //@FIXME: Should be in a mediator
    if ([segue.destinationViewController isKindOfClass:[ExerciseDoneOverlayViewController class]]) {
        ExerciseDoneOverlayViewController *destinationVC = (ExerciseDoneOverlayViewController *)segue.destinationViewController;
        destinationVC.delegate = self;
    }
}

#pragma mark - Exercice

/**
 *  Increment the repetition count for an exercise
 */
- (void)incrementRepetition {
    if (self.currentRepetitionCount >= self.repetitionCount) {
        [self performSegueWithIdentifier:EXERCISE_TO_MODAL sender:self];
    }

    //@TODO: Implement logic
}

#pragma mark - ExerciseDoneOverlayDelegate

- (void)exerciseDoneOverlayDidDimiss:(ExerciseDoneOverlayViewController *)viewController {
    [viewController dismissViewControllerAnimated:YES
                                       completion:^{//@TODO: Should go to the next exercise
                                                  }];
}
@end
