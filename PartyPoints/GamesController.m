//
//  GamesController.m
//  PartyPoints
//
//  Created by Kyle Grieder on 7/28/15.
//  Copyright (c) 2015 Kyle Grieder. All rights reserved.
//

#import "GamesController.h"
#import "Stack.h"

@implementation GamesController

+ (GamesController *)sharedInstance {
    static GamesController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [GamesController new];
    });
    return sharedInstance;
}

+ (Game *)createGameWithName:(NSString *)name withPoints:(NSNumber *)points andParty:(Party *)party {
    
    Game *game = [NSEntityDescription insertNewObjectForEntityForName:@"Game" inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
    
    game.name = name;
    game.points = points;
    [game addPartiesObject:party];
    [[Stack sharedInstance] saveManagedObjectContext];
    
    return game;
}

- (NSArray *)games {
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Game"];
    
    NSArray *fetchedGames = [[Stack sharedInstance].managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    return fetchedGames;
    
}

- (NSArray *)games:(NSArray *)games WithParty:(Party *)party {
    
    NSMutableArray *gamesList = [NSMutableArray new];
    
    for (Game *game in games) {
        
        for (Party *gameParty in game.parties) {
            
            if (gameParty == party) {
            
                [gamesList addObject:game]; 
                
            }
            
        }
        
    }
    return gamesList;
}


@end
