//
//  BOKeychainService.m
//  BailOut
//
//  Created by Andrew Barba on 8/15/13.
//  Copyright (c) 2013 Andrew Barba. All rights reserved.
//

#import "BOKeychainService.h"
#import "NSKeychainItemWrapper.h"

#define BO_KEYCHAIN_IDENTIFIER @"BailOutKeychain"

@interface BOKeychainService() {
    NSKeychainItemWrapper *_keychainItem;
}

@end

@implementation BOKeychainService

- (void)setValue:(id)value forKey:(NSString *)key
{
    [_keychainItem setObject:value forKey:key];
}

- (id)valueForKey:(NSString *)key
{
    return [_keychainItem objectForKey:key];
}

/**
 * Private initializer
 */
- (instancetype)_initPrivateInstance
{
    self = [super init];
    if (self) {
        _keychainItem = [[NSKeychainItemWrapper alloc] initWithIdentifier:BO_KEYCHAIN_IDENTIFIER accessGroup:nil];
    }
    return self;
}

/**
 * Disable init, force static initializer
 */
- (id)init
{
    [super doesNotRecognizeSelector:_cmd];
    return nil;
}

/*********** SHARED INSTANCE ************/
/****************************************/

+ (instancetype)sharedInstance
{
    static BOKeychainService *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] _initPrivateInstance];
    });
    return sharedInstance;
}

@end
