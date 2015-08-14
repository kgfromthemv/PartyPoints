//
//  Stack.h
//  PartyPoints
//
//  Created by Kyle Grieder on 7/21/15.
//  Copyright (c) 2015 Kyle Grieder. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreData;

@interface Stack : NSObject

+ (Stack *)sharedInstance;
- (void)resetManagedObjectContext;
- (void)saveManagedObjectContext;


@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;

@end
