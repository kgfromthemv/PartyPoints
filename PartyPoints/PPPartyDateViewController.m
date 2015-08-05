//
//  PPPartyDateViewController.m
//  PartyPoints
//
//  Created by Kyle Grieder on 7/21/15.
//  Copyright (c) 2015 Kyle Grieder. All rights reserved.
//

#import "PPPartyDateViewController.h"
#import "PPPartyGuestsViewController.h"

static NSString *cellIdentifier = @"dateViewCell";
static NSString *datePickerCellIdentifier = @"dateViewDatePickerCell";

@interface PPPartyDateViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (Party *)updateParty {
    
    self.party.startTime = self.startDate;
    self.party.endTime = self.endDate;
    
    return self.party;
}


#pragma mark - tableView Delegate and Data Source

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    NSString *date = [NSDateFormatter localizedStringFromDate:self.datePicker.date
                                                    dateStyle:NSDateFormatterShortStyle
                                                    timeStyle:NSDateFormatterShortStyle];
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"Start Date";
        cell.detailTextLabel.text = date;
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"End Date";
        cell.detailTextLabel.text = date;
    }

    
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return 2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (IBAction)updatedDatePicker:(id)sender {
    
    [self.tableView reloadData];
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    NSError *error;
    if (!error) {
    PPPartyGuestsViewController *viewController = segue.destinationViewController;
    
    viewController.party = [self updateParty];
    } else {
        NSLog(@"An error has occurred:%@", error);
    }
}


@end
