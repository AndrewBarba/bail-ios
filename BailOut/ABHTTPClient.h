//
//  ABHTTPClient.h
//  BailOut
//
//  Created by Andrew Barba on 8/15/13.
//  Copyright (c) 2013 Andrew Barba. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Enum of HTTP 1.1 response status codes.
 */
typedef enum {
    ABHTTPInformationalContinue = 100,
    ABHTTPInformationalSwitchingProtocols = 101,
    
    ABHTTPSuccessfulOK = 200,
    ABHTTPSuccessfulCreated = 201,
    ABHTTPSuccessfulAccepted = 202,
    ABHTTPSuccessfulNonAuthoritativeInformation = 203,
    ABHTTPSuccessfulNoContent = 204,
    ABHTTPSuccessfulResetContent = 205,
    ABHTTPSuccessfulPartialContent = 206,
    
    ABHTTPRedirectionMultipleChoices = 300,
    ABHTTPRedirectionMovedPermanently = 301,
    ABHTTPRedirectionFound = 302,
    ABHTTPRedirectionSeeOther = 303,
    ABHTTPRedirectionNotModified = 304,
    ABHTTPRedirectionUseProxy = 305,
    ABHTTPRedirectionTemporaryRedirect = 307,
    
    ABHTTPClientErrorBadRequest = 400,
    ABHTTPClientErrorUnauthorized = 401,
    ABHTTPClientErrorPaymentRequired = 402,
    ABHTTPClientErrorForbidden = 403,
    ABHTTPClientErrorNotFound = 404,
    ABHTTPClientErrorMethodNotAllowed = 405,
    ABHTTPClientErrorNotAcceptable = 406,
    ABHTTPClientErrorProxyAuthenticationRequired = 407,
    ABHTTPClientErrorRequestTimeout = 408,
    ABHTTPClientErrorConflict = 409,
    ABHTTPClientErrorGone = 410,
    ABHTTPClientErrorLengthRequired = 411,
    ABHTTPClientErrorPreconditionFailed = 412,
    ABHTTPClientErrorRequestEntityTooLarge = 413,
    ABHTTPClientErrorRequestURITooLong = 414,
    ABHTTPClientErrorUnsupportedMediaType = 415,
    ABHTTPClientErrorRequestedRangeNotSatisfiable = 416,
    ABHTTPClientErrorExpectationFailed = 417,
    ABHTTPClientErrorCustomMessage = 470,
    
    ABHTTPServerErrorInternalServerError = 500,
    ABHTTPServerErrorNotImplemented = 501,
    ABHTTPServerErrorBadGateway = 502,
    ABHTTPServerErrorServiceUnavailable = 503,
    ABHTTPServerErrorGatewayTimeout = 504,
    ABHTTPServerErrorHTTPVersionNotSupported = 505,
} ABHTTPStatusCode;

/**
 * ABHTTPClient completion block
 */
typedef void (^ABHTTPRequestBlock) (id jsonObject, ABHTTPStatusCode statusCode, NSError *error);

@interface ABHTTPClient : NSObject

/**
 * Sends an HTTP GET Request
 * JSON data is automatically added to url if it exists
 */
- (void)GET:(NSURL *)url withData:(id)data onCompletion:(ABHTTPRequestBlock)complete;

/**
 * Sends an HTTP POST Request
 */
- (void)POST:(NSURL *)url withData:(id)data onCompletion:(ABHTTPRequestBlock)complete;

/**
 * Sends an HTTP PUT Request
 */
- (void)PUT:(NSURL *)url withData:(id)data onCompletion:(ABHTTPRequestBlock)complete;

/**
 * Sends an HTTP DELETE Request
 */
- (void)DELETE:(NSURL *)url withData:(id)data onCompletion:(ABHTTPRequestBlock)complete;

/**
 * Shared instance
 */
+ (instancetype)sharedClient;

@end
