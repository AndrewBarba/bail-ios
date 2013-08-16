//
//  BOKeychainService.h
//  BailOut
//
//  Created by Andrew Barba on 8/15/13.
//  Copyright (c) 2013 Andrew Barba. All rights reserved.
//

#import <Foundation/Foundation.h>

#define BO_AUTH_KEY @"bo_auth"

@interface BOKeychainService : NSObject

/**
 * Stores phone number and password
 * Passing nil simply ignores setter. Use reset keychain to clear data
 */
- (void)setPhoneNumber:(NSString *)phoneNumber
          forAuthToken:(NSString *)authToken;

/**
 * Retrieves phone number from keychain
 */
- (NSString *)phoneNumber;

/**
 * Retrieves auth token from keychain
 */
- (NSString *)authToken;

/**
 * Boolean indicating whether a current user has an auth token
 */
- (BOOL)hasAuth;

/**
 * Clear/Resets all data in the keychain
 */
- (void)resetKeychain;

/**
 * Shared instance
 */
+ (instancetype)sharedInstance;

@end
