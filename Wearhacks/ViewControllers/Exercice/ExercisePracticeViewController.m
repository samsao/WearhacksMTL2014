//
//  ExerciceViewController.m
//  Wearhacks
//
//  Created by Gabriel Cartier on 2014-09-27.
//  Copyright (c) 2014 Samsao. All rights reserved.
//

#import "ExercisePracticeViewController.h"
#import "GaugeAppearanceHelper.h"
#import "CHCircleGaugeView+Zentice.h"
#import "ExerciseDoneOverlayViewController.h"
#import "ConnectingMyoModalViewController.h"
#import "MyoManager.h"
#import "WearHacksUtility.h"
#import "SSACoordinates.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "UIButtonRounded.h"

typedef enum {
    kSSAExerciceModeBegin,
    kSSAExerciceModeAscending,
    kSSAExerciceModeDescending,
    kSSAExerciceModeFinished,
} SSAExerciceMode;

@interface ExercisePracticeViewController ()
@property(weak, nonatomic) IBOutlet CHCircleGaugeView *circleChartView;
@property(weak, nonatomic) IBOutlet UIButtonRounded *startButton;
@property(strong, nonatomic) NSNumber *currentRepetitionCount;
@property(strong, nonatomic) PFObject *exercise;

@property(strong, nonatomic) NSMutableArray *referenceMovement;
@property(strong, nonatomic) NSMutableArray *userMovement;
@property(strong, nonatomic) NSMutableArray *userMaxCoords;
@property(strong, nonatomic) SSACoordinates *referenceMovementMaxCoord;
@property(strong, nonatomic) SSACoordinates *referenceMovementMinCoord;
@property(strong, nonatomic) SSACoordinates *userMaxReachCoord;
@property(assign, nonatomic) BOOL shouldReccord;
@property(assign, nonatomic) BOOL shouldPauseReccord;
@property(assign, nonatomic) BOOL showBothMovements;
@property(assign, nonatomic) BOOL shouldUpdateLog;
@property(assign, nonatomic) BOOL exerciceStarted;
@property(assign, nonatomic) double lastEventSeconds;
@property(assign, nonatomic) int userRepetitions;
@property(assign, nonatomic) SSAExerciceMode exerciceMode;

@end

@implementation ExercisePracticeViewController

static int const kRepetitions = 5;
static int const kDescendingDeltaDetection = 5;
static int const kExerciceRemoteId = 10;

#pragma mark - View lifecyle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (![MyoManager sharedInstance].myo) {
        //@TODO: Should be in a mediator
        [self performSegueWithIdentifier:EXERCISE_TO_CONNECTING_MYO sender:self];
        [self loadExerciseWithHUD:NO];
    } else {
        [self loadExerciseWithHUD:YES];
    }

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveOrientationEvent:)
                                                 name:TLMMyoDidReceiveOrientationEventNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //    [[NSNotificationCenter defaultCenter] removeObserver:self name:TLMMyoDidReceiveOrientationEventNotification object:nil];
}

#pragma mark - Utilities

/**
 *  Initialization
 */
- (void)initialize {
    self.currentRepetitionCount = 0;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveOrientationEvent:)
                                                 name:TLMMyoDidReceiveOrientationEventNotification
                                               object:nil];
    [self initializeGauge];
}

- (void)loadExerciseWithHUD:(BOOL)displayHUD {
    if (displayHUD) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    NSLog(@"Load exercice request");
    PFQuery *query = [PFQuery queryWithClassName:@"ExerciceData"];
    [query whereKey:@"typeID" equalTo:@10];
    query.limit = 1000;
    [query orderByAscending:@"order"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSLog(@"Retreived %ld objects", (long)objects.count);
        _referenceMovement = [NSMutableArray arrayWithCapacity:objects.count];
        for (PFObject *object in objects) {
            SSACoordinates *coord =
                [[SSACoordinates alloc] initWithRoll:[object[@"roll"] intValue] pitch:[object[@"pitch"] intValue] yaw:[object[@"yaw"] intValue]];
            [_referenceMovement addObject:coord];
        }

        NSLog(@"Loading finished");
        if (displayHUD) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
    }];
}

/**
 *  Initialize the gauges
 */
- (void)initializeGauge {

    [GaugeAppearanceHelper setupGaugeViewForExercice:self.circleChartView];
    [self.circleChartView setValue:0.5 animated:YES assignLabel:NO];
    [self.circleChartView setValueLabelWithNumber:[NSNumber numberWithInteger:100]];
}

#pragma mark - IBAction

- (IBAction)exerciseButtonTouchUpInside:(UIButton *)sender {
    _shouldReccord = !_shouldReccord;

    // start
    if (_shouldReccord) {
        _userMovement = [NSMutableArray array];
        _userMaxCoords = [NSMutableArray array];

        // get pitches
        NSArray *pitches = [_referenceMovement valueForKeyPath:@"pitch"];

        // get max and min values
        int maxPitch = [[pitches valueForKeyPath:@"@max.intValue"] intValue] - 5;
        int minPitch = [[pitches valueForKeyPath:@"@min.intValue"] intValue] + 5;
        NSLog(@"Min: %d - Max: %d", minPitch, maxPitch);

        NSArray *rolls = [_referenceMovement valueForKeyPath:@"roll"];
        int maxRoll = [[rolls valueForKeyPath:@"@max.intValue"] intValue] - 5;
        int minRoll = [[rolls valueForKeyPath:@"@min.intValue"] intValue] + 5;

        NSArray *yaws = [_referenceMovement valueForKeyPath:@"yaw"];
        int maxYaw = [[yaws valueForKeyPath:@"@max.intValue"] intValue] - 5;
        int minYaw = [[yaws valueForKeyPath:@"@min.intValue"] intValue] + 5;

        _referenceMovementMinCoord = [[SSACoordinates alloc] initWithRoll:minRoll pitch:minPitch yaw:minYaw];
        _referenceMovementMaxCoord = [[SSACoordinates alloc] initWithRoll:maxRoll pitch:maxPitch yaw:maxYaw];

        _userRepetitions = 0;
        [self updateRepetitions];

        _exerciceMode = kSSAExerciceModeBegin;
        _shouldUpdateLog = YES;
        [self updateLog];

        [_startButton setTitle:@"Stop exercice" forState:UIControlStateNormal];
    }
    // stop
    else {
        _exerciceMode = kSSAExerciceModeFinished;
        _exerciceStarted = NO;

        [self updateLog];

        if (_userRepetitions == kRepetitions) {
            [self performSegueWithIdentifier:EXERCISE_TO_MODAL sender:self];
        }

        [_startButton setTitle:@"Restart exercice" forState:UIControlStateNormal];
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //@FIXME: Should be in a mediator
    if ([segue.destinationViewController isKindOfClass:[ExerciseDoneOverlayViewController class]]) {
        ExerciseDoneOverlayViewController *destinationVC = (ExerciseDoneOverlayViewController *)segue.destinationViewController;
        destinationVC.delegate = self;

        NSLog(@"MAX COORDS %d", _userMaxCoords.count);
        destinationVC.exerciseData = [_userMaxCoords valueForKeyPath:@"pitch"];
    }
}

#pragma mark - Exercice

/**
 *  Increment the repetition count for an exercise
 */
- (void)incrementRepetition {
    //    if (self.currentRepetitionCount >= self.repetitionCount) {
    //        [self performSegueWithIdentifier:EXERCISE_TO_MODAL sender:self];
    //    }

    //@TODO: Implement logic
}

- (void)didReceiveOrientationEvent:(NSNotification *)notification {
    if (!_shouldReccord) {
        return;
    }

    double time = [[NSDate date] timeIntervalSince1970];
    if (time - _lastEventSeconds < 0.03) {
        return;
    }
    _lastEventSeconds = time;

    TLMOrientationEvent *orientation = notification.userInfo[kTLMKeyOrientationEvent];
    GLKQuaternion quat = orientation.quaternion;

    SSACoordinates *coord = [[SSACoordinates alloc] initWithQuaternion:quat];

    switch (_exerciceMode) {
    case kSSAExerciceModeBegin:
        if (coord.pitch <= _referenceMovementMinCoord.pitch) {
            NSLog(@"%d <= %d", coord.pitch, _referenceMovementMinCoord.pitch);
            NSLog(@"Switch to MODE ASC from BEGIN");
            _exerciceMode = kSSAExerciceModeAscending;
            [self updateLog];

            [[MyoManager sharedInstance].myo vibrateWithLength:TLMVibrationLengthShort];
            _exerciceStarted = YES;
        }
        break;

    case kSSAExerciceModeAscending:
        if (!_userMaxReachCoord || coord.pitch > _userMaxReachCoord.pitch) {
            NSLog(@"Set max reach coord: %d", coord.pitch);
            _userMaxReachCoord = coord;
        }

        if (coord.pitch >= _referenceMovementMaxCoord.pitch || (coord.pitch <= _userMaxReachCoord.pitch - kDescendingDeltaDetection &&
                                                                coord.pitch >= _referenceMovementMinCoord.pitch + kDescendingDeltaDetection)) {
            NSLog(@"%d >= %d OR %d <= %d", coord.pitch, _referenceMovementMaxCoord.pitch, coord.pitch, _userMaxReachCoord.pitch - kDescendingDeltaDetection);
            NSLog(@"Switch to MODE DESC from ASC");

            [_userMaxCoords addObject:coord];

            _userMaxReachCoord = [[SSACoordinates alloc] initWithCoordinates:_referenceMovementMinCoord];

            _exerciceMode = kSSAExerciceModeDescending;
            [self updateLog];

            [[MyoManager sharedInstance].myo vibrateWithLength:TLMVibrationLengthShort];
        }
        break;

    case kSSAExerciceModeDescending:
        if (coord.pitch <= _referenceMovementMinCoord.pitch) {
            NSLog(@"%d <= %d", coord.pitch, _referenceMovementMinCoord.pitch);
            NSLog(@"Switch to MODE ASC from DESC");
            _exerciceMode = kSSAExerciceModeAscending;
            _userRepetitions++;
            [self updateRepetitions];

            if (_userRepetitions == kRepetitions) {
                [_startButton sendActionsForControlEvents:UIControlEventTouchUpInside];
                [[MyoManager sharedInstance].myo vibrateWithLength:TLMVibrationLengthLong];
            } else {
                [self updateLog];
                [[MyoManager sharedInstance].myo vibrateWithLength:TLMVibrationLengthShort];
            }
        }
        break;
    }

    if (_exerciceStarted) {
        [_userMovement addObject:coord];

        // convert to scale of x/100
        CGFloat pitchInPercent = (CGFloat)(coord.pitch * 100.0) / (CGFloat)_referenceMovementMaxCoord.pitch;
        CGFloat val = (CGFloat)pitchInPercent / 100.0f;
        [_circleChartView setValue:val animated:YES assignLabel:NO];
        [_circleChartView setValueLabel:_userRepetitions / 100.0f];
    }
}

#pragma mark - Repetitions

- (void)updateLog {
    //@TODO
}

- (void)updateRepetitions {
    //@TODO:
}

#pragma mark - ExerciseDoneOverlayDelegate

- (void)exerciseDoneOverlayDidDimiss:(ExerciseDoneOverlayViewController *)viewController {
    [viewController dismissViewControllerAnimated:YES
                                       completion:^{//@TODO: Should go to the next exercise
                                                  }];
}
@end
