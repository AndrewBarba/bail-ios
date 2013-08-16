//
//  BOAPI.m
//  BailOut
//
//  Created by Andrew Barba on 8/15/13.
//  Copyright (c) 2013 Andrew Barba. All rights reserved.
//

#import "BOAPI.h"
#import "BOKeychainService.h"

#define BO_API_ROOT @"https://bail-api.herokuapp.com"

@implementation BOAPI

- (void)GET:(NSString *)endpoint withData:(id)data onCompletion:(ABHTTPRequestBlock)complete
{
    [[ABHTTPClient sharedClient] GET:[self urlForEndpoint:endpoint] withData:data onCompletion:complete];
}

- (void)POST:(NSString *)endpoint withData:(id)data onCompletion:(ABHTTPRequestBlock)complete
{
    [[ABHTTPClient sharedClient] POST:[self urlForEndpoint:endpoint] withData:data onCompletion:complete];
}

- (void)PUT:(NSString *)endpoint withData:(id)data onCompletion:(ABHTTPRequestBlock)complete
{
    [[ABHTTPClient sharedClient] PUT:[self urlForEndpoint:endpoint] withData:data onCompletion:complete];
}

- (void)DELETE:(NSString *)endpoint withData:(id)data onCompletion:(ABHTTPRequestBlock)complete
{
    [[ABHTTPClient sharedClient] DELETE:[self urlForEndpoint:endpoint] withData:data onCompletion:complete];
}

- (NSURL *)urlForEndpoint:(NSString *)endpoint
{
    NSMutableString *path = [NSMutableString stringWithFormat:@"%@/%@", BO_API_ROOT, endpoint];
    
    // append auth if we have it
    NSString *auth = [[BOKeychainService sharedInstance] authToken];
    if (auth) {
        [path appendFormat:@"?auth=%@",auth];
    }
    
    NSURL *url = [NSURL URLWithString:path];
    return url;
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

/*********** SHARED CLIENT ************/
/**************************************/

+ (instancetype)sharedClient
{
    static BOAPI *sharedAPI = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedAPI = [[self alloc] _initPrivateInstance];
    });
    return sharedAPI;
}

@end
