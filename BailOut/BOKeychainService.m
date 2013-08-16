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

#pragma mark - Setter

- (void)setPhoneNumber:(NSString *)phoneNumber
          forAuthToken:(NSString *)authToken
{
    [_keychainItem setObject:phoneNumber forKey:(__bridge id)kSecAttrAccount];
    [_keychainItem setObject:authToken forKey:(__bridge id)kSecValueData];
}

#pragma mark - Getter

- (NSString *)phoneNumber
{
    NSString *phone = [_keychainItem objectForKey:(__bridge id)kSecAttrAccount];
    return (phone && phone.length) ? phone : nil;
}

- (NSString *)authToken
{
    NSString *auth = [_keychainItem objectForKey:(__bridge id)kSecValueData];
    return (auth && auth.length) ? auth : nil;
}

- (BOOL)hasAuth
{
    return [self phoneNumber] && [self authToken];
}

#pragma mark - Reset

- (void)resetKeychain
{
    [_keychainItem resetKeychainItem];
}

#pragma mark - Initialization

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
