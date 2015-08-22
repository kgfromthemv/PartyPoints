//
//  PPGuestTableViewController.h
//  PartyPoints
//
//  Created by Kyle Grieder on 7/21/15.
//  Copyright (c) 2015 Kyle Grieder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GuestController.h"

@interface PPGuestTableViewController : UITableViewController

@property (nonatomic, strong) Guest *guest;
@property (nonatomic, strong) Party *party;

@end
