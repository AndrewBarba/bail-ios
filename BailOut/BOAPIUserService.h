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
 * Initiates a text message to the given number so user can verify phone number
 */
- (void)registerPhoneNumber:(NSString *)phoneNumber onCompletion:(BOAPIBooleanBlock)complete;

/**
 * Verifies a phone number with the given code
 * Automatically stores auth token
 */
- (void)verifyPhoneNumber:(NSString *)phoneNumber withCode:(NSString *)code onCompletion:(BOAPIBooleanBlock)complete;

/**
 * Signs out a user and resets the keychain
 */
- (void)signOut:(BOAPIBooleanBlock)complete;

/**
 * Shared instance
 */
+ (instancetype)sharedInstance;

@end
