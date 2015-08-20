//
//  PPPartyGamesTableViewController.m
//  PartyPoints
//
//  Created by Kyle Grieder on 8/6/15.
//  Copyright (c) 2015 Kyle Grieder. All rights reserved.
//

#import "PPPartyGamesTableViewController.h"
#import "PPPartyListTableViewController.h"
#import "PPPartyTableViewController.h"
#import "Stack.h"

static NSString *gamesTableViewCell = @"gamesTableViewCell";


@interface PPPartyGamesTableViewController ()
@property NSArray *gamesList;
@property Game *game;
@property (weak, nonatomic) IBOutlet UITextField *gameName;
@property (weak, nonatomic) IBOutlet UITextField *gamePoints;
@property (weak, nonatomic) IBOutlet UIStepper *pointsStepper;


@end

@implementation PPPartyGamesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.gamePoints.delegate = self;
    self.gameName.delegate = self;
    
    [self updateGameList];
    
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
    
    self.pointsStepper.value = [self.gamePoints.text integerValue];
    
}

- (IBAction)createParty:(id)sender {
    
    [[Stack sharedInstance] saveManagedObjectContext];
    
    UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    PPPartyListTableViewController *partyListTable = [board instantiateViewControllerWithIdentifier:NSStringFromClass([PPPartyListTableViewController class])];
    
    
    PPPartyTableViewController *partyTable = [board instantiateViewControllerWithIdentifier:NSStringFromClass([PPPartyTableViewController class])];
    
    partyTable.party = self.party;
    
    
    NSArray *newViewControllerStack = @[partyListTable, partyTable];
    [self.navigationController setViewControllers:newViewControllerStack animated:YES];
}

#pragma mark - creating game objects

- (IBAction)addGame:(id)sender {
    
    if (self.gameName.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert!" message:@"The name of the game is..." delegate:nil cancelButtonTitle:@"Name my Game" otherButtonTitles:nil];
        
        [alert show];
    } else {
        
        NSString *gameName = self.gameName.text;
        NSInteger gamePoints = [self.gamePoints.text integerValue];
        
        [GamesController createGameWithName:gameName withPoints:[NSNumber numberWithInteger:gamePoints] andParty:self.party];
        
        [self updateGameList];
        
        
        [self updateGameList];
        [self.tableView reloadData];
        
        self.gameName.text = nil;
        self.gamePoints.text = @"0";
        
        self.pointsStepper.value = [self.gamePoints.text integerValue];
        
        [self.view endEditing:YES];
    }
}

- (void) updateGameList {
    
    NSArray *games = [GamesController sharedInstance].games;
    
    NSArray *gamesWithParty = [[GamesController sharedInstance] games:games WithParty:self.party];
    
    self.gamesList = gamesWithParty;
    
}

#pragma mark - UITextField delegate, and stepper method

- (IBAction)textFieldChanged:(UITextField *)textField {
    
    self.pointsStepper.value = [self.gamePoints.text integerValue];
    
    [self updateInputs];
    
}

- (IBAction)changePoints:(UIStepper *)sender {

    
    [self updateInputs];
    
}

- (void)updateInputs {
    
    NSInteger stepperValue = self.pointsStepper.value;
    
    self.gamePoints.text = [@(stepperValue) stringValue];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self.gameName resignFirstResponder];
    [self.gamePoints resignFirstResponder];
    return YES;
}

#pragma mark - Table view data source and delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    return self.gamesList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:gamesTableViewCell forIndexPath:indexPath];
    
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
        
        Game *game = self.gamesList[indexPath.row];
        
        [[GamesController sharedInstance] deleteGame:game];
        
        [self updateGameList];
        
        
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
    
    PPPartyTableViewController *viewController = segue.destinationViewController;
    
    viewController.party = self.party;
    
}


@end
