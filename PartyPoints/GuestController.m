//
//  GuestController.m
//  PartyPoints
//
//  Created by Kyle Grieder on 7/28/15.
//  Copyright (c) 2015 Kyle Grieder. All rights reserved.
//

#import "GuestController.h"
#import "Stack.h"

@implementation GuestController

+ (GuestController *)sharedInstance {
    static GuestController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [GuestController new];
    });
    return sharedInstance;
}

+ (Guest *)createGuestWithName:(NSString *)name andParty:(Party *)party {
    
    Guest *guest = [NSEntityDescription insertNewObjectForEntityForName:@"Guest" inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
    
    guest.name = name;
    [guest addPartiesObject:party];
    
    return guest;
}


@end
