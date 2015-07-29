//
//  Icon.h
//  PartyPoints
//
//  Created by Kyle Grieder on 7/22/15.
//  Copyright (c) 2015 Kyle Grieder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Party;

@interface Icon : NSManagedObject

@property (nonatomic, retain) NSData* image;
@property (nonatomic, retain) NSSet *parties;
@end

@interface Icon (CoreDataGeneratedAccessors)

- (void)addPartiesObject:(Party *)value;
- (void)removePartiesObject:(Party *)value;
- (void)addParties:(NSSet *)values;
- (void)removeParties:(NSSet *)values;

@end
