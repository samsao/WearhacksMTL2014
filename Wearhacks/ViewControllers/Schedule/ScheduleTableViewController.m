//
//  ScheduleTableViewController.m
//  Wearhacks
//
//  Created by Adrien CARANTA on 27/09/2014.
//  Copyright (c) 2014 Samsao. All rights reserved.
//

#import "ScheduleTableViewController.h"
#import "DayDetailTableViewController.h"

@interface ScheduleTableViewController ()

@property (nonatomic, strong) NSArray *exerciseDates;

@end

@implementation ScheduleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _exerciseDates = [[NSArray alloc] init];
    
    [self loadExerciseDate];
}

- (void)loadExerciseDate {
    
    PFQuery *query = [WearHacksUtility allExerciceDate];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (!error) {
            
            self.exerciseDates = objects;
            
            NSLog(@"Exercise Dates : %lu", (unsigned long)self.exerciseDates.count);
            
            [self.tableView reloadData];
            
        }
        
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.exerciseDates.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60; 
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"scheduleCell" forIndexPath:indexPath];
    
    NSDate *exerciseDate = [[self.exerciseDates objectAtIndex:indexPath.row] objectForKey:@"date"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
    NSString *formattedDateString = [dateFormatter stringFromDate:exerciseDate];
    NSLog(@"formattedDateString: %@", formattedDateString);
    
    UILabel *exerciseDateLabel = (UILabel *)[cell viewWithTag:100];
    exerciseDateLabel.text = formattedDateString;
    
    return cell;
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:WEEK_DAY_SEGUE]) {
        
        DayDetailTableViewController *detailViewController = [segue destinationViewController];
        detailViewController.parseObject = [self.exerciseDates objectAtIndex:self.tableView.indexPathForSelectedRow.row];
        
    }
    
}

@end
