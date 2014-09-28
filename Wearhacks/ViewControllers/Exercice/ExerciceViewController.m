//
//  ExerciceViewController.m
//  Wearhacks
//
//  Created by Gabriel Cartier on 2014-09-27.
//  Copyright (c) 2014 Samsao. All rights reserved.
//

#import "ExerciceViewController.h"
#import "GaugeAppearanceHelper.h"
#import <CHCircleGaugeView/CHCircleGaugeView.h>

@interface ExerciceViewController ()
@property(weak, nonatomic) IBOutlet CHCircleGaugeView *circleGaugeView;

@end

@implementation ExerciceViewController

#pragma mark - View lifecyle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeGauge];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Utilities

/**
 *  Initialize the gauges
 */
- (void)initializeGauge {
    [GaugeAppearanceHelper setupGaugeViewForExercice:self.circleGaugeView];
    [self.circleGaugeView setValue:0.5 animated:YES];
}

#pragma mark - CHCircleGauge

@end
