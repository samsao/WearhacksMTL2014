//
//  LoginViewController.m
//  Wearhacks
//
//  Created by Francois-Julien Alcaraz on 2014-09-27.
//  Copyright (c) 2014 Samsao. All rights reserved.
//

#import "LoginViewController.h"
#import <UIColor+HTMLColors.h>

@interface LoginViewController ()

- (IBAction)facebookTapped:(id)sender;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];

    
    UILabel * title = [[UILabel alloc] init];
    title.text = @"WEARHACKS";
    title.frame = self.logInView.logo.frame;
    
    [self.logInView setLogo:title];
    
    [title sizeToFit];
    

    [self.logInView.facebookButton setTitle:@"Sign with Facebook" forState:UIControlStateNormal];
    [self.logInView.facebookButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 70)];
    
    UIImageView * logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_logo"]];
    [logo setCenter:CGPointMake(self.view.center.x, 80)];
    
    [self.logInView setLogo:nil];
    [self.logInView addSubview:logo];
    
    UIImageView * fakeContent = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_fake"]];
    [fakeContent setCenter:CGPointMake(self.view.center.x, 370)];
    [self.logInView addSubview:fakeContent];
    [self.logInView sendSubviewToBack:fakeContent];
    
    [self.logInView.facebookButton setCenter:CGPointMake(self.view.center.x, 190)];
    [self.logInView.facebookButton.titleLabel setFont:[UIFont fontWithName:@"AvenirNextCondensed-Medium" size:17.0]];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#3e3e3e"];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)facebookTapped:(id)sender {
    
}

@end
