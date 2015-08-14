//
//  PPPartyDateViewController.m
//  PartyPoints
//
//  Created by Kyle Grieder on 7/21/15.
//  Copyright (c) 2015 Kyle Grieder. All rights reserved.
//

#import "PPPartyDateViewController.h"
#import "PPPartyGuestsTableViewController.h"

static NSString *cellIdentifier = @"dateViewCell";
static NSString *datePickerCellIdentifier = @"dateViewDatePickerCell";

@interface PPPartyDateViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker1;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker2;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSDate *startDate;
@property (strong, nonatomic) NSDate *endDate;

@end

@implementation PPPartyDateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    
}

-(void)viewWillAppear:(BOOL)animated {
    
    self.datePicker2.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - tableView Delegate and Data Source

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    NSString *date1 = [NSDateFormatter localizedStringFromDate:self.datePicker1.date
                                                    dateStyle:NSDateFormatterShortStyle
                                                    timeStyle:NSDateFormatterShortStyle];
    
    NSString *date2 = [NSDateFormatter localizedStringFromDate:self.datePicker2.date
                                                     dateStyle:NSDateFormatterShortStyle
                                                     timeStyle:NSDateFormatterShortStyle];
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"Start Date";
        cell.detailTextLabel.text = date1;
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"End Date";
        cell.detailTextLabel.text = date2;
    }

    
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return 2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        self.datePicker2.hidden = YES;
        self.datePicker1.hidden = NO;

    } else {
        self.datePicker1.hidden = YES;
        self.datePicker2.hidden = NO;

    }
    
    
}

- (IBAction)updatedDatePicker:(id)sender {
    
    [self.tableView reloadData];
    
}
- (IBAction)updatedDatePicker2:(id)sender {
    
    [self.tableView reloadData];    
    
}

#pragma mark - Navigation

- (Party *)updateParty {
    
    self.party.startTime = self.startDate;
    self.party.endTime = self.endDate;
    
    return self.party;
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    self.startDate = self.datePicker1.date;
    self.endDate = self.datePicker2.date;
    
    NSError *error;
    if (!error) {
    PPPartyGuestsTableViewController *viewController = segue.destinationViewController;
    
    viewController.party = [self updateParty];
    } else {
        NSLog(@"An error has occurred:%@", error);
    }
}


@end
