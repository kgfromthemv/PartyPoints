//
//  PartyController.m
//  PartyPoints
//
//  Created by Kyle Grieder on 7/28/15.
//  Copyright (c) 2015 Kyle Grieder. All rights reserved.
//

#import "PartyController.h"
#import "Stack.h"

@implementation PartyController

+ (PartyController *)sharedInstance {
    static PartyController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    
        sharedInstance = [PartyController new];
    });
    return sharedInstance;
}

+ (Party *)createPartyWithName:(NSString *)name {
    

    Party *party = [NSEntityDescription insertNewObjectForEntityForName:@"Party" inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
    
    party.name = name;
    
    return party;
    
}

//- (void)updateParty:(Party *)party withName:(NSString *)name withIcon:(id)icon

@end
