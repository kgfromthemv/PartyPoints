//
//  GuestController.h
//  PartyPoints
//
//  Created by Kyle Grieder on 7/28/15.
//  Copyright (c) 2015 Kyle Grieder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Guest.h"

@interface GuestController : NSObject

+ (GuestController *)sharedInstance;
+ (Guest *)createGuestWithName:(NSString *)name andParty:(Party *)party;
+ (Guest *)guestWithGuest:(Guest *)guest;



@end
