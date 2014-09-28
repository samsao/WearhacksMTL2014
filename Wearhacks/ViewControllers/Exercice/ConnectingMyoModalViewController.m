//
//  ConnectingMyoModalViewController.m
//  Wearhacks
//
//  Created by Gabriel Cartier on 2014-09-28.
//  Copyright (c) 2014 Samsao. All rights reserved.
//

#import "ConnectingMyoModalViewController.h"
#import "MyoManager.h"

@interface ConnectingMyoModalViewController ()

@end

@implementation ConnectingMyoModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Connect the Myo
    [self connectMyo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveConnectionEvent:) name:TLMHubDidConnectDeviceNotification object:nil];

    //@NOTE: Not used
    //    [[NSNotificationCenter defaultCenter] addObserver:self
    //                                             selector:@selector(didReceiveDisconnectEvent:)
    //                                                 name:TLMHubDidDisconnectDeviceNotification
    //                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:TLMHubDidConnectDeviceNotification object:nil];
    //    [[NSNotificationCenter defaultCenter] removeObserver:self name:TLMHubDidDisconnectDeviceNotification object:nil];
}

- (void)connectMyo {
    NSLog(@"Connecting to adjacent myo");
    [[TLMHub sharedHub] attachToAdjacent];
}

#pragma mark - Notifications

- (void)didReceiveConnectionEvent:(NSNotification *)notification {
    NSLog(@"Connection event");
    NSArray *devices = [[TLMHub sharedHub] myoDevices];
    if (devices.count == 0) {
        NSLog(@"Cannot find device");
        //@TODO Should display user's feedback
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
    }

    [MyoManager sharedInstance].myo = devices[0];
    NSLog(@"Myo connected: %@ - %@", [MyoManager sharedInstance].myo.name, [[MyoManager sharedInstance].myo.identifier UUIDString]);
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
