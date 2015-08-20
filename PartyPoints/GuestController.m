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
    
    [[Stack sharedInstance] saveManagedObjectContext];
    
    return guest;
}

- (NSArray *)guests {
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Guest"];
    
    NSArray *fetchedGuests = [[Stack sharedInstance].managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    return fetchedGuests;
    
}

- (NSArray *)guests:(NSArray *)guests WithParty:(Party *)party {
    
    NSMutableArray *guestsList = [NSMutableArray new];
    
    for (Guest *guest in guests) {
        
        for (Party *guestParty in guest.parties) {
            
            if (guestParty == party) {
                
                [guestsList addObject:guest];
                
            }
            
        }
        
    }
    return guestsList;
    
}

- (void)deleteGuest:(Guest *)guest {
    
    [guest.managedObjectContext deleteObject:guest];
    [[Stack sharedInstance] saveManagedObjectContext];
    
}



@end
