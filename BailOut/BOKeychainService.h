//
//  BOKeychainService.h
//  BailOut
//
//  Created by Andrew Barba on 8/15/13.
//  Copyright (c) 2013 Andrew Barba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BOKeychainService : NSObject

/**
 * Stores a value in the keychain
 */
- (void)setValue:(id)value forKey:(NSString *)key;

/**
 * Retrieves a value from the keychain
 */
- (id)valueForKey:(NSString *)key;

/**
 * Shared instance
 */
+ (instancetype)sharedInstance;

@end
