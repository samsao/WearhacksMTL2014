//
//  ViewController.m
//  Wearhacks
//
//  Created by Gabriel Cartier on 2014-09-27.
//  Copyright (c) 2014 Samsao. All rights reserved.
//

#import "HomeViewController.h"
#import "LoginViewController.h"
#import "Facebook.h"
#import "UIStoryboard+WearHacks.h"

@interface HomeViewController () {
    NSMutableData *_data;
}

@property (weak, nonatomic) IBOutlet UIButton *signOutButton;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];

    if (![PFUser currentUser]) {
        // Customize the Log In View Controller
        LoginViewController *logInViewController = [[LoginViewController alloc] init];
        [logInViewController setDelegate:self];
        //        [logInViewController setFacebookPermissions:[NSArray arrayWithObjects:@"friends_about_me", nil]];
        [logInViewController setFields:PFLogInFieldsFacebook];

        // Present Log In View Controller
        [self presentViewController:logInViewController animated:NO completion:NULL];
    } else {
        [self downloadUserProfilePictures];
    }
}

#pragma mark - TEST METHODS

- (void)loadInjuries {

    PFQuery *query = [WearHacksUtility allExerciceDate];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"WStreamRootViewController Successfully retrieved %lu injuries.", (unsigned long)objects.count);

            for (PFObject *obj in objects) {

                NSLog(@"exercice date %@", [obj objectForKey:@"date"]);

                //                NSArray * exercices = [obj objectForKey:@"exercices"];
                //
                //                NSLog(@"injury count exercices %lu", [exercices count]);

                PFQuery *exerciseQuery = [WearHacksUtility allExercicesForExerciceDate:obj];

                [exerciseQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {

                    NSLog(@"exercices count %lu", [objects count]);

                    for (PFObject *obj in objects) {

                        NSLog(@"exercice name %@", [obj objectForKey:@"name"]);

//                        PFQuery *exerciseDataQuery = [WearHacksUtility allDataForExercice:obj];
//
//                        [exerciseDataQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//
//                            NSLog(@"exercices data count %lu", [objects count]);
//
//                            for (PFObject *data in objects) {
//                                NSLog(@"exercice data x %@ y %@ z %@", [data objectForKey:@"x"], [data objectForKey:@"y"], [data objectForKey:@"z"]);
//                            }
//                        }];
                    }
                }];
            }
        } else {

            // Log details of the failure
            NSLog(@"WStreamRootViewController Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    PFObject * testExo = [WearHacksUtility exerciceForGab];
    NSLog(@"TEST MOFOS %@", [testExo objectForKey:@"name"]);
}

#pragma mark - PFLogInViewControllerDelegate

// Sent to the delegate to determine whether the log in request should be submitted to the server.
- (BOOL)logInViewController:(PFLogInViewController *)logInController shouldBeginLogInWithUsername:(NSString *)username password:(NSString *)password {
    // Check if both fields are completed
    if (username && password && username.length && password.length) {
        return YES; // Begin login process
    }

    [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Missing Information", nil)
                                message:NSLocalizedString(@"Make sure you fill out all of the information!", nil)
                               delegate:nil
                      cancelButtonTitle:NSLocalizedString(@"OK", nil)
                      otherButtonTitles:nil] show];
    return NO; // Interrupt login process
}

// Sent to the delegate when a PFUser is logged in.
- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {

    //    [self.streamRootViewController loadWaves];

    FBRequest *request = [FBRequest requestForMe];

    // Send request to Facebook
    [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        if (!error) {
            // result is a dictionary with the user's Facebook data
            NSDictionary *userData = (NSDictionary *)result;

            NSString *facebookID = userData[@"id"];
            NSString *name = userData[@"name"];
            NSNumber *physio = [NSNumber numberWithBool:NO];
            //            NSString *location = userData[@"location"][@"name"];
            //            NSString *gender = userData[@"gender"];
            //            NSString *birthday = userData[@"birthday"];
            //            NSString *relationship = userData[@"relationship_status"];

            //            NSURL *pictureURL = [NSURL URLWithString:[NSString
            //            stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", facebookID]];

            // Now add the data to the UI elements
            // ...

            user[kWearHacksUserNameKey] = name;
            user[kWearHacksUserFacebookIDKey] = facebookID;
            user[kWearHacksUserPhysioKey] = physio;

            
            [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {

                PFInstallation *installation = [PFInstallation currentInstallation];
                installation[@"user"] = user;
                [installation saveInBackground];

                [self dismissViewControllerAnimated:YES completion:NULL];
            }];
        }
    }];
}

// Sent to the delegate when the log in attempt fails.
- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error {
    NSLog(@"Failed to log in...");
}

// Sent to the delegate when the log in screen is dismissed.
- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
    NSLog(@"User dismissed the logInViewController");
}

#pragma mark - Login methods

- (void)downloadUserProfilePictures {

    NSLog(@"downloadUserProfilePictures");

    // Download user's profile picture
    NSURL *profilePictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large",
                                                                               [[PFUser currentUser] objectForKey:kWearHacksUserFacebookIDKey]]];
    NSURLRequest *profilePictureURLRequest = [NSURLRequest requestWithURL:profilePictureURL
                                                              cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                          timeoutInterval:10.0f]; // Facebook profile picture cache policy: Expires in 2 weeks
    [NSURLConnection connectionWithRequest:profilePictureURLRequest delegate:self];
}

#pragma mark - NSURLConnectionDataDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    _data = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_data appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [WearHacksUtility processFacebookProfilePictureData:_data];
    [self loadInjuries];
}

#pragma mark - IBAction

/**
 *  When the schedule button is touched
 *
 *  @param sender the button
 */
- (IBAction)scheduleButtonTouchUpInside:(id)sender {
    
    UIViewController *scheduleVC = [[UIStoryboard scheduleStoryboard] instantiateViewControllerWithIdentifier:SCHEDULE_VIEW_CONTROLLER];
    [self.navigationController pushViewController:scheduleVC animated:YES];
}

/**
 *  When the progress button is touched
 *
 *  @param sender the button
 */
- (IBAction)progressButtonTouchUpInside:(id)sender {
}

/**
 *  When the profile button is touched
 *
 *  @param sender the button
 */
- (IBAction)profileButtonTouchUpInside:(id)sender {
}

/**
 *  When the achievements button is touched
 *
 *  @param sender the button
 */
- (IBAction)achievementsTouchUpInside:(id)sender {
    
}

- (IBAction)signOutButtonTouchUpInside:(id)sender {
    [PFUser logOut];
    
    
    if (![PFUser currentUser]) {
        // Customize the Log In View Controller
        LoginViewController *logInViewController = [[LoginViewController alloc] init];
        [logInViewController setDelegate:self];
        [logInViewController setFacebookPermissions:[NSArray arrayWithObjects:@"friends_about_me", nil]];
        [logInViewController setFields:  PFLogInFieldsFacebook];
        
        // Present Log In View Controller
        [self presentViewController:logInViewController animated:YES completion:NULL];
    }
}

@end
