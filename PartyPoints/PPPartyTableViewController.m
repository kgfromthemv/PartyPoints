//
//  PPPartyTableViewController.m
//  PartyPoints
//
//  Created by Kyle Grieder on 7/21/15.
//  Copyright (c) 2015 Kyle Grieder. All rights reserved.
//

#import "PPPartyTableViewController.h"
#import "PPGuestTableViewController.h"
#import "GuestController.h"
#import "GamesController.h"

static NSString *partyViewCell = @"partyViewCell";

@interface PPPartyTableViewController ()

@property (strong, nonatomic) NSArray *guestList;
@property (strong, nonatomic) NSArray *gamesList;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *randomWinnerButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@end

@implementation PPPartyTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.party.name;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self updateGuestList];
    [self updateGamesList];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    
    [self.tableView reloadData];
    
}
- (IBAction)segmentedControl:(id)sender {
    
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        self.randomWinnerButton.enabled = YES;
        self.randomWinnerButton.title = @"Pick Winner";
    } else if (self.segmentedControl.selectedSegmentIndex == 1) {
        self.randomWinnerButton.enabled = NO;
        self.randomWinnerButton.title = @"";
    } else {
        
    }
    
    
    [self.tableView reloadData];
    
}

- (void)updateGuestList {
    
    NSArray *guests = [GuestController sharedInstance].guests;
    
    NSArray *guestsWithParty = [[GuestController sharedInstance] guests:guests WithParty:self.party];
    
    self.guestList = guestsWithParty;
    
}

- (void)updateGamesList {
    
    NSArray *games = [GamesController sharedInstance].games;
    
    NSArray *gamesWithParty = [[GamesController sharedInstance] games:games WithParty:self.party];
    
    self.gamesList = gamesWithParty;
    
}

#pragma mark - Table view data source and delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.

    if (self.segmentedControl.selectedSegmentIndex == 0) {
        return self.guestList.count;
    } else if (self.segmentedControl.selectedSegmentIndex == 1) {
        return self.gamesList.count;
    } else {
        return 0;
    }
    
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.segmentedControl.selectedSegmentIndex == 1) {
        return nil;
    } else {
        return indexPath;
    }
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.segmentedControl.selectedSegmentIndex == 1) {
        return NO;
    } else {
        return YES;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:partyViewCell forIndexPath:indexPath];
    
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        Guest *guest = self.guestList[indexPath.row];
        
        cell.textLabel.text = guest.name;
        cell.detailTextLabel.text = [guest.points stringValue];
        
    } else if (self.segmentedControl.selectedSegmentIndex == 1) {
        Game *game = self.gamesList[indexPath.row];
        
        cell.textLabel.text = game.name;
        cell.detailTextLabel.text = [game.points stringValue];
    }
    
    
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        Guest *guest = self.guestList[indexPath.row];
        
        [[GuestController sharedInstance] deleteGuest:guest];
        
        [self updateGuestList];
        
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}



// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    if ([segue.identifier isEqualToString:@"guestViewSegue"]) {
        
        UINavigationController *navigationController = segue.destinationViewController;
        
        PPGuestTableViewController *viewController = navigationController.viewControllers[0];
        
        viewController.guest = self.guestList[indexPath.row];
        viewController.party = self.party;
        
    }
}


@end
