//
//  PPPartyGamesTableViewController.h
//  PartyPoints
//
//  Created by Kyle Grieder on 8/6/15.
//  Copyright (c) 2015 Kyle Grieder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PartyController.h"
#import "GamesController.h"

@interface PPPartyGamesTableViewController : UITableViewController <UITextFieldDelegate>

@property (strong, nonatomic) Party *party;

@end
