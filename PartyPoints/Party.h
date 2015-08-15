//
//  Party.h
//  PartyPoints
//
//  Created by Kyle Grieder on 7/22/15.
//  Copyright (c) 2015 Kyle Grieder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Game, Guest, Icon;

@interface Party : NSManagedObject

@property (nonatomic, retain) NSDate * endTime;
@property (nonatomic, retain) NSData * icon;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * startTime;
@property (nonatomic, retain) NSSet *games;
@property (nonatomic, retain) NSSet *guests;
@end

@interface Party (CoreDataGeneratedAccessors)

- (void)addGamesObject:(Game *)value;
- (void)removeGamesObject:(Game *)value;
- (void)addGames:(NSSet *)values;
- (void)removeGames:(NSSet *)values;

- (void)addGuestsObject:(Guest *)value;
- (void)removeGuestsObject:(Guest *)value;
- (void)addGuests:(NSSet *)values;
- (void)removeGuests:(NSSet *)values;

@end
