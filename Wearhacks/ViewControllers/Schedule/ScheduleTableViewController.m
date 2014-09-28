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

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.title = @"Schedule";
    
}

- (void)loadExerciseDate {
    
    PFQuery *query = [WearHacksUtility allExerciceDate];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (!error) {
            
            self.exerciseDates = [self sortArray:objects];
            
            NSLog(@"Exercise Dates : %lu", (unsigned long)self.exerciseDates.count);
            
            [self.tableView reloadData];
            
        }
        
    }];
    
}

- (NSArray *)sortArray:(NSArray *)arrayToSort {
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
    NSArray *descriptors = @[sortDescriptor];
    NSArray *sortedArray = [arrayToSort sortedArrayUsingDescriptors:descriptors];
    
    return sortedArray;
    
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
    dateFormatter.timeZone = [NSTimeZone localTimeZone];
    
    NSString *preferredLanguage = [[NSLocale preferredLanguages] objectAtIndex:0];
    NSLog(@"%@", preferredLanguage);
    
    if ([preferredLanguage isEqualToString:@"en_US"] || [preferredLanguage isEqualToString:@"en"])
    {
        // English
        dateFormatter.dateFormat = [NSString stringWithFormat:@"EEEE dd'%@'", [self daySuffixForDate:exerciseDate]];
    }
    else if([preferredLanguage isEqualToString:@"fr"])
    {
        // Spanish
        dateFormatter.dateFormat = @"EEEE dd";
    }
    
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
        
        self.title = @"";
        DayDetailTableViewController *detailViewController = [segue destinationViewController];
        detailViewController.parseObject = [self.exerciseDates objectAtIndex:self.tableView.indexPathForSelectedRow.row];
        
    }
    
}

- (NSString *)daySuffixForDate:(NSDate *)date {
    NSInteger day_of_month = [[[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:date] day];
    switch (day_of_month) {
        case 1:
        case 21:
        case 31: return @"st";
        case 2:
        case 22: return @"nd";
        case 3:
        case 23: return @"rd";
        default: return @"th";
    }
}

@end
