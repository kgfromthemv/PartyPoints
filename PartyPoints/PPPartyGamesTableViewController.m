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
@property NSArray *pointsList;
@property Game *game;
@property (weak, nonatomic) IBOutlet UITextField *gameName;
@property (weak, nonatomic) IBOutlet UITextField *gamePoints;
@property (weak, nonatomic) IBOutlet UIStepper *pointsStepper;

@property (nonatomic, assign) id currentResponder;


@end

@implementation PPPartyGamesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.gamePoints.delegate = self;
    self.gameName.delegate = self;
    
    self.pointsStepper.value = [self.gamePoints.text integerValue];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(resignOnTap:)];
    [singleTap setNumberOfTapsRequired:1];
    [singleTap setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:singleTap];
    
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
- (IBAction)addGame:(id)sender {
    
    if (self.gameName.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert!" message:@"The name of the game is..." delegate:nil cancelButtonTitle:@"Name my Game" otherButtonTitles:nil];
        
        [alert show];
    } else {
        
        NSString *gameName = self.gameName.text;
        NSString *gamePointsAsString = self.gamePoints.text;
        NSInteger gamePoints = [self.gamePoints.text integerValue];
        
        [GamesController createGameWithName:gameName withPoints:[NSNumber numberWithInteger:gamePoints] andParty:self.party];
        
        NSMutableArray *games = [NSMutableArray arrayWithArray:self.gamesList];
        
        NSMutableArray *points = [NSMutableArray arrayWithArray:self.pointsList];
        
        [games addObject:gameName];
        [points addObject:gamePointsAsString];
        
        self.gamesList = games;
        self.pointsList = points;
        
        [self.tableView reloadData];
        
        self.gameName.text = nil;
        self.gamePoints.text = @"0";
        
        self.pointsStepper.value = [self.gamePoints.text integerValue];
    }
}

#pragma mark - UITextField delegate, and stepper method

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    self.currentResponder = textField;
    
    self.pointsStepper.enabled = NO;
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    self.pointsStepper.value = [self.gamePoints.text integerValue];
    
    self.pointsStepper.enabled = YES;
    
}

- (IBAction)changePoints:(UIStepper *)sender {
    
    //    NSInteger points = [self.gamePoints.text integerValue];
    
    NSInteger stepperValue = self.pointsStepper.value;
    
    
    self.gamePoints.text = [@(stepperValue) stringValue];
    
}

- (void)resignOnTap:(id)sender {
    
    [self.currentResponder resignFirstResponder];
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
    
    cell.textLabel.text = self.gamesList[indexPath.row];
    cell.detailTextLabel.text = self.pointsList[indexPath.row];
    
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
}


@end
