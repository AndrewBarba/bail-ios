//
//  BOAPIRootService.h
//  BailOut
//
//  Created by Andrew Barba on 8/15/13.
//  Copyright (c) 2013 Andrew Barba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BOAPI.h"

@interface BOAPIRootService : NSObject

/**
 * Fetches the root of the BailOut API
 * Will include a description and info about the API
 */
- (void)fetchRoot:(BOAPIDictionaryBlock)complete;

/**
 * Fetches the status of the BailOut API
 * Indicates whether the API is up and running
 * StatusCode 200 indicates YES, anything else indicates NO
 */
- (void)fetchStatus:(BOAPIBooleanBlock)complete;

/**
 * Shared instance
 */
+ (instancetype)sharedInstance;

@end
