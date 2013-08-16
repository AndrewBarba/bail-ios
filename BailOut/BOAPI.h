//
//  BOAPI.h
//  BailOut
//
//  Created by Andrew Barba on 8/15/13.
//  Copyright (c) 2013 Andrew Barba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ABHTTPClient.h"

#define BOAPI_ENDPOINT_ROOT               @"/"
#define BOAPI_ENDPOINT_STATUS             @"/status"

#define BOAPI_ENDPOINT_USER               @"/user"
#define BOAPI_ENDPOINT_USER_REGISTRATION  @"/user/register"
#define BOAPI_ENDPOINT_USER_VERIFY        @"/user/verify"

#define BOAPI_ENDPOINT_BAIL               @"/bail"

// Common completion blocks
typedef void (^BOAPIRequestBlock)    (id object, NSError *error);
typedef void (^BOAPIBooleanBlock)    (BOOL yesOrNo, NSError *error);
typedef void (^BOAPIDictionaryBlock) (NSDictionary *dataDict, NSError *error);
typedef void (^BOAPIArrayBlock)      (NSDictionary *dataArray, NSError *error);

@interface BOAPI : NSObject

- (void)GET:(NSString *)endpoint withData:(id)data onCompletion:(ABHTTPRequestBlock)complete;

- (void)POST:(NSString *)endpoint withData:(id)data onCompletion:(ABHTTPRequestBlock)complete;

- (void)PUT:(NSString *)endpoint withData:(id)data onCompletion:(ABHTTPRequestBlock)complete;

- (void)DELETE:(NSString *)endpoint withData:(id)data onCompletion:(ABHTTPRequestBlock)complete;

/**
 * Shared instance
 */
+ (instancetype)sharedClient;

@end
