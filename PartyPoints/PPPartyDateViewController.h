//
//  PPPartyDateViewController.h
//  PartyPoints
//
//  Created by Kyle Grieder on 7/21/15.
//  Copyright (c) 2015 Kyle Grieder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PartyController.h"

@interface PPPartyDateViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) Party *party;

@end
