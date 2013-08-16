//
//  BOAPIUserService.m
//  BailOut
//
//  Created by Andrew Barba on 8/16/13.
//  Copyright (c) 2013 Andrew Barba. All rights reserved.
//

#import "BOAPIUserService.h"
#import "BOUser.h"

@implementation BOAPIUserService

#pragma mark - Current User

- (void)fetchCurrentUser:(BOAPIRequestBlock)complete
{
    [[BOAPI sharedClient] GET:BOAPI_ENDPOINT_USER withData:nil onCompletion:^(NSDictionary *data, ABHTTPStatusCode statusCode, NSError *error){
        if (statusCode == ABHTTPSuccessfulOK) {
            BOUser *user = [[BOUser alloc] initWithAPIDict:data];
            if (complete) complete(user, nil);
        } else {
            if (complete) complete(nil, error);
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
    static BOAPIUserService *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] _initPrivateInstance];
    });
    return sharedInstance;
}

@end
