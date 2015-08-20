//
//  GuestController.h
//  PartyPoints
//
//  Created by Kyle Grieder on 7/28/15.
//  Copyright (c) 2015 Kyle Grieder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Guest.h"
#import "Party.h"

@interface GuestController : NSObject

@property (strong, nonatomic, readonly) NSArray *guests;

+ (GuestController *)sharedInstance;
+ (Guest *)createGuestWithName:(NSString *)name andParty:(Party *)party;
- (NSArray *)guests:(NSArray *)guests WithParty:(Party *)party;
- (void)deleteGuest:(Guest *)guest;



@end
