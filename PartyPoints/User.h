//
//  User.h
//  PartyPoints
//
//  Created by Kyle Grieder on 7/22/15.
//  Copyright (c) 2015 Kyle Grieder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSString * emailAddress;
@property (nonatomic, retain) NSString * facebookUserID;
@property (nonatomic, retain) NSString * name;

@end
