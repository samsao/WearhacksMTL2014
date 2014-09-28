//
//  ExerciseDoneOverlayViewController.m
//  Wearhacks
//
//  Created by Gabriel Cartier on 2014-09-28.
//  Copyright (c) 2014 Samsao. All rights reserved.
//

#import "ExerciseDoneOverlayViewController.h"

@interface ExerciseDoneOverlayViewController ()

@end

@implementation ExerciseDoneOverlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.]
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)viewControllerTap:(id)sender {
    [self.delegate exerciseDoneOverlayDidDimiss:self];
}

@end
