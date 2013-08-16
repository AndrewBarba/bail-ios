//
//  BOAPIUserService.m
//  BailOut
//
//  Created by Andrew Barba on 8/16/13.
//  Copyright (c) 2013 Andrew Barba. All rights reserved.
//

#import "BOAPIUserService.h"
#import "BOUser.h"
#import "BOKeychainService.h"

@implementation BOAPIUserService

#pragma mark - Current User

- (void)fetchCurrentUser:(BOAPIRequestBlock)complete
{
    [[BOAPI sharedClient] GET:BOAPI_ENDPOINT_USER
                     withData:nil
                 onCompletion:^(NSDictionary *data, ABHTTPStatusCode statusCode, NSError *error){
                     if (statusCode == ABHTTPSuccessfulOK) {
                         BOUser *user = [[BOUser alloc] initWithAPIDict:data];
                         if (complete) complete(user, nil);
                     } else {
                         if (complete) complete(nil, error);
                     }
                 }];
}

#pragma mark - Register Phone Number

- (void)registerPhoneNumber:(NSString *)phoneNumber onCompletion:(BOAPIBooleanBlock)complete
{
    NSDictionary *data = @{ @"phone_number" : phoneNumber };
    [[BOAPI sharedClient] POST:BOAPI_ENDPOINT_USER_REGISTRATION
                      withData:data
                  onCompletion:^(NSDictionary *data, ABHTTPStatusCode statusCode, NSError *error){
                      if (statusCode == ABHTTPSuccessfulOK) {
                          
                          // reset the keychain and hang on to phone number
                          [[BOKeychainService sharedInstance] resetKeychain];
                          [[BOKeychainService sharedInstance] setPhoneNumber:phoneNumber forAuthToken:nil];
                          
                          if (complete) complete(YES, nil);
                      } else {
                          if (complete) complete(NO, error);
                      }
                  }];
}

#pragma mark - Verify Phone Number

- (void)verifyPhoneNumber:(NSString *)phoneNumber withCode:(NSString *)code onCompletion:(BOAPIBooleanBlock)complete
{
    NSDictionary *data = @{ @"phone_number" : phoneNumber,
                            @"verification_code" : code };
    
    [[BOAPI sharedClient] POST:BOAPI_ENDPOINT_USER_VERIFY
                      withData:data
                  onCompletion:^(NSDictionary *data, ABHTTPStatusCode statusCode, NSError *error){
                      if (statusCode == ABHTTPSuccessfulOK) {
                          
                          // store auth token and phone number
                          NSString *authToken = data[@"auth_token"];
                          [[BOKeychainService sharedInstance] setPhoneNumber:phoneNumber forAuthToken:authToken];
                          
                          if (complete) complete(YES, nil);
                          
                          // Post notification
                          [[NSNotificationCenter defaultCenter] postNotificationName:BOSignInNotificationKey object:nil];
                      } else {
                          if (complete) complete(NO, error);
                      }
                  }];
}

#pragma mark - Sign Out

- (void)signOut:(BOAPIBooleanBlock)complete
{
    [[BOKeychainService sharedInstance] resetKeychain];
    if (complete) {
        complete(YES, nil);
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:BOSignOutNotificationKey object:nil];
}

#pragma mark - Initialization

/**
 * Private initializer
 */
- (instancetype)_initPrivateInstance
{
    self = [super init];
    if (self) {
        // setup
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
    static BOAPIUserService *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] _initPrivateInstance];
    });
    return sharedInstance;
}

@end
