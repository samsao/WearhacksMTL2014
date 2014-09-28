//
//  DayDetailTableViewController.m
//  Wearhacks
//
//  Created by Adrien CARANTA on 27/09/2014.
//  Copyright (c) 2014 Samsao. All rights reserved.
//

#import "DayDetailTableViewController.h"
#import "ExerciseDetailViewController.h"
#import "UIColor+WearHackColors.h"
#import <UIColor+HTMLColors.h>

@interface DayDetailTableViewController ()

@property (nonatomic, strong) NSArray *exercises;

@end

@implementation DayDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Assignements";
    
    _exercises = [[NSArray alloc] init];
    
    [self loadExercises];
}

- (void)loadExercises {
    
    PFQuery * exercisesQuery = [WearHacksUtility allExercicesForExerciceDate:self.parseObject];
    [exercisesQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (!error) {
            
            self.exercises = objects;
            
            NSLog(@"Exercises Count : %lu", (unsigned long)objects.count);

            [self.tableView reloadData];
            
        }
        
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        return 1;
    } else {
        return self.exercises.count;
    }
    
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    
//    UIView *customHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
////    [customHeader setBackgroundColor:[UIColor blueColor]];
//    
//    return customHeader;
//    
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return 150;
    } else {
        return 100;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    
    if (indexPath.section == 0) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"dateCell" forIndexPath:indexPath];
        
        NSDate *exerciseDate = [self.parseObject objectForKey:@"date"];
        
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

        
        UILabel *dateLabel = (UILabel *)[cell viewWithTag:200];
        dateLabel.text = formattedDateString;
        
        [dateLabel setTextAlignment:NSTextAlignmentRight];
        [dateLabel setFont:[UIFont fontWithName:@"AvenirNextCondensed-Medium" size:32.0]];
        [dateLabel setTextColor:[UIColor colorWithHexString:@"#3e3e3e"]];

        
        UIView * background = (UIView *)[cell viewWithTag:69];
        
        [background setBackgroundColor:[UIColor color1]];
        
    } else {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"exerciseCell" forIndexPath:indexPath];
        
        NSString *exerciseType = [[self.exercises objectAtIndex:indexPath.row] objectForKey:@"name"];
//        NSString *exerciseType = @"KIKOOOOO";

        UILabel *exerciseTypeLabel = (UILabel *)[cell viewWithTag:100];
        exerciseTypeLabel.text = [exerciseType capitalizedString];
        [exerciseTypeLabel setFont:[UIFont fontWithName:@"AvenirNextCondensed-Medium" size:32.0]];
        [exerciseTypeLabel setTextColor:[UIColor colorWithHexString:@"#3e3e3e"]];
        [exerciseTypeLabel setTextAlignment:NSTextAlignmentLeft];
        
        UIView * background = (UIView *)[cell viewWithTag:69];
        
        [background setBackgroundColor:[self colorForIndexPath:indexPath]];
        
    }
    
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:EXERCISE_SEGUE]) {
        
        self.title = @"";
        ExerciseDetailViewController *exerciseDetailViewController = [segue destinationViewController];
        exerciseDetailViewController.title = [[[self.exercises objectAtIndex:self.tableView.indexPathForSelectedRow.row] objectForKey:@"name"] capitalizedString];
        exerciseDetailViewController.exercise = [self.exercises objectAtIndex:self.tableView.indexPathForSelectedRow.row];
        
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

- (UIColor *)colorForIndexPath:(NSIndexPath *)indexPath {
    
    UIColor * color;
    
    switch (indexPath.row) {
        case 0:
            color = [UIColor color2];
            break;
        case 1:
            color = [UIColor color3];
            break;
        case 2:
            color = [UIColor color4];
            break;
        case 3:
            color = [UIColor color5];
            break;
        case 4:
            color = [UIColor color4];
            break;
        case 5:
            color = [UIColor color3];
            break;
        case 6:
            color = [UIColor color2];
            break;
        case 7:
            color = [UIColor color1];
            break;
        case 8:
            color = [UIColor color1];
            break;
        case 9:
            color = [UIColor color2];
            break;
        case 10:
            color = [UIColor color3];
            break;
        case 11:
            color = [UIColor color4];
            break;
        case 12:
            color = [UIColor color5];
            break;
        default:
            color = [UIColor color1];
            break;
    }
    return color;
}

@end
