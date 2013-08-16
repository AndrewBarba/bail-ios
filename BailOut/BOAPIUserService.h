//
//  BOAPIUserService.h
//  BailOut
//
//  Created by Andrew Barba on 8/16/13.
//  Copyright (c) 2013 Andrew Barba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BOAPI.h"

@interface BOAPIUserService : NSObject

/**
 * Fetches the current user
 * returns 401 if auth token is not valid
 */
- (void)fetchCurrentUser:(BOAPIRequestBlock)complete;

/**
 * Shared instance
 */
+ (instancetype)sharedInstance;

@end
