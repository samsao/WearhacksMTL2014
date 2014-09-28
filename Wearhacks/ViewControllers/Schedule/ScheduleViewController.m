//
//  RehabViewController.m
//  Wearhacks
//
//  Created by Gabriel Cartier on 2014-09-27.
//  Copyright (c) 2014 Samsao. All rights reserved.
//

#import "ScheduleViewController.h"
#import "DayDetailViewController.h"

@interface ScheduleViewController ()

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *weekDays;

@end

@implementation ScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _weekDays = [[NSMutableArray alloc] initWithObjects:@"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday", @"Saturday", @"Sunday", nil];
    
}


#pragma mark - UITableView Delegate & Data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.weekDays.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"scheduleCell"];
    
    NSString *weekDay = [self.weekDays objectAtIndex:indexPath.row];
    
    UILabel *weekDayLabel = (UILabel *)[cell viewWithTag:100];
    weekDayLabel.text = weekDay;
    
    return cell;
}


#pragma mark - Navigation
 
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([[segue identifier] isEqualToString:@"weekDaySegue"]) {
        
        DayDetailViewController *detailViewController = [segue destinationViewController];
        detailViewController.title = [self.weekDays objectAtIndex:self.tableView.indexPathForSelectedRow.row];
        
    }
    
}


@end
