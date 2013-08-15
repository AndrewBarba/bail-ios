//
//  BOAPIRootService.m
//  BailOut
//
//  Created by Andrew Barba on 8/15/13.
//  Copyright (c) 2013 Andrew Barba. All rights reserved.
//

#import "BOAPIRootService.h"

@implementation BOAPIRootService

#pragma mark - Root

- (void)fetchRoot:(BOAPIDictionaryBlock)complete
{
    [[BOAPI sharedClient] GET:BOAPI_ENDPOINT_ROOT withData:nil onCompletion:^(NSDictionary *data, ABHTTPStatusCode statusCode, NSError *error){
        if (statusCode == ABHTTPSuccessfulOK && data) {
            if (complete) complete(data, nil);
        } else {
            if (complete) complete(nil, error);
        }
    }];
}

#pragma mark - Status

- (void)fetchStatus:(BOAPIBooleanBlock)complete
{
    [[BOAPI sharedClient] GET:BOAPI_ENDPOINT_STATUS withData:nil onCompletion:^(NSDictionary *data, ABHTTPStatusCode statusCode, NSError *error){
        if (statusCode == ABHTTPSuccessfulOK && data) {
            if (complete) complete(YES, nil);
        } else {
            if (complete) complete(NO, error);
        }
    }];
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
    static BOAPIRootService *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] _initPrivateInstance];
    });
    return sharedInstance;
}

@end
