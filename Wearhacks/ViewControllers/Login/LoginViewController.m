//
//  LoginViewController.m
//  Wearhacks
//
//  Created by Francois-Julien Alcaraz on 2014-09-27.
//  Copyright (c) 2014 Samsao. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

- (IBAction)facebookTapped:(id)sender;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor colorWithRed:0.129412F green:0.713725F blue:0.737255F alpha:1.0F];
}

- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];

    
    UILabel * title = [[UILabel alloc] init];
    title.text = @"WEARHACKS";
    title.frame = self.logInView.logo.frame;
    
    [self.logInView setLogo:title];
    
    [title sizeToFit];
    
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
