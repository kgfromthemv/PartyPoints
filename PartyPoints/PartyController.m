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
    
    [[Stack sharedInstance] saveManagedObjectContext];
    
    return party;
    
}

- (NSArray *)parties {
    
    NSFetchRequest *fetch = [NSFetchRequest fetchRequestWithEntityName:@"Party"];
    
    NSArray *fetchedParties = [[Stack sharedInstance].managedObjectContext executeFetchRequest:fetch error:nil];
    
    return fetchedParties;
    
}

- (void)deleteParty:(Party *)party {
    
    [party.managedObjectContext deleteObject:party];
    [[Stack sharedInstance] saveManagedObjectContext];
    
}

//- (void)updateParty:(Party *)party withName:(NSString *)name withIcon:(id)icon

@end
