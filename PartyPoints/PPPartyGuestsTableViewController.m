//
//  PPPartyGuestsTableViewController.m
//  PartyPoints
//
//  Created by Kyle Grieder on 8/6/15.
//  Copyright (c) 2015 Kyle Grieder. All rights reserved.
//

#import "PPPartyGuestsTableViewController.h"
#import "PPPartyGamesTableViewController.h"

static NSString *tableViewCell = @"guestTableViewCell";
static NSString *guestName = @"guestName";

@interface PPPartyGuestsTableViewController ()

@property NSArray *guestList;
@property Guest *guest;
@property (weak, nonatomic) IBOutlet UITextField *guestName;

@end

@implementation PPPartyGuestsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)addGuest:(id)sender {
    
    if (self.guestName.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert!" message:@"I'm sure your guests all have names right? Name your guest!" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        
        [alert show];
        
    } else {
        
        NSString *name = self.guestName.text;
        
        //Creating guest and saving it to CoreData.
        [GuestController createGuestWithName:name andParty:self.party];
        
        //Create array, and add name string to array.
        NSMutableArray *list = [NSMutableArray arrayWithArray:self.guestList];
        
        [list addObject:name];
        
        self.guestList = list;
        
        [self.tableView reloadData];
        self.guestName.text = nil;
    }
    
}


#pragma mark - Table view data source and delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self.guestName resignFirstResponder];
    return YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    return self.guestList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCell];
    
    cell.textLabel.text = self.guestList[indexPath.row];
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
    
    PPPartyGamesTableViewController *viewController = segue.destinationViewController;
    
    viewController.party = self.party;
    
}


@end
