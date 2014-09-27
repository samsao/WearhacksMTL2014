//
//  RehabViewController.m
//  Wearhacks
//
//  Created by Gabriel Cartier on 2014-09-27.
//  Copyright (c) 2014 Samsao. All rights reserved.
//

#import "ScheduleViewController.h"

@interface ScheduleViewController ()

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation ScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


#pragma mark - UITableView Delegate & Data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"scheduleCell"];
    
    return cell;
}

@end
