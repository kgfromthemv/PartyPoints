//
//  PPPartyListTableViewController.m
//  PartyPoints
//
//  Created by Kyle Grieder on 8/4/15.
//  Copyright (c) 2015 Kyle Grieder. All rights reserved.
//

#import "PPPartyListTableViewController.h"
#import "PPPartyTableViewController.h"
#import "Stack.h"

static NSString *partyListCell = @"partyListCell";

@interface PPPartyListTableViewController ()

@property (strong, nonatomic) NSArray *parties;

@end

@implementation PPPartyListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self updatePartyList];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)addParty:(id)sender {
    
    [[Stack sharedInstance] resetManagedObjectContext];
    
}

- (void)updatePartyList {
    
    self.parties = [[PartyController sharedInstance] parties];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return self.parties.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:partyListCell forIndexPath:indexPath];
    
    // Configure the cell...
    
    Party *party = self.parties[indexPath.row];
    
    cell.textLabel.text = party.name;
    
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
        
        Party *party = self.parties[indexPath.row];
        
        [[PartyController sharedInstance] deleteParty:party];
        
        [self updatePartyList];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    
    if ([[segue identifier] isEqualToString:@"viewPartyfromList"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        PPPartyTableViewController *viewController = segue.destinationViewController;
        
        viewController.party = self.parties[indexPath.row];
        
        
    }
}

@end
