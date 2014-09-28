//
//  ExerciseDoneOverlayViewController.m
//  Wearhacks
//
//  Created by Gabriel Cartier on 2014-09-28.
//  Copyright (c) 2014 Samsao. All rights reserved.
//

#import "ExerciseDoneOverlayViewController.h"

@interface ExerciseDoneOverlayViewController ()

@property(weak, nonatomic) IBOutlet UIView *lineGraphView;
@property(strong, nonatomic) GKLineGraph *lineGraph;

@end

@implementation ExerciseDoneOverlayViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.]
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self initialize];
}

#pragma mark - Utilities

/**
 *  Initialization
 */
- (void)initialize {
    // Set the datasource
    self.lineGraph = [[GKLineGraph alloc] initWithFrame:self.lineGraphView.frame];
    [self.lineGraphView addSubview:self.lineGraph];
    self.lineGraph.dataSource = self;
    if (!self.exerciseData) {
        self.exerciseData = [NSArray new];
    }
    // Mock the exercise data
//    [self mockExerciseData];

    // Set the line graph width anbd draw it
    self.lineGraph.lineWidth = 3.0;

    [self.lineGraph draw];
}

/**
 *  Mock the exercise data
 */
- (void)mockExerciseData {
    self.exerciseData = @[ @10, @15, @10, @5, @10, @12, @14, @15, @12, @10, @5 ];
}

#pragma mark - IBAction

/**
 *  When view is tapped, dismiss the VC
 *
 *  @param sender the view
 */
- (IBAction)viewControllerTap:(id)sender {
    [self.delegate exerciseDoneOverlayDidDimiss:self];
}

#pragma mark - GKLineGraphDataSource

/**
 *  There's only 1 set of lines for the demo
 *  @TODO: should have historuc
 *
 *  @return 1 for now
 */
- (NSInteger)numberOfLines {
    return 1;
}

- (UIColor *)colorForLineAtIndex:(NSInteger)index {
    return [UIColor colorWithRed:133.0 green:246.0 blue:245.0 alpha:1.0];
}
- (NSArray *)valuesForLineAtIndex:(NSInteger)index {
    if (index == 0) {
        return self.exerciseData;
    } else {
        return nil;
    }
}

- (CFTimeInterval)animationDurationForLineAtIndex:(NSInteger)index {
    return 1.0;
}

- (NSString *)titleForLineAtIndex:(NSInteger)index {
    return [NSString stringWithFormat:@"%d", index];
}

@end
