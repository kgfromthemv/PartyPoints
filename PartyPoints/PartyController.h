//
//  PartyController.h
//  PartyPoints
//
//  Created by Kyle Grieder on 7/28/15.
//  Copyright (c) 2015 Kyle Grieder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Party.h"

@interface PartyController : NSObject

+ (PartyController *)sharedInstance;
+ (Party *)createPartyWithName:(NSString *)name;

@end
