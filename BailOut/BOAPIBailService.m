//
//  BOAPIBailService.m
//  BailOut
//
//  Created by Andrew Barba on 8/16/13.
//  Copyright (c) 2013 Andrew Barba. All rights reserved.
//

#import "BOAPIBailService.h"

@implementation BOAPIBailService

#pragma mark - Bail Me Out

- (void)bailMeOut:(NSTimeInterval)timeout onCompletion:(BOAPIBooleanBlock)complete
{
    NSDictionary *data = nil;
    if (timeout > 0) {
        data = @{ @"timeout" : @(timeout) };
    }
    [[BOAPI sharedClient] POST:BOAPI_ENDPOINT_BAIL
                      withData:data
                  onCompletion:^(NSDictionary *data, ABHTTPStatusCode statusCode, NSError *error){
                      if (complete) {
                          complete(statusCode == ABHTTPSuccessfulOK, error);
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
    static BOAPIBailService *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] _initPrivateInstance];
    });
    return sharedInstance;
}

@end
