//
//  ABHTTPClient.m
//  BailOut
//
//  Created by Andrew Barba on 8/15/13.
//  Copyright (c) 2013 Andrew Barba. All rights reserved.
//

#import "ABHTTPClient.h"

#define ABHTTP_CLIENT_DEBUG 0

#define ABHTTP_METHOD_GET @"GET"
#define ABHTTP_METHOD_POST @"POST"
#define ABHTTP_METHOD_PUT @"PUT"
#define ABHTTP_METHOD_DELETE @"DELETE"

#define ABHTTP_CLIENT_DEFAULT_TIMEOUT 20 // in seconds

@interface ABHTTPClient()

@end

@implementation ABHTTPClient

/*********** PUBLIC METHODS ************/
/***************************************/

#pragma mark - Public Methods

- (void)GET:(NSURL *)url withData:(id)data onCompletion:(ABHTTPRequestBlock)complete
{
    [self performRequest:ABHTTP_METHOD_GET toURL:url withData:data onCompletion:complete];
}

- (void)POST:(NSURL *)url withData:(id)data onCompletion:(ABHTTPRequestBlock)complete
{
    [self performRequest:ABHTTP_METHOD_POST toURL:url withData:data onCompletion:complete];
}

- (void)PUT:(NSURL *)url withData:(id)data onCompletion:(ABHTTPRequestBlock)complete
{
    [self performRequest:ABHTTP_METHOD_PUT toURL:url withData:data onCompletion:complete];
}

- (void)DELETE:(NSURL *)url withData:(id)data onCompletion:(ABHTTPRequestBlock)complete
{
    [self performRequest:ABHTTP_METHOD_DELETE toURL:url withData:data onCompletion:complete];
}

#pragma mark - HTTP Request

- (void)performRequest:(NSString *)verb toURL:(NSURL *)url withData:(id)data onCompletion:(ABHTTPRequestBlock)complete
{
    // add query params
    if ([verb isEqualToString:ABHTTP_METHOD_GET] && data) {
        url = [ABHTTPClient addQueryStringToUrl:url params:data];
    }
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url
                                                                cachePolicy:NSURLCacheStorageAllowedInMemoryOnly
                                                            timeoutInterval:ABHTTP_CLIENT_DEFAULT_TIMEOUT];
    [request setHTTPMethod:verb];
    [request setHTTPShouldUsePipelining:YES];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    if (![verb isEqualToString:ABHTTP_METHOD_GET] && data) { // set request body for non GET requests
        NSError *parseError;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data
                                                           options:0
                                                             error:&parseError];
        if (parseError) {
            if (complete) {
                complete(nil, ABHTTPRequestParseError, parseError);
            }
        } else {
            [request setHTTPBody:jsonData];
        }
    }
    
    // Setup background queue
    NSOperationQueue *requestQueue = [[NSOperationQueue alloc] init];
    
    // Copy the completion block
    __block ABHTTPRequestBlock copyCompletion = [complete copy];
    
#if ABHTTP_CLIENT_DEBUG
    NSLog(@"HTTP Client: %@",[url absoluteString]);
#endif
    
    [NSURLConnection sendAsynchronousRequest:request queue:requestQueue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        ABHTTPStatusCode statusCode = [httpResponse statusCode];
        if (error) {
            copyCompletion(nil, statusCode, error);
        } else if (statusCode >= 400) {
            NSError *requestError = [[NSError alloc] initWithDomain:@"HTTPClient" code:statusCode userInfo:nil];
            copyCompletion(nil, statusCode, requestError);
        } else {
            NSError *parseError;
            id jsonObject = [NSJSONSerialization JSONObjectWithData:data
                                                            options:NSJSONReadingMutableContainers
                                                              error:&parseError];
            if (parseError) {
                ABDispatchMain(^{
                    copyCompletion(nil, ABHTTPResponseParseError, parseError);
                });
            } else {
                ABDispatchMain(^{
                    copyCompletion(jsonObject, statusCode, nil);
                });
            }
        }
        ABDispatchMain(^{
            copyCompletion = nil;
        });
    }];
}

/*********** HELPERS **********/
/******************************/

#pragma mark - Helpers

+ (NSString *)encodeStringForURL:(NSString *)text
{
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
                                                               (CFStringRef)text,
                                                               NULL,
                                                               (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                               kCFStringEncodingUTF8));
}

// Put a query string onto the end of a url
+ (NSURL *)addQueryStringToUrl:(NSURL *)url params:(NSDictionary *)params {
	NSMutableString *urlWithQuerystring = [[url absoluteString] mutableCopy];
	// Convert the params into a query string
	if (params) {
		for(id key in params) {
			NSString *sKey = [key description];
			NSString *sVal = [[params objectForKey:key] description];
			// Do we need to add ?k=v or &k=v ?
			if ([urlWithQuerystring rangeOfString:@"?"].location==NSNotFound) {
				[urlWithQuerystring appendString:@"?"];
			} else {
				[urlWithQuerystring appendString:@"&"];
			}
            [urlWithQuerystring appendFormat:@"%@=%@", [self encodeStringForURL:sKey], [self encodeStringForURL:sVal]];
		}
	}
	return [NSURL URLWithString:urlWithQuerystring];
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
    static ABHTTPClient *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[self alloc] _initPrivateInstance];
    });
    return sharedClient;
}

@end
