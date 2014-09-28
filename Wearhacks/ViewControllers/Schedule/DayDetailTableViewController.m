//
//  DayDetailTableViewController.m
//  Wearhacks
//
//  Created by Adrien CARANTA on 27/09/2014.
//  Copyright (c) 2014 Samsao. All rights reserved.
//

#import "DayDetailTableViewController.h"
#import "ExerciseDetailViewController.h"

@interface DayDetailTableViewController ()

@property (nonatomic, strong) NSArray *exercises;

@end

@implementation DayDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = [NSString stringWithFormat:@"%@", [self.parseObject objectForKey:@"date"]];
    
    _exercises = [[NSArray alloc] init];
    
    [self loadExercises];
}

- (void)loadExercises {
    
    PFQuery * exercisesQuery = [WearHacksUtility allExercicesForExerciceDate:self.parseObject];
    [exercisesQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if (!error) {
            
            NSLog(@"Exercises Count : %lu", (unsigned long)objects.count);
            
            self.exercises = objects;
            
        }
        
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.exercises.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"exerciseCell" forIndexPath:indexPath];
    
    NSString *exerciseType = [[self.exercises objectAtIndex:indexPath.row] objectForKey:@"name"];
    
    UILabel *exerciseTypeLabel = (UILabel *)[cell viewWithTag:100];
    exerciseTypeLabel.text = exerciseType;
    
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:EXERCISE_SEGUE]) {
        
        ExerciseDetailViewController *exerciseDetailViewController = [segue destinationViewController];
        exerciseDetailViewController.title = [[self.exercises objectAtIndex:self.tableView.indexPathForSelectedRow.row] objectForKey:@"name"];
        exerciseDetailViewController.exercise = [self.exercises objectAtIndex:self.tableView.indexPathForSelectedRow.row];
        
    }
    
}

@end
