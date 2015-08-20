//
//  GamesController.h
//  PartyPoints
//
//  Created by Kyle Grieder on 7/28/15.
//  Copyright (c) 2015 Kyle Grieder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Game.h"

@interface GamesController : NSObject

@property (strong, nonatomic, readonly) NSArray *games;

+ (GamesController *)sharedInstance;
+ (Game *)createGameWithName:(NSString *)name withPoints:(NSNumber *)points andParty:(Party *)party;
- (NSArray *)games:(NSArray *)games WithParty:(Party *)party;
- (void)deleteGame:(Game *)game;


@end
