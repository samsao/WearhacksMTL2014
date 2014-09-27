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
}

- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    
    //Set facebook button image
//    self.facebookOnStateImage = [[self facebookImageForSelector: @selector(drawOnState) forSize:self.logInView.facebookButton.bounds.size whenHighlight:NO] resizableImageWithCapInsets: [self capInsets]];
//    self.facebookOffStateImage = [[self facebookImageForSelector: @selector(drawOnState) forSize:self.logInView.facebookButton.bounds.size whenHighlight:YES] resizableImageWithCapInsets: [self capInsets]];
//    [self.logInView.facebookButton setBackgroundImage:self.facebookOnStateImage forState: UIControlStateNormal];
//    [self.logInView.facebookButton setBackgroundImage:self.facebookOffStateImage forState: UIControlStateHighlighted];
    
    //Change title/image of facebook button
//    [self.logInView.facebookButton setTitle:nil forState:UIControlStateNormal];
//    [self.logInView.facebookButton setImage:nil forState:UIControlStateNormal];
    
    //    [self.logInView setLogo:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"waver_icon"]]];
    //    [self.logInView.logo setCenter:CGPointMake(self.view.center.x, self.view.center.y - 20)];
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
