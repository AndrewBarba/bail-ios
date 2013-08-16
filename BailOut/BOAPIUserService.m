//
//  BOAPIUserService.m
//  BailOut
//
//  Created by Andrew Barba on 8/16/13.
//  Copyright (c) 2013 Andrew Barba. All rights reserved.
//

#import "BOAPIUserService.h"

@implementation BOAPIUserService

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
