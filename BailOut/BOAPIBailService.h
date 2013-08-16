//
//  BOAPIBailService.h
//  BailOut
//
//  Created by Andrew Barba on 8/16/13.
//  Copyright (c) 2013 Andrew Barba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BOAPI.h"

@interface BOAPIBailService : NSObject

/**
 * Initiates a call to the user
 */
- (void)bailMeOut:(NSTimeInterval)timeout onCompletion:(BOAPIBooleanBlock)complete;

/**
 * Shared instance
 */
+ (instancetype)sharedInstance;

@end
