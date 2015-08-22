//
//  PPGuestTableViewController.m
//  PartyPoints
//
//  Created by Kyle Grieder on 7/21/15.
//  Copyright (c) 2015 Kyle Grieder. All rights reserved.
//

#import "PPGuestTableViewController.h"
#import "GamesController.h"

static NSString *guestViewCell = @"guestViewCell";

@interface PPGuestTableViewController ()
@property (weak, nonatomic) IBOutlet UINavigationItem *viewTitle;

@property (strong, nonatomic) NSArray *gamesList;

@property (strong, nonatomic) NSArray *guestPoints;

@end

@implementation PPGuestTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setToolbarHidden:NO];
    
    self.title = self.guest.name;
    
    self.tableView.allowsMultipleSelection = YES;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    
    //    This is where I will feed self.guest.points to the self.guestPoints array
    
    [self.tableView reloadData];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [self.navigationController setToolbarHidden:YES];
    
}


- (IBAction)saveGuest:(id)sender {
    
    // This is where I need to add the points to self.guest.points.
    
    [[GuestController sharedInstance] saveGuest:self.guest];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (NSArray *)gamesList {
    
    NSArray *games = [GamesController sharedInstance].games;
    
    NSArray *gamesWithParty = [[GamesController sharedInstance] games:games WithParty:self.party];
    
    return gamesWithParty;
    
}

#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    
    if ([self.tableView cellForRowAtIndexPath:indexPath].selected == YES) {
        [self.tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        [self.tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
    }
    
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    return self.gamesList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:guestViewCell forIndexPath:indexPath];
    
    Game *game = self.gamesList[indexPath.row];
    
    cell.textLabel.text = game.name;
    cell.detailTextLabel.text = [game.points stringValue];
    
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


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
